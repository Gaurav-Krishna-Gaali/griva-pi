import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'patient_service.dart';

class User {
  final int? id;
  final String fullName;
  final String email;
  final String password;
  final String medicalLicense;
  final String hospital;
  final String role; // 'admin', 'doctor', 'pending'
  final bool isActive;
  final DateTime? lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? profileImage;
  final String? phoneNumber;
  final String? specialization;
  final String? department;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.medicalLicense,
    required this.hospital,
    this.role = 'pending',
    this.isActive = false,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.profileImage,
    this.phoneNumber,
    this.specialization,
    this.department,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'medical_license': medicalLicense,
      'hospital': hospital,
      'role': role,
      'is_active': isActive ? 1 : 0,
      'last_login': lastLogin?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'profile_image': profileImage,
      'phone_number': phoneNumber,
      'specialization': specialization,
      'department': department,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr == null) return null;
      try {
        return DateTime.parse(dateStr);
      } catch (e) {
        try {
          return DateFormat('yyyy-MM-dd').parse(dateStr);
        } catch (e) {
          return null;
        }
      }
    }

    return User(
      id: map['id'],
      fullName: map['full_name'],
      email: map['email'],
      password: map['password'],
      medicalLicense: map['medical_license'],
      hospital: map['hospital'],
      role: map['role'] ?? 'pending',
      isActive: map['is_active'] == 1,
      lastLogin: parseDate(map['last_login']),
      createdAt: parseDate(map['created_at']),
      updatedAt: parseDate(map['updated_at']),
      profileImage: map['profile_image'],
      phoneNumber: map['phone_number'],
      specialization: map['specialization'],
      department: map['department'],
    );
  }

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? password,
    String? medicalLicense,
    String? hospital,
    String? role,
    bool? isActive,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? profileImage,
    String? phoneNumber,
    String? specialization,
    String? department,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      medicalLicense: medicalLicense ?? this.medicalLicense,
      hospital: hospital ?? this.hospital,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialization: specialization ?? this.specialization,
      department: department ?? this.department,
    );
  }
}

class UserService {
  static const String tableName = 'users';

  Future<Database> get database async {
    // Use the same database instance as PatientService
    final patientService = PatientService();
    return await patientService.database;
  }

  // Authentication methods
  Future<User?> authenticateUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'email = ? AND password = ? AND is_active = 1',
      whereArgs: [email, password],
    );

    if (maps.isEmpty) return null;
    
    final user = User.fromMap(maps.first);
    
    // Update last login
    await updateLastLogin(user.id!);
    
    return user;
  }

  Future<void> updateLastLogin(int userId) async {
    final db = await database;
    await db.update(
      tableName,
      {'last_login': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // User management methods
  Future<User> createUser(User user) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();
    final userMap = user.toMap()
      ..remove('id')
      ..['created_at'] = now
      ..['updated_at'] = now;

    final id = await db.insert(tableName, userMap);
    return getUser(id);
  }

  Future<User> getUser(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw Exception('User not found');
    }
    return User.fromMap(maps.first);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<List<User>> getPendingUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'role = ?',
      whereArgs: ['pending'],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<User> updateUser(int id, User user) async {
    final db = await database;
    final userMap = user.toMap()
      ..remove('id')
      ..['updated_at'] = DateTime.now().toIso8601String();

    await db.update(
      tableName,
      userMap,
      where: 'id = ?',
      whereArgs: [id],
    );
    return getUser(id);
  }

  Future<void> approveUser(int userId) async {
    final db = await database;
    await db.update(
      tableName,
      {
        'role': 'doctor',
        'is_active': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> rejectUser(int userId) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deactivateUser(int userId) async {
    final db = await database;
    await db.update(
      tableName,
      {
        'is_active': 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty;
  }

  Future<void> changePassword(int userId, String newPassword) async {
    final db = await database;
    await db.update(
      tableName,
      {
        'password': newPassword,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Admin methods
  Future<List<User>> getUsersByRole(String role) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'role = ?',
      whereArgs: [role],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<int> getUserCount() async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName')) ?? 0;
  }

  Future<int> getActiveUserCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableName WHERE is_active = 1')
    ) ?? 0;
  }
} 