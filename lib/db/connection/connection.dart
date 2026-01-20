import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Opens a Drift [QueryExecutor] in a cross-platform safe way.
///
/// - On mobile platforms, this uses the application documents directory.
/// - On desktop (Windows, Linux, macOS), this also uses the documents directory.
/// The actual SQLite runtime is provided by `sqlite3_flutter_libs`.
LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbDir = Directory(p.join(dir.path, 'db'));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }
    final dbFile = File(p.join(dbDir.path, 'patient_database.db'));
    return NativeDatabase.createInBackground(dbFile);
  });
}

