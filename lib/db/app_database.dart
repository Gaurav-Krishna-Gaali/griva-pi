import 'package:drift/drift.dart';

import 'connection/connection.dart';
import 'tables/patients.dart';
import 'tables/users.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Patients,
    Users,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();

          // Seed default admin user (equivalent to old sqflite onCreate logic)
          final now = DateTime.now().toIso8601String();
          await into(users).insert(UsersCompanion.insert(
            fullName: 'System Administrator',
            email: 'admin@griva.com',
            password: 'admin123',
            medicalLicense: 'ADMIN001',
            hospital: 'Griva Medical Systems',
            role: const Value('admin'),
            isActive: const Value(true),
            createdAt: Value(now),
            updatedAt: Value(now),
          ));
        },
        onUpgrade: (m, from, to) async {
          // No historical migrations needed yet; placeholder for future schema changes.
        },
      );
}

