import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class Patient {
  final int? id;
  final String patientName;
  final String? patientId;
  final DateTime? dateOfBirth;
  final DateTime? dateOfVisit;
  final String mobileNo;
  final String? email;
  final String? address;
  final String? doctorName;
  final String? referredBy;
  final String? smoking;
  final String? bloodGroup;
  final String? medication;
  final String? allergies;
  final String? menopause;
  final DateTime? lastMenstrualDate;
  final String? sexuallyActive;
  final String? contraception;
  final String? hivStatus;
  final String? pregnant;
  final int? liveBirths;
  final int? stillBirths;
  final int? abortions;
  final int? cesareans;
  final int? miscarriages;
  final String? hpvVaccination;
  final String? referralReason;
  final String? symptoms;
  final String? hpvTest;
  final String? hpvResult;
  final DateTime? hpvDate;
  final String? hcgTest;
  final DateTime? hcgDate;
  final double? hcgLevel;
  final String? patientSummary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Patient({
    this.id,
    required this.patientName,
    this.patientId,
    this.dateOfBirth,
    this.dateOfVisit,
    required this.mobileNo,
    this.email,
    this.address,
    this.doctorName,
    this.referredBy,
    this.smoking,
    this.bloodGroup,
    this.medication,
    this.allergies,
    this.menopause,
    this.lastMenstrualDate,
    this.sexuallyActive,
    this.contraception,
    this.hivStatus,
    this.pregnant,
    this.liveBirths,
    this.stillBirths,
    this.abortions,
    this.cesareans,
    this.miscarriages,
    this.hpvVaccination,
    this.referralReason,
    this.symptoms,
    this.hpvTest,
    this.hpvResult,
    this.hpvDate,
    this.hcgTest,
    this.hcgDate,
    this.hcgLevel,
    this.patientSummary,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_name': patientName,
      'patient_id': patientId,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'date_of_visit': dateOfVisit?.toIso8601String(),
      'mobile_no': mobileNo,
      'email': email,
      'address': address,
      'doctor_name': doctorName,
      'referred_by': referredBy,
      'smoking': smoking,
      'blood_group': bloodGroup,
      'medication': medication,
      'allergies': allergies,
      'menopause': menopause,
      'last_menstrual_date': lastMenstrualDate?.toIso8601String(),
      'sexually_active': sexuallyActive,
      'contraception': contraception,
      'hiv_status': hivStatus,
      'pregnant': pregnant,
      'live_births': liveBirths,
      'still_births': stillBirths,
      'abortions': abortions,
      'cesareans': cesareans,
      'miscarriages': miscarriages,
      'hpv_vaccination': hpvVaccination,
      'referral_reason': referralReason,
      'symptoms': symptoms,
      'hpv_test': hpvTest,
      'hpv_result': hpvResult,
      'hpv_date': hpvDate?.toIso8601String(),
      'hcg_test': hcgTest,
      'hcg_date': hcgDate?.toIso8601String(),
      'hcg_level': hcgLevel,
      'patient_summary': patientSummary,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
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

    return Patient(
      id: map['id'],
      patientName: map['patient_name'],
      patientId: map['patient_id'],
      dateOfBirth: parseDate(map['date_of_birth']),
      dateOfVisit: parseDate(map['date_of_visit']),
      mobileNo: map['mobile_no'],
      email: map['email'],
      address: map['address'],
      doctorName: map['doctor_name'],
      referredBy: map['referred_by'],
      smoking: map['smoking'],
      bloodGroup: map['blood_group'],
      medication: map['medication'],
      allergies: map['allergies'],
      menopause: map['menopause'],
      lastMenstrualDate: parseDate(map['last_menstrual_date']),
      sexuallyActive: map['sexually_active'],
      contraception: map['contraception'],
      hivStatus: map['hiv_status'],
      pregnant: map['pregnant'],
      liveBirths: map['live_births'],
      stillBirths: map['still_births'],
      abortions: map['abortions'],
      cesareans: map['cesareans'],
      miscarriages: map['miscarriages'],
      hpvVaccination: map['hpv_vaccination'],
      referralReason: map['referral_reason'],
      symptoms: map['symptoms'],
      hpvTest: map['hpv_test'],
      hpvResult: map['hpv_result'],
      hpvDate: parseDate(map['hpv_date']),
      hcgTest: map['hcg_test'],
      hcgDate: parseDate(map['hcg_date']),
      hcgLevel: map['hcg_level']?.toDouble(),
      patientSummary: map['patient_summary'],
      createdAt: parseDate(map['created_at']),
      updatedAt: parseDate(map['updated_at']),
    );
  }
}

class PatientService {
  static Database? _database;
  static const String tableName = 'patients';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'patient_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            patient_name TEXT NOT NULL,
            patient_id TEXT,
            date_of_birth TEXT,
            date_of_visit TEXT,
            mobile_no TEXT NOT NULL,
            email TEXT,
            address TEXT,
            doctor_name TEXT,
            referred_by TEXT,
            smoking TEXT,
            blood_group TEXT,
            medication TEXT,
            allergies TEXT,
            menopause TEXT,
            last_menstrual_date TEXT,
            sexually_active TEXT,
            contraception TEXT,
            hiv_status TEXT,
            pregnant TEXT,
            live_births INTEGER,
            still_births INTEGER,
            abortions INTEGER,
            cesareans INTEGER,
            miscarriages INTEGER,
            hpv_vaccination TEXT,
            referral_reason TEXT,
            symptoms TEXT,
            hpv_test TEXT,
            hpv_result TEXT,
            hpv_date TEXT,
            hcg_test TEXT,
            hcg_date TEXT,
            hcg_level REAL,
            patient_summary TEXT,
            created_at TEXT,
            updated_at TEXT
          )
        ''');
      },
    );
  }

  Future<List<Patient>> getAllPatients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => Patient.fromMap(maps[i]));
  }

  Future<Patient> getPatient(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw Exception('Patient not found');
    }
    return Patient.fromMap(maps.first);
  }

  Future<Patient> createPatient(Patient patient) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();
    final patientMap = patient.toMap()
      ..remove('id')
      ..['created_at'] = now
      ..['updated_at'] = now;

    final id = await db.insert(tableName, patientMap);
    return getPatient(id);
  }

  Future<Patient> updatePatient(int id, Patient patient) async {
    final db = await database;
    final patientMap = patient.toMap()
      ..remove('id')
      ..['updated_at'] = DateTime.now().toIso8601String();

    await db.update(
      tableName,
      patientMap,
      where: 'id = ?',
      whereArgs: [id],
    );
    return getPatient(id);
  }

  Future<void> deletePatient(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertSamplePatients() async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName')) ?? 0;
    if (count == 0) {
      final now = DateTime.now();
      final patients = [
        Patient(
          patientName: 'Alice Smith',
          patientId: 'P001',
          mobileNo: '1234567890',
          dateOfBirth: DateTime(1990, 5, 10),
          dateOfVisit: now,
        ),
        Patient(
          patientName: 'Bob Johnson',
          patientId: 'P002',
          mobileNo: '2345678901',
          dateOfBirth: DateTime(1985, 8, 22),
          dateOfVisit: now,
        ),
        Patient(
          patientName: 'Carol Williams',
          patientId: 'P003',
          mobileNo: '3456789012',
          dateOfBirth: DateTime(1978, 12, 2),
          dateOfVisit: now,
        ),
      ];
      for (final patient in patients) {
        await createPatient(patient);
      }
    }
  }
} 