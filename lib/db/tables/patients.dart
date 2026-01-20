import 'package:drift/drift.dart';

@DataClassName('PatientRow')
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get patientName => text().named('patient_name')();
  TextColumn get patientId => text().named('patient_id').nullable()();

  TextColumn get dateOfBirth => text().named('date_of_birth').nullable()();
  TextColumn get dateOfVisit => text().named('date_of_visit').nullable()();

  TextColumn get mobileNo => text().named('mobile_no')();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();

  TextColumn get doctorName => text().named('doctor_name').nullable()();
  TextColumn get referredBy => text().named('referred_by').nullable()();

  TextColumn get smoking => text().nullable()();
  TextColumn get bloodGroup => text().named('blood_group').nullable()();
  TextColumn get medication => text().nullable()();
  TextColumn get allergies => text().nullable()();
  TextColumn get menopause => text().nullable()();

  TextColumn get lastMenstrualDate =>
      text().named('last_menstrual_date').nullable()();

  TextColumn get sexuallyActive =>
      text().named('sexually_active').nullable()();

  TextColumn get contraception => text().nullable()();
  TextColumn get hivStatus => text().named('hiv_status').nullable()();
  TextColumn get pregnant => text().nullable()();

  IntColumn get liveBirths => integer().named('live_births').nullable()();
  IntColumn get stillBirths => integer().named('still_births').nullable()();
  IntColumn get abortions => integer().nullable()();
  IntColumn get cesareans => integer().nullable()();
  IntColumn get miscarriages => integer().nullable()();

  TextColumn get hpvVaccination =>
      text().named('hpv_vaccination').nullable()();
  TextColumn get referralReason =>
      text().named('referral_reason').nullable()();
  TextColumn get symptoms => text().nullable()();
  TextColumn get hpvTest => text().named('hpv_test').nullable()();
  TextColumn get hpvResult => text().named('hpv_result').nullable()();
  TextColumn get hpvDate => text().named('hpv_date').nullable()();
  TextColumn get hcgTest => text().named('hcg_test').nullable()();
  TextColumn get hcgDate => text().named('hcg_date').nullable()();
  RealColumn get hcgLevel => real().named('hcg_level').nullable()();

  TextColumn get patientSummary =>
      text().named('patient_summary').nullable()();

  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();

  TextColumn get chiefComplaint =>
      text().named('chief_complaint').nullable()();
  TextColumn get cytologyReport =>
      text().named('cytology_report').nullable()();
  TextColumn get pathologicalReport =>
      text().named('pathological_report').nullable()();
  TextColumn get colposcopyFindings =>
      text().named('colposcopy_findings').nullable()();
  TextColumn get finalImpression =>
      text().named('final_impression').nullable()();
  TextColumn get remarks => text().nullable()();
  TextColumn get treatmentProvided =>
      text().named('treatment_provided').nullable()();
  TextColumn get precautions => text().nullable()();
  TextColumn get examiningPhysician =>
      text().named('examining_physician').nullable()();

  /// JSON fields, stored as TEXT
  TextColumn get forensicExamination =>
      text().named('forensic_examination').nullable()();

  TextColumn get examinationImages =>
      text().named('examination_images').nullable()();

  TextColumn get imageMetadata =>
      text().named('image_metadata').nullable()();
}

