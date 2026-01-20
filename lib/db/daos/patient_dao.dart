import 'dart:convert';

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/patients.dart';
import '../../services/patient_service.dart' show Patient;

part 'patient_dao.g.dart';

@DriftAccessor(tables: [Patients])
class PatientDao extends DatabaseAccessor<AppDatabase> with _$PatientDaoMixin {
  PatientDao(AppDatabase db) : super(db);

  Future<List<Patient>> getAllPatients() async {
    final rows =
        await (select(patients)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).get();
    return rows.map(_mapRowToPatient).toList();
  }

  Future<Patient> getPatient(int id) async {
    final row =
        await (select(patients)..where((tbl) => tbl.id.equals(id))).getSingle();
    return _mapRowToPatient(row);
  }

  Future<Patient> createPatient(Patient patient) async {
    final now = DateTime.now().toIso8601String();
    final companion = _mapPatientToCompanion(
      patient,
      createdAt: now,
      updatedAt: now,
      includeId: false,
    );
    final id = await into(patients).insert(companion);
    return getPatient(id);
  }

  Future<Patient> updatePatient(int id, Patient patient) async {
    final now = DateTime.now().toIso8601String();
    final companion = _mapPatientToCompanion(
      patient,
      updatedAt: now,
      includeId: false,
    );
    await (update(patients)..where((tbl) => tbl.id.equals(id))).write(companion);
    return getPatient(id);
  }

