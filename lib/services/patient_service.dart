import 'dart:convert';
import 'package:intl/intl.dart';

import '../db/app_database.dart';
import '../db/daos/patient_dao.dart';

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

  // New fields for the report
  final String? chiefComplaint;
  final String? cytologyReport;
  final String? pathologicalReport;
  final String? colposcopyFindings;
  final String? finalImpression;
  final String? remarks;
  final String? treatmentProvided;
  final String? precautions;
  final String? examiningPhysician;

  // Forensic Examination Fields - stored as a JSON string in DB
  final Map<String, String>? forensicExamination;

  // Examination Images - stored as JSON array of image paths
  final List<String>? examinationImages; // Paths to captured examination images
  final Map<String, dynamic>? imageMetadata; // Image capture metadata (timestamp, settings, etc.)

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
    this.chiefComplaint,
    this.cytologyReport,
    this.pathologicalReport,
    this.colposcopyFindings,
    this.finalImpression,
    this.remarks,
    this.treatmentProvided,
    this.precautions,
    this.examiningPhysician,
    this.forensicExamination,
    this.examinationImages,
    this.imageMetadata,
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
      'chief_complaint': chiefComplaint,
      'cytology_report': cytologyReport,
      'pathological_report': pathologicalReport,
      'colposcopy_findings': colposcopyFindings,
      'final_impression': finalImpression,
      'remarks': remarks,
      'treatment_provided': treatmentProvided,
      'precautions': precautions,
      'examining_physician': examiningPhysician,
      'forensic_examination': forensicExamination != null ? jsonEncode(forensicExamination) : null,
      'examination_images': examinationImages != null ? jsonEncode(examinationImages) : null,
      'image_metadata': imageMetadata != null ? jsonEncode(imageMetadata) : null,
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

    Map<String, String>? decodeForensic(String? json) {
      if (json == null) return null;
      try {
        final decoded = jsonDecode(json);
        if (decoded is Map) {
          return decoded.map((key, value) => MapEntry(key.toString(), value.toString()));
        }
        return null;
      } catch (e) {
        return null;
      }
    }

    List<String>? decodeExaminationImages(String? json) {
      if (json == null) return null;
      try {
        final decoded = jsonDecode(json);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
        return null;
      } catch (e) {
        return null;
      }
    }

    Map<String, dynamic>? decodeImageMetadata(String? json) {
      if (json == null) return null;
      try {
        final decoded = jsonDecode(json);
        if (decoded is Map) {
          return decoded.map((key, value) => MapEntry(key.toString(), value));
        }
        return null;
      } catch (e) {
        return null;
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
      chiefComplaint: map['chief_complaint'],
      cytologyReport: map['cytology_report'],
      pathologicalReport: map['pathological_report'],
      colposcopyFindings: map['colposcopy_findings'],
      finalImpression: map['final_impression'],
      remarks: map['remarks'],
      treatmentProvided: map['treatment_provided'],
      precautions: map['precautions'],
      examiningPhysician: map['examining_physician'],
      forensicExamination: decodeForensic(map['forensic_examination']),
      examinationImages: decodeExaminationImages(map['examination_images']),
      imageMetadata: decodeImageMetadata(map['image_metadata']),
    );
  }
}

class PatientService {
  static final AppDatabase _db = AppDatabase();
  static final PatientDao _dao = PatientDao(_db);

  Future<List<Patient>> getAllPatients() async {
    return _dao.getAllPatients();
  }

  Future<Patient> getPatient(int id) async {
    return _dao.getPatient(id);
  }

  Future<Patient> createPatient(Patient patient) async {
    return _dao.createPatient(patient);
  }

  Future<Patient> updatePatient(int id, Patient patient) async {
    return _dao.updatePatient(id, patient);
  }

  Future<void> deletePatient(int id) async {
    await _dao.deletePatient(id);
  }

  Future<void> insertSamplePatients() async {
    final count = (await _dao.getAllPatients()).length;
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
        await _dao.createPatient(patient);
      }
    }
  }

  Future<void> deleteAllPatients() async {
    await _dao.deleteAllPatients();
  }

  // Add examination image to patient
  Future<void> addExaminationImage(int patientId, String imagePath, Map<String, dynamic>? metadata) async {
    final patient = await getPatientById(patientId);
    if (patient == null) return;

    final currentImages = patient.examinationImages ?? [];
    final currentMetadata = patient.imageMetadata ?? {};
    
    // Add new image path
    currentImages.add(imagePath);
    
    // Add metadata for this image
    if (metadata != null) {
      currentMetadata[imagePath] = metadata;
    }

    await _dao.updateExaminationImages(patientId, currentImages, currentMetadata);
  }

  // Remove examination image from patient
  Future<void> removeExaminationImage(int patientId, String imagePath) async {
    final patient = await getPatientById(patientId);
    if (patient == null) return;

    final currentImages = patient.examinationImages ?? [];
    final currentMetadata = patient.imageMetadata ?? {};
    
    // Remove image path
    currentImages.remove(imagePath);
    
    // Remove metadata for this image
    currentMetadata.remove(imagePath);

    await _dao.updateExaminationImages(patientId, currentImages, currentMetadata);
  }

  // Get all examination images for a patient
  Future<List<String>> getExaminationImages(int patientId) async {
    final patient = await getPatientById(patientId);
    return patient?.examinationImages ?? [];
  }

  // Get patient by ID
  Future<Patient?> getPatientById(int id) async {
    return _dao.getPatientById(id);
  }
} 