  Future<void> deletePatient(int id) async {
    await (delete(patients)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteAllPatients() async {
    await delete(patients).go();
  }

  Future<void> updateExaminationImages(
    int patientId,
    List<String> imagePaths,
    Map<String, dynamic>? metadata,
  ) async {
    final now = DateTime.now().toIso8601String();
    await (update(patients)..where((tbl) => tbl.id.equals(patientId))).write(
      PatientsCompanion(
        examinationImages: Value(jsonEncode(imagePaths)),
        imageMetadata: Value(metadata != null ? jsonEncode(metadata) : null),
        updatedAt: Value(now),
      ),
    );
  }

  Future<Patient?> getPatientById(int id) async {
    final row =
        await (select(patients)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapRowToPatient(row);
  }

  Patient _mapRowToPatient(PatientRow row) {
    DateTime? parseDate(String? value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }

    Map<String, String>? decodeForensic(String? json) {
      if (json == null) return null;
      try {
        final decoded = jsonDecode(json);
        if (decoded is Map) {
          return decoded
              .map((key, value) => MapEntry(key.toString(), value.toString()));
        }
      } catch (_) {}
      return null;
    }

    List<String>? decodeExaminationImages(String? json) {
      if (json == null) return null;
      try {
        final decoded = jsonDecode(json);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
      return null;
    }

    Map<String, dynamic>? decodeImageMetadata(String? json) {
      if (json == null) return null;
      try {
        final decoded = jsonDecode(json);
        if (decoded is Map) {
          return decoded.map((key, value) => MapEntry(key.toString(), value));
        }
      } catch (_) {}
      return null;
    }

    return Patient(
      id: row.id,
      patientName: row.patientName,
      patientId: row.patientId,
      dateOfBirth: parseDate(row.dateOfBirth),
      dateOfVisit: parseDate(row.dateOfVisit),
      mobileNo: row.mobileNo,
      email: row.email,
      address: row.address,
      doctorName: row.doctorName,
      referredBy: row.referredBy,
      smoking: row.smoking,
      bloodGroup: row.bloodGroup,
      medication: row.medication,
      allergies: row.allergies,
      menopause: row.menopause,
      lastMenstrualDate: parseDate(row.lastMenstrualDate),
      sexuallyActive: row.sexuallyActive,
      contraception: row.contraception,
      hivStatus: row.hivStatus,
      pregnant: row.pregnant,
      liveBirths: row.liveBirths,
      stillBirths: row.stillBirths,
      abortions: row.abortions,
      cesareans: row.cesareans,
      miscarriages: row.miscarriages,
      hpvVaccination: row.hpvVaccination,
      referralReason: row.referralReason,
      symptoms: row.symptoms,
      hpvTest: row.hpvTest,
      hpvResult: row.hpvResult,
      hpvDate: parseDate(row.hpvDate),
      hcgTest: row.hcgTest,
      hcgDate: parseDate(row.hcgDate),
      hcgLevel: row.hcgLevel,
      patientSummary: row.patientSummary,
      createdAt: parseDate(row.createdAt),
      updatedAt: parseDate(row.updatedAt),
      chiefComplaint: row.chiefComplaint,
      cytologyReport: row.cytologyReport,
      pathologicalReport: row.pathologicalReport,
      colposcopyFindings: row.colposcopyFindings,
      finalImpression: row.finalImpression,
      remarks: row.remarks,
      treatmentProvided: row.treatmentProvided,
      precautions: row.precautions,
      examiningPhysician: row.examiningPhysician,
      forensicExamination: decodeForensic(row.forensicExamination),
      examinationImages: decodeExaminationImages(row.examinationImages),
      imageMetadata: decodeImageMetadata(row.imageMetadata),
    );
  }

  PatientsCompanion _mapPatientToCompanion(
    Patient patient, {
    String? createdAt,
    String? updatedAt,
    required bool includeId,
  }) {
    return PatientsCompanion(
      id: includeId && patient.id != null ? Value(patient.id!) : const Value.absent(),
      patientName: Value(patient.patientName),
      patientId: Value(patient.patientId),
      dateOfBirth:
          Value(patient.dateOfBirth != null ? patient.dateOfBirth!.toIso8601String() : null),
      dateOfVisit:
          Value(patient.dateOfVisit != null ? patient.dateOfVisit!.toIso8601String() : null),
      mobileNo: Value(patient.mobileNo),
      email: Value(patient.email),
      address: Value(patient.address),
      doctorName: Value(patient.doctorName),
      referredBy: Value(patient.referredBy),
      smoking: Value(patient.smoking),
      bloodGroup: Value(patient.bloodGroup),
      medication: Value(patient.medication),
      allergies: Value(patient.allergies),
      menopause: Value(patient.menopause),
      lastMenstrualDate: Value(patient.lastMenstrualDate != null
          ? patient.lastMenstrualDate!.toIso8601String()
          : null),
      sexuallyActive: Value(patient.sexuallyActive),
      contraception: Value(patient.contraception),
      hivStatus: Value(patient.hivStatus),
      pregnant: Value(patient.pregnant),
      liveBirths: Value(patient.liveBirths),
      stillBirths: Value(patient.stillBirths),
      abortions: Value(patient.abortions),
      cesareans: Value(patient.cesareans),
      miscarriages: Value(patient.miscarriages),
      hpvVaccination: Value(patient.hpvVaccination),
      referralReason: Value(patient.referralReason),
      symptoms: Value(patient.symptoms),
      hpvTest: Value(patient.hpvTest),
      hpvResult: Value(patient.hpvResult),
      hpvDate: Value(
          patient.hpvDate != null ? patient.hpvDate!.toIso8601String() : null),
      hcgTest: Value(patient.hcgTest),
      hcgDate: Value(
          patient.hcgDate != null ? patient.hcgDate!.toIso8601String() : null),
      hcgLevel: Value(patient.hcgLevel),
      patientSummary: Value(patient.patientSummary),
      createdAt: Value(createdAt ?? patient.createdAt?.toIso8601String()),
      updatedAt: Value(updatedAt ?? patient.updatedAt?.toIso8601String()),
      chiefComplaint: Value(patient.chiefComplaint),
      cytologyReport: Value(patient.cytologyReport),
      pathologicalReport: Value(patient.pathologicalReport),
      colposcopyFindings: Value(patient.colposcopyFindings),
      finalImpression: Value(patient.finalImpression),
      remarks: Value(patient.remarks),
      treatmentProvided: Value(patient.treatmentProvided),
      precautions: Value(patient.precautions),
      examiningPhysician: Value(patient.examiningPhysician),
      forensicExamination: Value(patient.forensicExamination != null
          ? jsonEncode(patient.forensicExamination)
          : null),
      examinationImages: Value(patient.examinationImages != null
          ? jsonEncode(patient.examinationImages)
          : null),
      imageMetadata: Value(patient.imageMetadata != null
          ? jsonEncode(patient.imageMetadata)
          : null),
    );
  }
}

