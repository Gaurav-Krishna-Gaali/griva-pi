// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PatientsTable extends Patients
    with TableInfo<$PatientsTable, PatientRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _patientNameMeta = const VerificationMeta(
    'patientName',
  );
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
    'patient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfVisitMeta = const VerificationMeta(
    'dateOfVisit',
  );
  @override
  late final GeneratedColumn<String> dateOfVisit = GeneratedColumn<String>(
    'date_of_visit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileNoMeta = const VerificationMeta(
    'mobileNo',
  );
  @override
  late final GeneratedColumn<String> mobileNo = GeneratedColumn<String>(
    'mobile_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referredByMeta = const VerificationMeta(
    'referredBy',
  );
  @override
  late final GeneratedColumn<String> referredBy = GeneratedColumn<String>(
    'referred_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _smokingMeta = const VerificationMeta(
    'smoking',
  );
  @override
  late final GeneratedColumn<String> smoking = GeneratedColumn<String>(
    'smoking',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bloodGroupMeta = const VerificationMeta(
    'bloodGroup',
  );
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
    'blood_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _medicationMeta = const VerificationMeta(
    'medication',
  );
  @override
  late final GeneratedColumn<String> medication = GeneratedColumn<String>(
    'medication',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _menopauseMeta = const VerificationMeta(
    'menopause',
  );
  @override
  late final GeneratedColumn<String> menopause = GeneratedColumn<String>(
    'menopause',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMenstrualDateMeta = const VerificationMeta(
    'lastMenstrualDate',
  );
  @override
  late final GeneratedColumn<String> lastMenstrualDate =
      GeneratedColumn<String>(
        'last_menstrual_date',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sexuallyActiveMeta = const VerificationMeta(
    'sexuallyActive',
  );
  @override
  late final GeneratedColumn<String> sexuallyActive = GeneratedColumn<String>(
    'sexually_active',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contraceptionMeta = const VerificationMeta(
    'contraception',
  );
  @override
  late final GeneratedColumn<String> contraception = GeneratedColumn<String>(
    'contraception',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hivStatusMeta = const VerificationMeta(
    'hivStatus',
  );
  @override
  late final GeneratedColumn<String> hivStatus = GeneratedColumn<String>(
    'hiv_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pregnantMeta = const VerificationMeta(
    'pregnant',
  );
  @override
  late final GeneratedColumn<String> pregnant = GeneratedColumn<String>(
    'pregnant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _liveBirthsMeta = const VerificationMeta(
    'liveBirths',
  );
  @override
  late final GeneratedColumn<int> liveBirths = GeneratedColumn<int>(
    'live_births',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stillBirthsMeta = const VerificationMeta(
    'stillBirths',
  );
  @override
  late final GeneratedColumn<int> stillBirths = GeneratedColumn<int>(
    'still_births',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _abortionsMeta = const VerificationMeta(
    'abortions',
  );
  @override
  late final GeneratedColumn<int> abortions = GeneratedColumn<int>(
    'abortions',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cesareansMeta = const VerificationMeta(
    'cesareans',
  );
  @override
  late final GeneratedColumn<int> cesareans = GeneratedColumn<int>(
    'cesareans',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _miscarriagesMeta = const VerificationMeta(
    'miscarriages',
  );
  @override
  late final GeneratedColumn<int> miscarriages = GeneratedColumn<int>(
    'miscarriages',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpvVaccinationMeta = const VerificationMeta(
    'hpvVaccination',
  );
  @override
  late final GeneratedColumn<String> hpvVaccination = GeneratedColumn<String>(
    'hpv_vaccination',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referralReasonMeta = const VerificationMeta(
    'referralReason',
  );
  @override
  late final GeneratedColumn<String> referralReason = GeneratedColumn<String>(
    'referral_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomsMeta = const VerificationMeta(
    'symptoms',
  );
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
    'symptoms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpvTestMeta = const VerificationMeta(
    'hpvTest',
  );
  @override
  late final GeneratedColumn<String> hpvTest = GeneratedColumn<String>(
    'hpv_test',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpvResultMeta = const VerificationMeta(
    'hpvResult',
  );
  @override
  late final GeneratedColumn<String> hpvResult = GeneratedColumn<String>(
    'hpv_result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpvDateMeta = const VerificationMeta(
    'hpvDate',
  );
  @override
  late final GeneratedColumn<String> hpvDate = GeneratedColumn<String>(
    'hpv_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hcgTestMeta = const VerificationMeta(
    'hcgTest',
  );
  @override
  late final GeneratedColumn<String> hcgTest = GeneratedColumn<String>(
    'hcg_test',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hcgDateMeta = const VerificationMeta(
    'hcgDate',
  );
  @override
  late final GeneratedColumn<String> hcgDate = GeneratedColumn<String>(
    'hcg_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hcgLevelMeta = const VerificationMeta(
    'hcgLevel',
  );
  @override
  late final GeneratedColumn<double> hcgLevel = GeneratedColumn<double>(
    'hcg_level',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _patientSummaryMeta = const VerificationMeta(
    'patientSummary',
  );
  @override
  late final GeneratedColumn<String> patientSummary = GeneratedColumn<String>(
    'patient_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chiefComplaintMeta = const VerificationMeta(
    'chiefComplaint',
  );
  @override
  late final GeneratedColumn<String> chiefComplaint = GeneratedColumn<String>(
    'chief_complaint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cytologyReportMeta = const VerificationMeta(
    'cytologyReport',
  );
  @override
  late final GeneratedColumn<String> cytologyReport = GeneratedColumn<String>(
    'cytology_report',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pathologicalReportMeta =
      const VerificationMeta('pathologicalReport');
  @override
  late final GeneratedColumn<String> pathologicalReport =
      GeneratedColumn<String>(
        'pathological_report',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _colposcopyFindingsMeta =
      const VerificationMeta('colposcopyFindings');
  @override
  late final GeneratedColumn<String> colposcopyFindings =
      GeneratedColumn<String>(
        'colposcopy_findings',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _finalImpressionMeta = const VerificationMeta(
    'finalImpression',
  );
  @override
  late final GeneratedColumn<String> finalImpression = GeneratedColumn<String>(
    'final_impression',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _treatmentProvidedMeta = const VerificationMeta(
    'treatmentProvided',
  );
  @override
  late final GeneratedColumn<String> treatmentProvided =
      GeneratedColumn<String>(
        'treatment_provided',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _precautionsMeta = const VerificationMeta(
    'precautions',
  );
  @override
  late final GeneratedColumn<String> precautions = GeneratedColumn<String>(
    'precautions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examiningPhysicianMeta =
      const VerificationMeta('examiningPhysician');
  @override
  late final GeneratedColumn<String> examiningPhysician =
      GeneratedColumn<String>(
        'examining_physician',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _forensicExaminationMeta =
      const VerificationMeta('forensicExamination');
  @override
  late final GeneratedColumn<String> forensicExamination =
      GeneratedColumn<String>(
        'forensic_examination',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _examinationImagesMeta = const VerificationMeta(
    'examinationImages',
  );
  @override
  late final GeneratedColumn<String> examinationImages =
      GeneratedColumn<String>(
        'examination_images',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _imageMetadataMeta = const VerificationMeta(
    'imageMetadata',
  );
  @override
  late final GeneratedColumn<String> imageMetadata = GeneratedColumn<String>(
    'image_metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientName,
    patientId,
    dateOfBirth,
    dateOfVisit,
    mobileNo,
    email,
    address,
    doctorName,
    referredBy,
    smoking,
    bloodGroup,
    medication,
    allergies,
    menopause,
    lastMenstrualDate,
    sexuallyActive,
    contraception,
    hivStatus,
    pregnant,
    liveBirths,
    stillBirths,
    abortions,
    cesareans,
    miscarriages,
    hpvVaccination,
    referralReason,
    symptoms,
    hpvTest,
    hpvResult,
    hpvDate,
    hcgTest,
    hcgDate,
    hcgLevel,
    patientSummary,
    createdAt,
    updatedAt,
    chiefComplaint,
    cytologyReport,
    pathologicalReport,
    colposcopyFindings,
    finalImpression,
    remarks,
    treatmentProvided,
    precautions,
    examiningPhysician,
    forensicExamination,
    examinationImages,
    imageMetadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatientRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_name')) {
      context.handle(
        _patientNameMeta,
        patientName.isAcceptableOrUnknown(
          data['patient_name']!,
          _patientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('date_of_visit')) {
      context.handle(
        _dateOfVisitMeta,
        dateOfVisit.isAcceptableOrUnknown(
          data['date_of_visit']!,
          _dateOfVisitMeta,
        ),
      );
    }
    if (data.containsKey('mobile_no')) {
      context.handle(
        _mobileNoMeta,
        mobileNo.isAcceptableOrUnknown(data['mobile_no']!, _mobileNoMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileNoMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    }
    if (data.containsKey('referred_by')) {
      context.handle(
        _referredByMeta,
        referredBy.isAcceptableOrUnknown(data['referred_by']!, _referredByMeta),
      );
    }
    if (data.containsKey('smoking')) {
      context.handle(
        _smokingMeta,
        smoking.isAcceptableOrUnknown(data['smoking']!, _smokingMeta),
      );
    }
    if (data.containsKey('blood_group')) {
      context.handle(
        _bloodGroupMeta,
        bloodGroup.isAcceptableOrUnknown(data['blood_group']!, _bloodGroupMeta),
      );
    }
    if (data.containsKey('medication')) {
      context.handle(
        _medicationMeta,
        medication.isAcceptableOrUnknown(data['medication']!, _medicationMeta),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('menopause')) {
      context.handle(
        _menopauseMeta,
        menopause.isAcceptableOrUnknown(data['menopause']!, _menopauseMeta),
      );
    }
    if (data.containsKey('last_menstrual_date')) {
      context.handle(
        _lastMenstrualDateMeta,
        lastMenstrualDate.isAcceptableOrUnknown(
          data['last_menstrual_date']!,
          _lastMenstrualDateMeta,
        ),
      );
    }
    if (data.containsKey('sexually_active')) {
      context.handle(
        _sexuallyActiveMeta,
        sexuallyActive.isAcceptableOrUnknown(
          data['sexually_active']!,
          _sexuallyActiveMeta,
        ),
      );
    }
    if (data.containsKey('contraception')) {
      context.handle(
        _contraceptionMeta,
        contraception.isAcceptableOrUnknown(
          data['contraception']!,
          _contraceptionMeta,
        ),
      );
    }
    if (data.containsKey('hiv_status')) {
      context.handle(
        _hivStatusMeta,
        hivStatus.isAcceptableOrUnknown(data['hiv_status']!, _hivStatusMeta),
      );
    }
    if (data.containsKey('pregnant')) {
      context.handle(
        _pregnantMeta,
        pregnant.isAcceptableOrUnknown(data['pregnant']!, _pregnantMeta),
      );
    }
    if (data.containsKey('live_births')) {
      context.handle(
        _liveBirthsMeta,
        liveBirths.isAcceptableOrUnknown(data['live_births']!, _liveBirthsMeta),
      );
    }
    if (data.containsKey('still_births')) {
      context.handle(
        _stillBirthsMeta,
        stillBirths.isAcceptableOrUnknown(
          data['still_births']!,
          _stillBirthsMeta,
        ),
      );
    }
    if (data.containsKey('abortions')) {
      context.handle(
        _abortionsMeta,
        abortions.isAcceptableOrUnknown(data['abortions']!, _abortionsMeta),
      );
    }
    if (data.containsKey('cesareans')) {
      context.handle(
        _cesareansMeta,
        cesareans.isAcceptableOrUnknown(data['cesareans']!, _cesareansMeta),
      );
    }
    if (data.containsKey('miscarriages')) {
      context.handle(
        _miscarriagesMeta,
        miscarriages.isAcceptableOrUnknown(
          data['miscarriages']!,
          _miscarriagesMeta,
        ),
      );
    }
    if (data.containsKey('hpv_vaccination')) {
      context.handle(
        _hpvVaccinationMeta,
        hpvVaccination.isAcceptableOrUnknown(
          data['hpv_vaccination']!,
          _hpvVaccinationMeta,
        ),
      );
    }
    if (data.containsKey('referral_reason')) {
      context.handle(
        _referralReasonMeta,
        referralReason.isAcceptableOrUnknown(
          data['referral_reason']!,
          _referralReasonMeta,
        ),
      );
    }
    if (data.containsKey('symptoms')) {
      context.handle(
        _symptomsMeta,
        symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta),
      );
    }
    if (data.containsKey('hpv_test')) {
      context.handle(
        _hpvTestMeta,
        hpvTest.isAcceptableOrUnknown(data['hpv_test']!, _hpvTestMeta),
      );
    }
    if (data.containsKey('hpv_result')) {
      context.handle(
        _hpvResultMeta,
        hpvResult.isAcceptableOrUnknown(data['hpv_result']!, _hpvResultMeta),
      );
    }
    if (data.containsKey('hpv_date')) {
      context.handle(
        _hpvDateMeta,
        hpvDate.isAcceptableOrUnknown(data['hpv_date']!, _hpvDateMeta),
      );
    }
    if (data.containsKey('hcg_test')) {
      context.handle(
        _hcgTestMeta,
        hcgTest.isAcceptableOrUnknown(data['hcg_test']!, _hcgTestMeta),
      );
    }
    if (data.containsKey('hcg_date')) {
      context.handle(
        _hcgDateMeta,
        hcgDate.isAcceptableOrUnknown(data['hcg_date']!, _hcgDateMeta),
      );
    }
    if (data.containsKey('hcg_level')) {
      context.handle(
        _hcgLevelMeta,
        hcgLevel.isAcceptableOrUnknown(data['hcg_level']!, _hcgLevelMeta),
      );
    }
    if (data.containsKey('patient_summary')) {
      context.handle(
        _patientSummaryMeta,
        patientSummary.isAcceptableOrUnknown(
          data['patient_summary']!,
          _patientSummaryMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('chief_complaint')) {
      context.handle(
        _chiefComplaintMeta,
        chiefComplaint.isAcceptableOrUnknown(
          data['chief_complaint']!,
          _chiefComplaintMeta,
        ),
      );
    }
    if (data.containsKey('cytology_report')) {
      context.handle(
        _cytologyReportMeta,
        cytologyReport.isAcceptableOrUnknown(
          data['cytology_report']!,
          _cytologyReportMeta,
        ),
      );
    }
    if (data.containsKey('pathological_report')) {
      context.handle(
        _pathologicalReportMeta,
        pathologicalReport.isAcceptableOrUnknown(
          data['pathological_report']!,
          _pathologicalReportMeta,
        ),
      );
    }
    if (data.containsKey('colposcopy_findings')) {
      context.handle(
        _colposcopyFindingsMeta,
        colposcopyFindings.isAcceptableOrUnknown(
          data['colposcopy_findings']!,
          _colposcopyFindingsMeta,
        ),
      );
    }
    if (data.containsKey('final_impression')) {
      context.handle(
        _finalImpressionMeta,
        finalImpression.isAcceptableOrUnknown(
          data['final_impression']!,
          _finalImpressionMeta,
        ),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('treatment_provided')) {
      context.handle(
        _treatmentProvidedMeta,
        treatmentProvided.isAcceptableOrUnknown(
          data['treatment_provided']!,
          _treatmentProvidedMeta,
        ),
      );
    }
    if (data.containsKey('precautions')) {
      context.handle(
        _precautionsMeta,
        precautions.isAcceptableOrUnknown(
          data['precautions']!,
          _precautionsMeta,
        ),
      );
    }
    if (data.containsKey('examining_physician')) {
      context.handle(
        _examiningPhysicianMeta,
        examiningPhysician.isAcceptableOrUnknown(
          data['examining_physician']!,
          _examiningPhysicianMeta,
        ),
      );
    }
    if (data.containsKey('forensic_examination')) {
      context.handle(
        _forensicExaminationMeta,
        forensicExamination.isAcceptableOrUnknown(
          data['forensic_examination']!,
          _forensicExaminationMeta,
        ),
      );
    }
    if (data.containsKey('examination_images')) {
      context.handle(
        _examinationImagesMeta,
        examinationImages.isAcceptableOrUnknown(
          data['examination_images']!,
          _examinationImagesMeta,
        ),
      );
    }
    if (data.containsKey('image_metadata')) {
      context.handle(
        _imageMetadataMeta,
        imageMetadata.isAcceptableOrUnknown(
          data['image_metadata']!,
          _imageMetadataMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      patientName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}patient_name'],
          )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_birth'],
      ),
      dateOfVisit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_visit'],
      ),
      mobileNo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}mobile_no'],
          )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      ),
      referredBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}referred_by'],
      ),
      smoking: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}smoking'],
      ),
      bloodGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_group'],
      ),
      medication: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication'],
      ),
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      ),
      menopause: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}menopause'],
      ),
      lastMenstrualDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_menstrual_date'],
      ),
      sexuallyActive: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sexually_active'],
      ),
      contraception: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contraception'],
      ),
      hivStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hiv_status'],
      ),
      pregnant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pregnant'],
      ),
      liveBirths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}live_births'],
      ),
      stillBirths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}still_births'],
      ),
      abortions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}abortions'],
      ),
      cesareans: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cesareans'],
      ),
      miscarriages: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}miscarriages'],
      ),
      hpvVaccination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hpv_vaccination'],
      ),
      referralReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}referral_reason'],
      ),
      symptoms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms'],
      ),
      hpvTest: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hpv_test'],
      ),
      hpvResult: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hpv_result'],
      ),
      hpvDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hpv_date'],
      ),
      hcgTest: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hcg_test'],
      ),
      hcgDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hcg_date'],
      ),
      hcgLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hcg_level'],
      ),
      patientSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_summary'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
      chiefComplaint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chief_complaint'],
      ),
      cytologyReport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cytology_report'],
      ),
      pathologicalReport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pathological_report'],
      ),
      colposcopyFindings: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}colposcopy_findings'],
      ),
      finalImpression: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}final_impression'],
      ),
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      treatmentProvided: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_provided'],
      ),
      precautions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}precautions'],
      ),
      examiningPhysician: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}examining_physician'],
      ),
      forensicExamination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}forensic_examination'],
      ),
      examinationImages: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}examination_images'],
      ),
      imageMetadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_metadata'],
      ),
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class PatientRow extends DataClass implements Insertable<PatientRow> {
  final int id;
  final String patientName;
  final String? patientId;
  final String? dateOfBirth;
  final String? dateOfVisit;
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
  final String? lastMenstrualDate;
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
  final String? hpvDate;
  final String? hcgTest;
  final String? hcgDate;
  final double? hcgLevel;
  final String? patientSummary;
  final String? createdAt;
  final String? updatedAt;
  final String? chiefComplaint;
  final String? cytologyReport;
  final String? pathologicalReport;
  final String? colposcopyFindings;
  final String? finalImpression;
  final String? remarks;
  final String? treatmentProvided;
  final String? precautions;
  final String? examiningPhysician;

  /// JSON fields, stored as TEXT
  final String? forensicExamination;
  final String? examinationImages;
  final String? imageMetadata;
  const PatientRow({
    required this.id,
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_name'] = Variable<String>(patientName);
    if (!nullToAbsent || patientId != null) {
      map['patient_id'] = Variable<String>(patientId);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || dateOfVisit != null) {
      map['date_of_visit'] = Variable<String>(dateOfVisit);
    }
    map['mobile_no'] = Variable<String>(mobileNo);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || doctorName != null) {
      map['doctor_name'] = Variable<String>(doctorName);
    }
    if (!nullToAbsent || referredBy != null) {
      map['referred_by'] = Variable<String>(referredBy);
    }
    if (!nullToAbsent || smoking != null) {
      map['smoking'] = Variable<String>(smoking);
    }
    if (!nullToAbsent || bloodGroup != null) {
      map['blood_group'] = Variable<String>(bloodGroup);
    }
    if (!nullToAbsent || medication != null) {
      map['medication'] = Variable<String>(medication);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || menopause != null) {
      map['menopause'] = Variable<String>(menopause);
    }
    if (!nullToAbsent || lastMenstrualDate != null) {
      map['last_menstrual_date'] = Variable<String>(lastMenstrualDate);
    }
    if (!nullToAbsent || sexuallyActive != null) {
      map['sexually_active'] = Variable<String>(sexuallyActive);
    }
    if (!nullToAbsent || contraception != null) {
      map['contraception'] = Variable<String>(contraception);
    }
    if (!nullToAbsent || hivStatus != null) {
      map['hiv_status'] = Variable<String>(hivStatus);
    }
    if (!nullToAbsent || pregnant != null) {
      map['pregnant'] = Variable<String>(pregnant);
    }
    if (!nullToAbsent || liveBirths != null) {
      map['live_births'] = Variable<int>(liveBirths);
    }
    if (!nullToAbsent || stillBirths != null) {
      map['still_births'] = Variable<int>(stillBirths);
    }
    if (!nullToAbsent || abortions != null) {
      map['abortions'] = Variable<int>(abortions);
    }
    if (!nullToAbsent || cesareans != null) {
      map['cesareans'] = Variable<int>(cesareans);
    }
    if (!nullToAbsent || miscarriages != null) {
      map['miscarriages'] = Variable<int>(miscarriages);
    }
    if (!nullToAbsent || hpvVaccination != null) {
      map['hpv_vaccination'] = Variable<String>(hpvVaccination);
    }
    if (!nullToAbsent || referralReason != null) {
      map['referral_reason'] = Variable<String>(referralReason);
    }
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    if (!nullToAbsent || hpvTest != null) {
      map['hpv_test'] = Variable<String>(hpvTest);
    }
    if (!nullToAbsent || hpvResult != null) {
      map['hpv_result'] = Variable<String>(hpvResult);
    }
    if (!nullToAbsent || hpvDate != null) {
      map['hpv_date'] = Variable<String>(hpvDate);
    }
    if (!nullToAbsent || hcgTest != null) {
      map['hcg_test'] = Variable<String>(hcgTest);
    }
    if (!nullToAbsent || hcgDate != null) {
      map['hcg_date'] = Variable<String>(hcgDate);
    }
    if (!nullToAbsent || hcgLevel != null) {
      map['hcg_level'] = Variable<double>(hcgLevel);
    }
    if (!nullToAbsent || patientSummary != null) {
      map['patient_summary'] = Variable<String>(patientSummary);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || chiefComplaint != null) {
      map['chief_complaint'] = Variable<String>(chiefComplaint);
    }
    if (!nullToAbsent || cytologyReport != null) {
      map['cytology_report'] = Variable<String>(cytologyReport);
    }
    if (!nullToAbsent || pathologicalReport != null) {
      map['pathological_report'] = Variable<String>(pathologicalReport);
    }
    if (!nullToAbsent || colposcopyFindings != null) {
      map['colposcopy_findings'] = Variable<String>(colposcopyFindings);
    }
    if (!nullToAbsent || finalImpression != null) {
      map['final_impression'] = Variable<String>(finalImpression);
    }
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    if (!nullToAbsent || treatmentProvided != null) {
      map['treatment_provided'] = Variable<String>(treatmentProvided);
    }
    if (!nullToAbsent || precautions != null) {
      map['precautions'] = Variable<String>(precautions);
    }
    if (!nullToAbsent || examiningPhysician != null) {
      map['examining_physician'] = Variable<String>(examiningPhysician);
    }
    if (!nullToAbsent || forensicExamination != null) {
      map['forensic_examination'] = Variable<String>(forensicExamination);
    }
    if (!nullToAbsent || examinationImages != null) {
      map['examination_images'] = Variable<String>(examinationImages);
    }
    if (!nullToAbsent || imageMetadata != null) {
      map['image_metadata'] = Variable<String>(imageMetadata);
    }
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      patientName: Value(patientName),
      patientId:
          patientId == null && nullToAbsent
              ? const Value.absent()
              : Value(patientId),
      dateOfBirth:
          dateOfBirth == null && nullToAbsent
              ? const Value.absent()
              : Value(dateOfBirth),
      dateOfVisit:
          dateOfVisit == null && nullToAbsent
              ? const Value.absent()
              : Value(dateOfVisit),
      mobileNo: Value(mobileNo),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address:
          address == null && nullToAbsent
              ? const Value.absent()
              : Value(address),
      doctorName:
          doctorName == null && nullToAbsent
              ? const Value.absent()
              : Value(doctorName),
      referredBy:
          referredBy == null && nullToAbsent
              ? const Value.absent()
              : Value(referredBy),
      smoking:
          smoking == null && nullToAbsent
              ? const Value.absent()
              : Value(smoking),
      bloodGroup:
          bloodGroup == null && nullToAbsent
              ? const Value.absent()
              : Value(bloodGroup),
      medication:
          medication == null && nullToAbsent
              ? const Value.absent()
              : Value(medication),
      allergies:
          allergies == null && nullToAbsent
              ? const Value.absent()
              : Value(allergies),
      menopause:
          menopause == null && nullToAbsent
              ? const Value.absent()
              : Value(menopause),
      lastMenstrualDate:
          lastMenstrualDate == null && nullToAbsent
              ? const Value.absent()
              : Value(lastMenstrualDate),
      sexuallyActive:
          sexuallyActive == null && nullToAbsent
              ? const Value.absent()
              : Value(sexuallyActive),
      contraception:
          contraception == null && nullToAbsent
              ? const Value.absent()
              : Value(contraception),
      hivStatus:
          hivStatus == null && nullToAbsent
              ? const Value.absent()
              : Value(hivStatus),
      pregnant:
          pregnant == null && nullToAbsent
              ? const Value.absent()
              : Value(pregnant),
      liveBirths:
          liveBirths == null && nullToAbsent
              ? const Value.absent()
              : Value(liveBirths),
      stillBirths:
          stillBirths == null && nullToAbsent
              ? const Value.absent()
              : Value(stillBirths),
      abortions:
          abortions == null && nullToAbsent
              ? const Value.absent()
              : Value(abortions),
      cesareans:
          cesareans == null && nullToAbsent
              ? const Value.absent()
              : Value(cesareans),
      miscarriages:
          miscarriages == null && nullToAbsent
              ? const Value.absent()
              : Value(miscarriages),
      hpvVaccination:
          hpvVaccination == null && nullToAbsent
              ? const Value.absent()
              : Value(hpvVaccination),
      referralReason:
          referralReason == null && nullToAbsent
              ? const Value.absent()
              : Value(referralReason),
      symptoms:
          symptoms == null && nullToAbsent
              ? const Value.absent()
              : Value(symptoms),
      hpvTest:
          hpvTest == null && nullToAbsent
              ? const Value.absent()
              : Value(hpvTest),
      hpvResult:
          hpvResult == null && nullToAbsent
              ? const Value.absent()
              : Value(hpvResult),
      hpvDate:
          hpvDate == null && nullToAbsent
              ? const Value.absent()
              : Value(hpvDate),
      hcgTest:
          hcgTest == null && nullToAbsent
              ? const Value.absent()
              : Value(hcgTest),
      hcgDate:
          hcgDate == null && nullToAbsent
              ? const Value.absent()
              : Value(hcgDate),
      hcgLevel:
          hcgLevel == null && nullToAbsent
              ? const Value.absent()
              : Value(hcgLevel),
      patientSummary:
          patientSummary == null && nullToAbsent
              ? const Value.absent()
              : Value(patientSummary),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
      updatedAt:
          updatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(updatedAt),
      chiefComplaint:
          chiefComplaint == null && nullToAbsent
              ? const Value.absent()
              : Value(chiefComplaint),
      cytologyReport:
          cytologyReport == null && nullToAbsent
              ? const Value.absent()
              : Value(cytologyReport),
      pathologicalReport:
          pathologicalReport == null && nullToAbsent
              ? const Value.absent()
              : Value(pathologicalReport),
      colposcopyFindings:
          colposcopyFindings == null && nullToAbsent
              ? const Value.absent()
              : Value(colposcopyFindings),
      finalImpression:
          finalImpression == null && nullToAbsent
              ? const Value.absent()
              : Value(finalImpression),
      remarks:
          remarks == null && nullToAbsent
              ? const Value.absent()
              : Value(remarks),
      treatmentProvided:
          treatmentProvided == null && nullToAbsent
              ? const Value.absent()
              : Value(treatmentProvided),
      precautions:
          precautions == null && nullToAbsent
              ? const Value.absent()
              : Value(precautions),
      examiningPhysician:
          examiningPhysician == null && nullToAbsent
              ? const Value.absent()
              : Value(examiningPhysician),
      forensicExamination:
          forensicExamination == null && nullToAbsent
              ? const Value.absent()
              : Value(forensicExamination),
      examinationImages:
          examinationImages == null && nullToAbsent
              ? const Value.absent()
              : Value(examinationImages),
      imageMetadata:
          imageMetadata == null && nullToAbsent
              ? const Value.absent()
              : Value(imageMetadata),
    );
  }

  factory PatientRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientRow(
      id: serializer.fromJson<int>(json['id']),
      patientName: serializer.fromJson<String>(json['patientName']),
      patientId: serializer.fromJson<String?>(json['patientId']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      dateOfVisit: serializer.fromJson<String?>(json['dateOfVisit']),
      mobileNo: serializer.fromJson<String>(json['mobileNo']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      doctorName: serializer.fromJson<String?>(json['doctorName']),
      referredBy: serializer.fromJson<String?>(json['referredBy']),
      smoking: serializer.fromJson<String?>(json['smoking']),
      bloodGroup: serializer.fromJson<String?>(json['bloodGroup']),
      medication: serializer.fromJson<String?>(json['medication']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      menopause: serializer.fromJson<String?>(json['menopause']),
      lastMenstrualDate: serializer.fromJson<String?>(
        json['lastMenstrualDate'],
      ),
      sexuallyActive: serializer.fromJson<String?>(json['sexuallyActive']),
      contraception: serializer.fromJson<String?>(json['contraception']),
      hivStatus: serializer.fromJson<String?>(json['hivStatus']),
      pregnant: serializer.fromJson<String?>(json['pregnant']),
      liveBirths: serializer.fromJson<int?>(json['liveBirths']),
      stillBirths: serializer.fromJson<int?>(json['stillBirths']),
      abortions: serializer.fromJson<int?>(json['abortions']),
      cesareans: serializer.fromJson<int?>(json['cesareans']),
      miscarriages: serializer.fromJson<int?>(json['miscarriages']),
      hpvVaccination: serializer.fromJson<String?>(json['hpvVaccination']),
      referralReason: serializer.fromJson<String?>(json['referralReason']),
      symptoms: serializer.fromJson<String?>(json['symptoms']),
      hpvTest: serializer.fromJson<String?>(json['hpvTest']),
      hpvResult: serializer.fromJson<String?>(json['hpvResult']),
      hpvDate: serializer.fromJson<String?>(json['hpvDate']),
      hcgTest: serializer.fromJson<String?>(json['hcgTest']),
      hcgDate: serializer.fromJson<String?>(json['hcgDate']),
      hcgLevel: serializer.fromJson<double?>(json['hcgLevel']),
      patientSummary: serializer.fromJson<String?>(json['patientSummary']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      chiefComplaint: serializer.fromJson<String?>(json['chiefComplaint']),
      cytologyReport: serializer.fromJson<String?>(json['cytologyReport']),
      pathologicalReport: serializer.fromJson<String?>(
        json['pathologicalReport'],
      ),
      colposcopyFindings: serializer.fromJson<String?>(
        json['colposcopyFindings'],
      ),
      finalImpression: serializer.fromJson<String?>(json['finalImpression']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      treatmentProvided: serializer.fromJson<String?>(
        json['treatmentProvided'],
      ),
      precautions: serializer.fromJson<String?>(json['precautions']),
      examiningPhysician: serializer.fromJson<String?>(
        json['examiningPhysician'],
      ),
      forensicExamination: serializer.fromJson<String?>(
        json['forensicExamination'],
      ),
      examinationImages: serializer.fromJson<String?>(
        json['examinationImages'],
      ),
      imageMetadata: serializer.fromJson<String?>(json['imageMetadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientName': serializer.toJson<String>(patientName),
      'patientId': serializer.toJson<String?>(patientId),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'dateOfVisit': serializer.toJson<String?>(dateOfVisit),
      'mobileNo': serializer.toJson<String>(mobileNo),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'doctorName': serializer.toJson<String?>(doctorName),
      'referredBy': serializer.toJson<String?>(referredBy),
      'smoking': serializer.toJson<String?>(smoking),
      'bloodGroup': serializer.toJson<String?>(bloodGroup),
      'medication': serializer.toJson<String?>(medication),
      'allergies': serializer.toJson<String?>(allergies),
      'menopause': serializer.toJson<String?>(menopause),
      'lastMenstrualDate': serializer.toJson<String?>(lastMenstrualDate),
      'sexuallyActive': serializer.toJson<String?>(sexuallyActive),
      'contraception': serializer.toJson<String?>(contraception),
      'hivStatus': serializer.toJson<String?>(hivStatus),
      'pregnant': serializer.toJson<String?>(pregnant),
      'liveBirths': serializer.toJson<int?>(liveBirths),
      'stillBirths': serializer.toJson<int?>(stillBirths),
      'abortions': serializer.toJson<int?>(abortions),
      'cesareans': serializer.toJson<int?>(cesareans),
      'miscarriages': serializer.toJson<int?>(miscarriages),
      'hpvVaccination': serializer.toJson<String?>(hpvVaccination),
      'referralReason': serializer.toJson<String?>(referralReason),
      'symptoms': serializer.toJson<String?>(symptoms),
      'hpvTest': serializer.toJson<String?>(hpvTest),
      'hpvResult': serializer.toJson<String?>(hpvResult),
      'hpvDate': serializer.toJson<String?>(hpvDate),
      'hcgTest': serializer.toJson<String?>(hcgTest),
      'hcgDate': serializer.toJson<String?>(hcgDate),
      'hcgLevel': serializer.toJson<double?>(hcgLevel),
      'patientSummary': serializer.toJson<String?>(patientSummary),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'chiefComplaint': serializer.toJson<String?>(chiefComplaint),
      'cytologyReport': serializer.toJson<String?>(cytologyReport),
      'pathologicalReport': serializer.toJson<String?>(pathologicalReport),
      'colposcopyFindings': serializer.toJson<String?>(colposcopyFindings),
      'finalImpression': serializer.toJson<String?>(finalImpression),
      'remarks': serializer.toJson<String?>(remarks),
      'treatmentProvided': serializer.toJson<String?>(treatmentProvided),
      'precautions': serializer.toJson<String?>(precautions),
      'examiningPhysician': serializer.toJson<String?>(examiningPhysician),
      'forensicExamination': serializer.toJson<String?>(forensicExamination),
      'examinationImages': serializer.toJson<String?>(examinationImages),
      'imageMetadata': serializer.toJson<String?>(imageMetadata),
    };
  }

  PatientRow copyWith({
    int? id,
    String? patientName,
    Value<String?> patientId = const Value.absent(),
    Value<String?> dateOfBirth = const Value.absent(),
    Value<String?> dateOfVisit = const Value.absent(),
    String? mobileNo,
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> doctorName = const Value.absent(),
    Value<String?> referredBy = const Value.absent(),
    Value<String?> smoking = const Value.absent(),
    Value<String?> bloodGroup = const Value.absent(),
    Value<String?> medication = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> menopause = const Value.absent(),
    Value<String?> lastMenstrualDate = const Value.absent(),
    Value<String?> sexuallyActive = const Value.absent(),
    Value<String?> contraception = const Value.absent(),
    Value<String?> hivStatus = const Value.absent(),
    Value<String?> pregnant = const Value.absent(),
    Value<int?> liveBirths = const Value.absent(),
    Value<int?> stillBirths = const Value.absent(),
    Value<int?> abortions = const Value.absent(),
    Value<int?> cesareans = const Value.absent(),
    Value<int?> miscarriages = const Value.absent(),
    Value<String?> hpvVaccination = const Value.absent(),
    Value<String?> referralReason = const Value.absent(),
    Value<String?> symptoms = const Value.absent(),
    Value<String?> hpvTest = const Value.absent(),
    Value<String?> hpvResult = const Value.absent(),
    Value<String?> hpvDate = const Value.absent(),
    Value<String?> hcgTest = const Value.absent(),
    Value<String?> hcgDate = const Value.absent(),
    Value<double?> hcgLevel = const Value.absent(),
    Value<String?> patientSummary = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
    Value<String?> chiefComplaint = const Value.absent(),
    Value<String?> cytologyReport = const Value.absent(),
    Value<String?> pathologicalReport = const Value.absent(),
    Value<String?> colposcopyFindings = const Value.absent(),
    Value<String?> finalImpression = const Value.absent(),
    Value<String?> remarks = const Value.absent(),
    Value<String?> treatmentProvided = const Value.absent(),
    Value<String?> precautions = const Value.absent(),
    Value<String?> examiningPhysician = const Value.absent(),
    Value<String?> forensicExamination = const Value.absent(),
    Value<String?> examinationImages = const Value.absent(),
    Value<String?> imageMetadata = const Value.absent(),
  }) => PatientRow(
    id: id ?? this.id,
    patientName: patientName ?? this.patientName,
    patientId: patientId.present ? patientId.value : this.patientId,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    dateOfVisit: dateOfVisit.present ? dateOfVisit.value : this.dateOfVisit,
    mobileNo: mobileNo ?? this.mobileNo,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    doctorName: doctorName.present ? doctorName.value : this.doctorName,
    referredBy: referredBy.present ? referredBy.value : this.referredBy,
    smoking: smoking.present ? smoking.value : this.smoking,
    bloodGroup: bloodGroup.present ? bloodGroup.value : this.bloodGroup,
    medication: medication.present ? medication.value : this.medication,
    allergies: allergies.present ? allergies.value : this.allergies,
    menopause: menopause.present ? menopause.value : this.menopause,
    lastMenstrualDate:
        lastMenstrualDate.present
            ? lastMenstrualDate.value
            : this.lastMenstrualDate,
    sexuallyActive:
        sexuallyActive.present ? sexuallyActive.value : this.sexuallyActive,
    contraception:
        contraception.present ? contraception.value : this.contraception,
    hivStatus: hivStatus.present ? hivStatus.value : this.hivStatus,
    pregnant: pregnant.present ? pregnant.value : this.pregnant,
    liveBirths: liveBirths.present ? liveBirths.value : this.liveBirths,
    stillBirths: stillBirths.present ? stillBirths.value : this.stillBirths,
    abortions: abortions.present ? abortions.value : this.abortions,
    cesareans: cesareans.present ? cesareans.value : this.cesareans,
    miscarriages: miscarriages.present ? miscarriages.value : this.miscarriages,
    hpvVaccination:
        hpvVaccination.present ? hpvVaccination.value : this.hpvVaccination,
    referralReason:
        referralReason.present ? referralReason.value : this.referralReason,
    symptoms: symptoms.present ? symptoms.value : this.symptoms,
    hpvTest: hpvTest.present ? hpvTest.value : this.hpvTest,
    hpvResult: hpvResult.present ? hpvResult.value : this.hpvResult,
    hpvDate: hpvDate.present ? hpvDate.value : this.hpvDate,
    hcgTest: hcgTest.present ? hcgTest.value : this.hcgTest,
    hcgDate: hcgDate.present ? hcgDate.value : this.hcgDate,
    hcgLevel: hcgLevel.present ? hcgLevel.value : this.hcgLevel,
    patientSummary:
        patientSummary.present ? patientSummary.value : this.patientSummary,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    chiefComplaint:
        chiefComplaint.present ? chiefComplaint.value : this.chiefComplaint,
    cytologyReport:
        cytologyReport.present ? cytologyReport.value : this.cytologyReport,
    pathologicalReport:
        pathologicalReport.present
            ? pathologicalReport.value
            : this.pathologicalReport,
    colposcopyFindings:
        colposcopyFindings.present
            ? colposcopyFindings.value
            : this.colposcopyFindings,
    finalImpression:
        finalImpression.present ? finalImpression.value : this.finalImpression,
    remarks: remarks.present ? remarks.value : this.remarks,
    treatmentProvided:
        treatmentProvided.present
            ? treatmentProvided.value
            : this.treatmentProvided,
    precautions: precautions.present ? precautions.value : this.precautions,
    examiningPhysician:
        examiningPhysician.present
            ? examiningPhysician.value
            : this.examiningPhysician,
    forensicExamination:
        forensicExamination.present
            ? forensicExamination.value
            : this.forensicExamination,
    examinationImages:
        examinationImages.present
            ? examinationImages.value
            : this.examinationImages,
    imageMetadata:
        imageMetadata.present ? imageMetadata.value : this.imageMetadata,
  );
  PatientRow copyWithCompanion(PatientsCompanion data) {
    return PatientRow(
      id: data.id.present ? data.id.value : this.id,
      patientName:
          data.patientName.present ? data.patientName.value : this.patientName,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      dateOfVisit:
          data.dateOfVisit.present ? data.dateOfVisit.value : this.dateOfVisit,
      mobileNo: data.mobileNo.present ? data.mobileNo.value : this.mobileNo,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      doctorName:
          data.doctorName.present ? data.doctorName.value : this.doctorName,
      referredBy:
          data.referredBy.present ? data.referredBy.value : this.referredBy,
      smoking: data.smoking.present ? data.smoking.value : this.smoking,
      bloodGroup:
          data.bloodGroup.present ? data.bloodGroup.value : this.bloodGroup,
      medication:
          data.medication.present ? data.medication.value : this.medication,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      menopause: data.menopause.present ? data.menopause.value : this.menopause,
      lastMenstrualDate:
          data.lastMenstrualDate.present
              ? data.lastMenstrualDate.value
              : this.lastMenstrualDate,
      sexuallyActive:
          data.sexuallyActive.present
              ? data.sexuallyActive.value
              : this.sexuallyActive,
      contraception:
          data.contraception.present
              ? data.contraception.value
              : this.contraception,
      hivStatus: data.hivStatus.present ? data.hivStatus.value : this.hivStatus,
      pregnant: data.pregnant.present ? data.pregnant.value : this.pregnant,
      liveBirths:
          data.liveBirths.present ? data.liveBirths.value : this.liveBirths,
      stillBirths:
          data.stillBirths.present ? data.stillBirths.value : this.stillBirths,
      abortions: data.abortions.present ? data.abortions.value : this.abortions,
      cesareans: data.cesareans.present ? data.cesareans.value : this.cesareans,
      miscarriages:
          data.miscarriages.present
              ? data.miscarriages.value
              : this.miscarriages,
      hpvVaccination:
          data.hpvVaccination.present
              ? data.hpvVaccination.value
              : this.hpvVaccination,
      referralReason:
          data.referralReason.present
              ? data.referralReason.value
              : this.referralReason,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      hpvTest: data.hpvTest.present ? data.hpvTest.value : this.hpvTest,
      hpvResult: data.hpvResult.present ? data.hpvResult.value : this.hpvResult,
      hpvDate: data.hpvDate.present ? data.hpvDate.value : this.hpvDate,
      hcgTest: data.hcgTest.present ? data.hcgTest.value : this.hcgTest,
      hcgDate: data.hcgDate.present ? data.hcgDate.value : this.hcgDate,
      hcgLevel: data.hcgLevel.present ? data.hcgLevel.value : this.hcgLevel,
      patientSummary:
          data.patientSummary.present
              ? data.patientSummary.value
              : this.patientSummary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      chiefComplaint:
          data.chiefComplaint.present
              ? data.chiefComplaint.value
              : this.chiefComplaint,
      cytologyReport:
          data.cytologyReport.present
              ? data.cytologyReport.value
              : this.cytologyReport,
      pathologicalReport:
          data.pathologicalReport.present
              ? data.pathologicalReport.value
              : this.pathologicalReport,
      colposcopyFindings:
          data.colposcopyFindings.present
              ? data.colposcopyFindings.value
              : this.colposcopyFindings,
      finalImpression:
          data.finalImpression.present
              ? data.finalImpression.value
              : this.finalImpression,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      treatmentProvided:
          data.treatmentProvided.present
              ? data.treatmentProvided.value
              : this.treatmentProvided,
      precautions:
          data.precautions.present ? data.precautions.value : this.precautions,
      examiningPhysician:
          data.examiningPhysician.present
              ? data.examiningPhysician.value
              : this.examiningPhysician,
      forensicExamination:
          data.forensicExamination.present
              ? data.forensicExamination.value
              : this.forensicExamination,
      examinationImages:
          data.examinationImages.present
              ? data.examinationImages.value
              : this.examinationImages,
      imageMetadata:
          data.imageMetadata.present
              ? data.imageMetadata.value
              : this.imageMetadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientRow(')
          ..write('id: $id, ')
          ..write('patientName: $patientName, ')
          ..write('patientId: $patientId, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('dateOfVisit: $dateOfVisit, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('doctorName: $doctorName, ')
          ..write('referredBy: $referredBy, ')
          ..write('smoking: $smoking, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('medication: $medication, ')
          ..write('allergies: $allergies, ')
          ..write('menopause: $menopause, ')
          ..write('lastMenstrualDate: $lastMenstrualDate, ')
          ..write('sexuallyActive: $sexuallyActive, ')
          ..write('contraception: $contraception, ')
          ..write('hivStatus: $hivStatus, ')
          ..write('pregnant: $pregnant, ')
          ..write('liveBirths: $liveBirths, ')
          ..write('stillBirths: $stillBirths, ')
          ..write('abortions: $abortions, ')
          ..write('cesareans: $cesareans, ')
          ..write('miscarriages: $miscarriages, ')
          ..write('hpvVaccination: $hpvVaccination, ')
          ..write('referralReason: $referralReason, ')
          ..write('symptoms: $symptoms, ')
          ..write('hpvTest: $hpvTest, ')
          ..write('hpvResult: $hpvResult, ')
          ..write('hpvDate: $hpvDate, ')
          ..write('hcgTest: $hcgTest, ')
          ..write('hcgDate: $hcgDate, ')
          ..write('hcgLevel: $hcgLevel, ')
          ..write('patientSummary: $patientSummary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('chiefComplaint: $chiefComplaint, ')
          ..write('cytologyReport: $cytologyReport, ')
          ..write('pathologicalReport: $pathologicalReport, ')
          ..write('colposcopyFindings: $colposcopyFindings, ')
          ..write('finalImpression: $finalImpression, ')
          ..write('remarks: $remarks, ')
          ..write('treatmentProvided: $treatmentProvided, ')
          ..write('precautions: $precautions, ')
          ..write('examiningPhysician: $examiningPhysician, ')
          ..write('forensicExamination: $forensicExamination, ')
          ..write('examinationImages: $examinationImages, ')
          ..write('imageMetadata: $imageMetadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    patientName,
    patientId,
    dateOfBirth,
    dateOfVisit,
    mobileNo,
    email,
    address,
    doctorName,
    referredBy,
    smoking,
    bloodGroup,
    medication,
    allergies,
    menopause,
    lastMenstrualDate,
    sexuallyActive,
    contraception,
    hivStatus,
    pregnant,
    liveBirths,
    stillBirths,
    abortions,
    cesareans,
    miscarriages,
    hpvVaccination,
    referralReason,
    symptoms,
    hpvTest,
    hpvResult,
    hpvDate,
    hcgTest,
    hcgDate,
    hcgLevel,
    patientSummary,
    createdAt,
    updatedAt,
    chiefComplaint,
    cytologyReport,
    pathologicalReport,
    colposcopyFindings,
    finalImpression,
    remarks,
    treatmentProvided,
    precautions,
    examiningPhysician,
    forensicExamination,
    examinationImages,
    imageMetadata,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientRow &&
          other.id == this.id &&
          other.patientName == this.patientName &&
          other.patientId == this.patientId &&
          other.dateOfBirth == this.dateOfBirth &&
          other.dateOfVisit == this.dateOfVisit &&
          other.mobileNo == this.mobileNo &&
          other.email == this.email &&
          other.address == this.address &&
          other.doctorName == this.doctorName &&
          other.referredBy == this.referredBy &&
          other.smoking == this.smoking &&
          other.bloodGroup == this.bloodGroup &&
          other.medication == this.medication &&
          other.allergies == this.allergies &&
          other.menopause == this.menopause &&
          other.lastMenstrualDate == this.lastMenstrualDate &&
          other.sexuallyActive == this.sexuallyActive &&
          other.contraception == this.contraception &&
          other.hivStatus == this.hivStatus &&
          other.pregnant == this.pregnant &&
          other.liveBirths == this.liveBirths &&
          other.stillBirths == this.stillBirths &&
          other.abortions == this.abortions &&
          other.cesareans == this.cesareans &&
          other.miscarriages == this.miscarriages &&
          other.hpvVaccination == this.hpvVaccination &&
          other.referralReason == this.referralReason &&
          other.symptoms == this.symptoms &&
          other.hpvTest == this.hpvTest &&
          other.hpvResult == this.hpvResult &&
          other.hpvDate == this.hpvDate &&
          other.hcgTest == this.hcgTest &&
          other.hcgDate == this.hcgDate &&
          other.hcgLevel == this.hcgLevel &&
          other.patientSummary == this.patientSummary &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.chiefComplaint == this.chiefComplaint &&
          other.cytologyReport == this.cytologyReport &&
          other.pathologicalReport == this.pathologicalReport &&
          other.colposcopyFindings == this.colposcopyFindings &&
          other.finalImpression == this.finalImpression &&
          other.remarks == this.remarks &&
          other.treatmentProvided == this.treatmentProvided &&
          other.precautions == this.precautions &&
          other.examiningPhysician == this.examiningPhysician &&
          other.forensicExamination == this.forensicExamination &&
          other.examinationImages == this.examinationImages &&
          other.imageMetadata == this.imageMetadata);
}

class PatientsCompanion extends UpdateCompanion<PatientRow> {
  final Value<int> id;
  final Value<String> patientName;
  final Value<String?> patientId;
  final Value<String?> dateOfBirth;
  final Value<String?> dateOfVisit;
  final Value<String> mobileNo;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> doctorName;
  final Value<String?> referredBy;
  final Value<String?> smoking;
  final Value<String?> bloodGroup;
  final Value<String?> medication;
  final Value<String?> allergies;
  final Value<String?> menopause;
  final Value<String?> lastMenstrualDate;
  final Value<String?> sexuallyActive;
  final Value<String?> contraception;
  final Value<String?> hivStatus;
  final Value<String?> pregnant;
  final Value<int?> liveBirths;
  final Value<int?> stillBirths;
  final Value<int?> abortions;
  final Value<int?> cesareans;
  final Value<int?> miscarriages;
  final Value<String?> hpvVaccination;
  final Value<String?> referralReason;
  final Value<String?> symptoms;
  final Value<String?> hpvTest;
  final Value<String?> hpvResult;
  final Value<String?> hpvDate;
  final Value<String?> hcgTest;
  final Value<String?> hcgDate;
  final Value<double?> hcgLevel;
  final Value<String?> patientSummary;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> chiefComplaint;
  final Value<String?> cytologyReport;
  final Value<String?> pathologicalReport;
  final Value<String?> colposcopyFindings;
  final Value<String?> finalImpression;
  final Value<String?> remarks;
  final Value<String?> treatmentProvided;
  final Value<String?> precautions;
  final Value<String?> examiningPhysician;
  final Value<String?> forensicExamination;
  final Value<String?> examinationImages;
  final Value<String?> imageMetadata;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.patientName = const Value.absent(),
    this.patientId = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.dateOfVisit = const Value.absent(),
    this.mobileNo = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.referredBy = const Value.absent(),
    this.smoking = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.medication = const Value.absent(),
    this.allergies = const Value.absent(),
    this.menopause = const Value.absent(),
    this.lastMenstrualDate = const Value.absent(),
    this.sexuallyActive = const Value.absent(),
    this.contraception = const Value.absent(),
    this.hivStatus = const Value.absent(),
    this.pregnant = const Value.absent(),
    this.liveBirths = const Value.absent(),
    this.stillBirths = const Value.absent(),
    this.abortions = const Value.absent(),
    this.cesareans = const Value.absent(),
    this.miscarriages = const Value.absent(),
    this.hpvVaccination = const Value.absent(),
    this.referralReason = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.hpvTest = const Value.absent(),
    this.hpvResult = const Value.absent(),
    this.hpvDate = const Value.absent(),
    this.hcgTest = const Value.absent(),
    this.hcgDate = const Value.absent(),
    this.hcgLevel = const Value.absent(),
    this.patientSummary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.chiefComplaint = const Value.absent(),
    this.cytologyReport = const Value.absent(),
    this.pathologicalReport = const Value.absent(),
    this.colposcopyFindings = const Value.absent(),
    this.finalImpression = const Value.absent(),
    this.remarks = const Value.absent(),
    this.treatmentProvided = const Value.absent(),
    this.precautions = const Value.absent(),
    this.examiningPhysician = const Value.absent(),
    this.forensicExamination = const Value.absent(),
    this.examinationImages = const Value.absent(),
    this.imageMetadata = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String patientName,
    this.patientId = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.dateOfVisit = const Value.absent(),
    required String mobileNo,
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.referredBy = const Value.absent(),
    this.smoking = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.medication = const Value.absent(),
    this.allergies = const Value.absent(),
    this.menopause = const Value.absent(),
    this.lastMenstrualDate = const Value.absent(),
    this.sexuallyActive = const Value.absent(),
    this.contraception = const Value.absent(),
    this.hivStatus = const Value.absent(),
    this.pregnant = const Value.absent(),
    this.liveBirths = const Value.absent(),
    this.stillBirths = const Value.absent(),
    this.abortions = const Value.absent(),
    this.cesareans = const Value.absent(),
    this.miscarriages = const Value.absent(),
    this.hpvVaccination = const Value.absent(),
    this.referralReason = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.hpvTest = const Value.absent(),
    this.hpvResult = const Value.absent(),
    this.hpvDate = const Value.absent(),
    this.hcgTest = const Value.absent(),
    this.hcgDate = const Value.absent(),
    this.hcgLevel = const Value.absent(),
    this.patientSummary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.chiefComplaint = const Value.absent(),
    this.cytologyReport = const Value.absent(),
    this.pathologicalReport = const Value.absent(),
    this.colposcopyFindings = const Value.absent(),
    this.finalImpression = const Value.absent(),
    this.remarks = const Value.absent(),
    this.treatmentProvided = const Value.absent(),
    this.precautions = const Value.absent(),
    this.examiningPhysician = const Value.absent(),
    this.forensicExamination = const Value.absent(),
    this.examinationImages = const Value.absent(),
    this.imageMetadata = const Value.absent(),
  }) : patientName = Value(patientName),
       mobileNo = Value(mobileNo);
  static Insertable<PatientRow> custom({
    Expression<int>? id,
    Expression<String>? patientName,
    Expression<String>? patientId,
    Expression<String>? dateOfBirth,
    Expression<String>? dateOfVisit,
    Expression<String>? mobileNo,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? doctorName,
    Expression<String>? referredBy,
    Expression<String>? smoking,
    Expression<String>? bloodGroup,
    Expression<String>? medication,
    Expression<String>? allergies,
    Expression<String>? menopause,
    Expression<String>? lastMenstrualDate,
    Expression<String>? sexuallyActive,
    Expression<String>? contraception,
    Expression<String>? hivStatus,
    Expression<String>? pregnant,
    Expression<int>? liveBirths,
    Expression<int>? stillBirths,
    Expression<int>? abortions,
    Expression<int>? cesareans,
    Expression<int>? miscarriages,
    Expression<String>? hpvVaccination,
    Expression<String>? referralReason,
    Expression<String>? symptoms,
    Expression<String>? hpvTest,
    Expression<String>? hpvResult,
    Expression<String>? hpvDate,
    Expression<String>? hcgTest,
    Expression<String>? hcgDate,
    Expression<double>? hcgLevel,
    Expression<String>? patientSummary,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? chiefComplaint,
    Expression<String>? cytologyReport,
    Expression<String>? pathologicalReport,
    Expression<String>? colposcopyFindings,
    Expression<String>? finalImpression,
    Expression<String>? remarks,
    Expression<String>? treatmentProvided,
    Expression<String>? precautions,
    Expression<String>? examiningPhysician,
    Expression<String>? forensicExamination,
    Expression<String>? examinationImages,
    Expression<String>? imageMetadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientName != null) 'patient_name': patientName,
      if (patientId != null) 'patient_id': patientId,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (dateOfVisit != null) 'date_of_visit': dateOfVisit,
      if (mobileNo != null) 'mobile_no': mobileNo,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (doctorName != null) 'doctor_name': doctorName,
      if (referredBy != null) 'referred_by': referredBy,
      if (smoking != null) 'smoking': smoking,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (medication != null) 'medication': medication,
      if (allergies != null) 'allergies': allergies,
      if (menopause != null) 'menopause': menopause,
      if (lastMenstrualDate != null) 'last_menstrual_date': lastMenstrualDate,
      if (sexuallyActive != null) 'sexually_active': sexuallyActive,
      if (contraception != null) 'contraception': contraception,
      if (hivStatus != null) 'hiv_status': hivStatus,
      if (pregnant != null) 'pregnant': pregnant,
      if (liveBirths != null) 'live_births': liveBirths,
      if (stillBirths != null) 'still_births': stillBirths,
      if (abortions != null) 'abortions': abortions,
      if (cesareans != null) 'cesareans': cesareans,
      if (miscarriages != null) 'miscarriages': miscarriages,
      if (hpvVaccination != null) 'hpv_vaccination': hpvVaccination,
      if (referralReason != null) 'referral_reason': referralReason,
      if (symptoms != null) 'symptoms': symptoms,
      if (hpvTest != null) 'hpv_test': hpvTest,
      if (hpvResult != null) 'hpv_result': hpvResult,
      if (hpvDate != null) 'hpv_date': hpvDate,
      if (hcgTest != null) 'hcg_test': hcgTest,
      if (hcgDate != null) 'hcg_date': hcgDate,
      if (hcgLevel != null) 'hcg_level': hcgLevel,
      if (patientSummary != null) 'patient_summary': patientSummary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (chiefComplaint != null) 'chief_complaint': chiefComplaint,
      if (cytologyReport != null) 'cytology_report': cytologyReport,
      if (pathologicalReport != null) 'pathological_report': pathologicalReport,
      if (colposcopyFindings != null) 'colposcopy_findings': colposcopyFindings,
      if (finalImpression != null) 'final_impression': finalImpression,
      if (remarks != null) 'remarks': remarks,
      if (treatmentProvided != null) 'treatment_provided': treatmentProvided,
      if (precautions != null) 'precautions': precautions,
      if (examiningPhysician != null) 'examining_physician': examiningPhysician,
      if (forensicExamination != null)
        'forensic_examination': forensicExamination,
      if (examinationImages != null) 'examination_images': examinationImages,
      if (imageMetadata != null) 'image_metadata': imageMetadata,
    });
  }

  PatientsCompanion copyWith({
    Value<int>? id,
    Value<String>? patientName,
    Value<String?>? patientId,
    Value<String?>? dateOfBirth,
    Value<String?>? dateOfVisit,
    Value<String>? mobileNo,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? doctorName,
    Value<String?>? referredBy,
    Value<String?>? smoking,
    Value<String?>? bloodGroup,
    Value<String?>? medication,
    Value<String?>? allergies,
    Value<String?>? menopause,
    Value<String?>? lastMenstrualDate,
    Value<String?>? sexuallyActive,
    Value<String?>? contraception,
    Value<String?>? hivStatus,
    Value<String?>? pregnant,
    Value<int?>? liveBirths,
    Value<int?>? stillBirths,
    Value<int?>? abortions,
    Value<int?>? cesareans,
    Value<int?>? miscarriages,
    Value<String?>? hpvVaccination,
    Value<String?>? referralReason,
    Value<String?>? symptoms,
    Value<String?>? hpvTest,
    Value<String?>? hpvResult,
    Value<String?>? hpvDate,
    Value<String?>? hcgTest,
    Value<String?>? hcgDate,
    Value<double?>? hcgLevel,
    Value<String?>? patientSummary,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<String?>? chiefComplaint,
    Value<String?>? cytologyReport,
    Value<String?>? pathologicalReport,
    Value<String?>? colposcopyFindings,
    Value<String?>? finalImpression,
    Value<String?>? remarks,
    Value<String?>? treatmentProvided,
    Value<String?>? precautions,
    Value<String?>? examiningPhysician,
    Value<String?>? forensicExamination,
    Value<String?>? examinationImages,
    Value<String?>? imageMetadata,
  }) {
    return PatientsCompanion(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      patientId: patientId ?? this.patientId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfVisit: dateOfVisit ?? this.dateOfVisit,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      address: address ?? this.address,
      doctorName: doctorName ?? this.doctorName,
      referredBy: referredBy ?? this.referredBy,
      smoking: smoking ?? this.smoking,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      medication: medication ?? this.medication,
      allergies: allergies ?? this.allergies,
      menopause: menopause ?? this.menopause,
      lastMenstrualDate: lastMenstrualDate ?? this.lastMenstrualDate,
      sexuallyActive: sexuallyActive ?? this.sexuallyActive,
      contraception: contraception ?? this.contraception,
      hivStatus: hivStatus ?? this.hivStatus,
      pregnant: pregnant ?? this.pregnant,
      liveBirths: liveBirths ?? this.liveBirths,
      stillBirths: stillBirths ?? this.stillBirths,
      abortions: abortions ?? this.abortions,
      cesareans: cesareans ?? this.cesareans,
      miscarriages: miscarriages ?? this.miscarriages,
      hpvVaccination: hpvVaccination ?? this.hpvVaccination,
      referralReason: referralReason ?? this.referralReason,
      symptoms: symptoms ?? this.symptoms,
      hpvTest: hpvTest ?? this.hpvTest,
      hpvResult: hpvResult ?? this.hpvResult,
      hpvDate: hpvDate ?? this.hpvDate,
      hcgTest: hcgTest ?? this.hcgTest,
      hcgDate: hcgDate ?? this.hcgDate,
      hcgLevel: hcgLevel ?? this.hcgLevel,
      patientSummary: patientSummary ?? this.patientSummary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      chiefComplaint: chiefComplaint ?? this.chiefComplaint,
      cytologyReport: cytologyReport ?? this.cytologyReport,
      pathologicalReport: pathologicalReport ?? this.pathologicalReport,
      colposcopyFindings: colposcopyFindings ?? this.colposcopyFindings,
      finalImpression: finalImpression ?? this.finalImpression,
      remarks: remarks ?? this.remarks,
      treatmentProvided: treatmentProvided ?? this.treatmentProvided,
      precautions: precautions ?? this.precautions,
      examiningPhysician: examiningPhysician ?? this.examiningPhysician,
      forensicExamination: forensicExamination ?? this.forensicExamination,
      examinationImages: examinationImages ?? this.examinationImages,
      imageMetadata: imageMetadata ?? this.imageMetadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (dateOfVisit.present) {
      map['date_of_visit'] = Variable<String>(dateOfVisit.value);
    }
    if (mobileNo.present) {
      map['mobile_no'] = Variable<String>(mobileNo.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (referredBy.present) {
      map['referred_by'] = Variable<String>(referredBy.value);
    }
    if (smoking.present) {
      map['smoking'] = Variable<String>(smoking.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (medication.present) {
      map['medication'] = Variable<String>(medication.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (menopause.present) {
      map['menopause'] = Variable<String>(menopause.value);
    }
    if (lastMenstrualDate.present) {
      map['last_menstrual_date'] = Variable<String>(lastMenstrualDate.value);
    }
    if (sexuallyActive.present) {
      map['sexually_active'] = Variable<String>(sexuallyActive.value);
    }
    if (contraception.present) {
      map['contraception'] = Variable<String>(contraception.value);
    }
    if (hivStatus.present) {
      map['hiv_status'] = Variable<String>(hivStatus.value);
    }
    if (pregnant.present) {
      map['pregnant'] = Variable<String>(pregnant.value);
    }
    if (liveBirths.present) {
      map['live_births'] = Variable<int>(liveBirths.value);
    }
    if (stillBirths.present) {
      map['still_births'] = Variable<int>(stillBirths.value);
    }
    if (abortions.present) {
      map['abortions'] = Variable<int>(abortions.value);
    }
    if (cesareans.present) {
      map['cesareans'] = Variable<int>(cesareans.value);
    }
    if (miscarriages.present) {
      map['miscarriages'] = Variable<int>(miscarriages.value);
    }
    if (hpvVaccination.present) {
      map['hpv_vaccination'] = Variable<String>(hpvVaccination.value);
    }
    if (referralReason.present) {
      map['referral_reason'] = Variable<String>(referralReason.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (hpvTest.present) {
      map['hpv_test'] = Variable<String>(hpvTest.value);
    }
    if (hpvResult.present) {
      map['hpv_result'] = Variable<String>(hpvResult.value);
    }
    if (hpvDate.present) {
      map['hpv_date'] = Variable<String>(hpvDate.value);
    }
    if (hcgTest.present) {
      map['hcg_test'] = Variable<String>(hcgTest.value);
    }
    if (hcgDate.present) {
      map['hcg_date'] = Variable<String>(hcgDate.value);
    }
    if (hcgLevel.present) {
      map['hcg_level'] = Variable<double>(hcgLevel.value);
    }
    if (patientSummary.present) {
      map['patient_summary'] = Variable<String>(patientSummary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (chiefComplaint.present) {
      map['chief_complaint'] = Variable<String>(chiefComplaint.value);
    }
    if (cytologyReport.present) {
      map['cytology_report'] = Variable<String>(cytologyReport.value);
    }
    if (pathologicalReport.present) {
      map['pathological_report'] = Variable<String>(pathologicalReport.value);
    }
    if (colposcopyFindings.present) {
      map['colposcopy_findings'] = Variable<String>(colposcopyFindings.value);
    }
    if (finalImpression.present) {
      map['final_impression'] = Variable<String>(finalImpression.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (treatmentProvided.present) {
      map['treatment_provided'] = Variable<String>(treatmentProvided.value);
    }
    if (precautions.present) {
      map['precautions'] = Variable<String>(precautions.value);
    }
    if (examiningPhysician.present) {
      map['examining_physician'] = Variable<String>(examiningPhysician.value);
    }
    if (forensicExamination.present) {
      map['forensic_examination'] = Variable<String>(forensicExamination.value);
    }
    if (examinationImages.present) {
      map['examination_images'] = Variable<String>(examinationImages.value);
    }
    if (imageMetadata.present) {
      map['image_metadata'] = Variable<String>(imageMetadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('patientName: $patientName, ')
          ..write('patientId: $patientId, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('dateOfVisit: $dateOfVisit, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('doctorName: $doctorName, ')
          ..write('referredBy: $referredBy, ')
          ..write('smoking: $smoking, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('medication: $medication, ')
          ..write('allergies: $allergies, ')
          ..write('menopause: $menopause, ')
          ..write('lastMenstrualDate: $lastMenstrualDate, ')
          ..write('sexuallyActive: $sexuallyActive, ')
          ..write('contraception: $contraception, ')
          ..write('hivStatus: $hivStatus, ')
          ..write('pregnant: $pregnant, ')
          ..write('liveBirths: $liveBirths, ')
          ..write('stillBirths: $stillBirths, ')
          ..write('abortions: $abortions, ')
          ..write('cesareans: $cesareans, ')
          ..write('miscarriages: $miscarriages, ')
          ..write('hpvVaccination: $hpvVaccination, ')
          ..write('referralReason: $referralReason, ')
          ..write('symptoms: $symptoms, ')
          ..write('hpvTest: $hpvTest, ')
          ..write('hpvResult: $hpvResult, ')
          ..write('hpvDate: $hpvDate, ')
          ..write('hcgTest: $hcgTest, ')
          ..write('hcgDate: $hcgDate, ')
          ..write('hcgLevel: $hcgLevel, ')
          ..write('patientSummary: $patientSummary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('chiefComplaint: $chiefComplaint, ')
          ..write('cytologyReport: $cytologyReport, ')
          ..write('pathologicalReport: $pathologicalReport, ')
          ..write('colposcopyFindings: $colposcopyFindings, ')
          ..write('finalImpression: $finalImpression, ')
          ..write('remarks: $remarks, ')
          ..write('treatmentProvided: $treatmentProvided, ')
          ..write('precautions: $precautions, ')
          ..write('examiningPhysician: $examiningPhysician, ')
          ..write('forensicExamination: $forensicExamination, ')
          ..write('examinationImages: $examinationImages, ')
          ..write('imageMetadata: $imageMetadata')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicalLicenseMeta = const VerificationMeta(
    'medicalLicense',
  );
  @override
  late final GeneratedColumn<String> medicalLicense = GeneratedColumn<String>(
    'medical_license',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hospitalMeta = const VerificationMeta(
    'hospital',
  );
  @override
  late final GeneratedColumn<String> hospital = GeneratedColumn<String>(
    'hospital',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastLoginMeta = const VerificationMeta(
    'lastLogin',
  );
  @override
  late final GeneratedColumn<String> lastLogin = GeneratedColumn<String>(
    'last_login',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileImageMeta = const VerificationMeta(
    'profileImage',
  );
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
    'profile_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specializationMeta = const VerificationMeta(
    'specialization',
  );
  @override
  late final GeneratedColumn<String> specialization = GeneratedColumn<String>(
    'specialization',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    email,
    password,
    medicalLicense,
    hospital,
    role,
    isActive,
    lastLogin,
    createdAt,
    updatedAt,
    profileImage,
    phoneNumber,
    specialization,
    department,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('medical_license')) {
      context.handle(
        _medicalLicenseMeta,
        medicalLicense.isAcceptableOrUnknown(
          data['medical_license']!,
          _medicalLicenseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicalLicenseMeta);
    }
    if (data.containsKey('hospital')) {
      context.handle(
        _hospitalMeta,
        hospital.isAcceptableOrUnknown(data['hospital']!, _hospitalMeta),
      );
    } else if (isInserting) {
      context.missing(_hospitalMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_login')) {
      context.handle(
        _lastLoginMeta,
        lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('profile_image')) {
      context.handle(
        _profileImageMeta,
        profileImage.isAcceptableOrUnknown(
          data['profile_image']!,
          _profileImageMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('specialization')) {
      context.handle(
        _specializationMeta,
        specialization.isAcceptableOrUnknown(
          data['specialization']!,
          _specializationMeta,
        ),
      );
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      fullName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}full_name'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      password:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}password'],
          )!,
      medicalLicense:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}medical_license'],
          )!,
      hospital:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hospital'],
          )!,
      role:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}role'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      lastLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_login'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
      profileImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      specialization: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialization'],
      ),
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final int id;
  final String fullName;
  final String email;
  final String password;
  final String medicalLicense;
  final String hospital;
  final String role;
  final bool isActive;
  final String? lastLogin;
  final String? createdAt;
  final String? updatedAt;
  final String? profileImage;
  final String? phoneNumber;
  final String? specialization;
  final String? department;
  const UserRow({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.medicalLicense,
    required this.hospital,
    required this.role,
    required this.isActive,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.profileImage,
    this.phoneNumber,
    this.specialization,
    this.department,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['medical_license'] = Variable<String>(medicalLicense);
    map['hospital'] = Variable<String>(hospital);
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<String>(lastLogin);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || specialization != null) {
      map['specialization'] = Variable<String>(specialization);
    }
    if (!nullToAbsent || department != null) {
      map['department'] = Variable<String>(department);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      fullName: Value(fullName),
      email: Value(email),
      password: Value(password),
      medicalLicense: Value(medicalLicense),
      hospital: Value(hospital),
      role: Value(role),
      isActive: Value(isActive),
      lastLogin:
          lastLogin == null && nullToAbsent
              ? const Value.absent()
              : Value(lastLogin),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
      updatedAt:
          updatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(updatedAt),
      profileImage:
          profileImage == null && nullToAbsent
              ? const Value.absent()
              : Value(profileImage),
      phoneNumber:
          phoneNumber == null && nullToAbsent
              ? const Value.absent()
              : Value(phoneNumber),
      specialization:
          specialization == null && nullToAbsent
              ? const Value.absent()
              : Value(specialization),
      department:
          department == null && nullToAbsent
              ? const Value.absent()
              : Value(department),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      medicalLicense: serializer.fromJson<String>(json['medicalLicense']),
      hospital: serializer.fromJson<String>(json['hospital']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastLogin: serializer.fromJson<String?>(json['lastLogin']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      specialization: serializer.fromJson<String?>(json['specialization']),
      department: serializer.fromJson<String?>(json['department']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'medicalLicense': serializer.toJson<String>(medicalLicense),
      'hospital': serializer.toJson<String>(hospital),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
      'lastLogin': serializer.toJson<String?>(lastLogin),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'profileImage': serializer.toJson<String?>(profileImage),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'specialization': serializer.toJson<String?>(specialization),
      'department': serializer.toJson<String?>(department),
    };
  }

  UserRow copyWith({
    int? id,
    String? fullName,
    String? email,
    String? password,
    String? medicalLicense,
    String? hospital,
    String? role,
    bool? isActive,
    Value<String?> lastLogin = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
    Value<String?> profileImage = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> specialization = const Value.absent(),
    Value<String?> department = const Value.absent(),
  }) => UserRow(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    password: password ?? this.password,
    medicalLicense: medicalLicense ?? this.medicalLicense,
    hospital: hospital ?? this.hospital,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    profileImage: profileImage.present ? profileImage.value : this.profileImage,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    specialization:
        specialization.present ? specialization.value : this.specialization,
    department: department.present ? department.value : this.department,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      medicalLicense:
          data.medicalLicense.present
              ? data.medicalLicense.value
              : this.medicalLicense,
      hospital: data.hospital.present ? data.hospital.value : this.hospital,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      profileImage:
          data.profileImage.present
              ? data.profileImage.value
              : this.profileImage,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      specialization:
          data.specialization.present
              ? data.specialization.value
              : this.specialization,
      department:
          data.department.present ? data.department.value : this.department,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('medicalLicense: $medicalLicense, ')
          ..write('hospital: $hospital, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('profileImage: $profileImage, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('specialization: $specialization, ')
          ..write('department: $department')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    email,
    password,
    medicalLicense,
    hospital,
    role,
    isActive,
    lastLogin,
    createdAt,
    updatedAt,
    profileImage,
    phoneNumber,
    specialization,
    department,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.password == this.password &&
          other.medicalLicense == this.medicalLicense &&
          other.hospital == this.hospital &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.lastLogin == this.lastLogin &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.profileImage == this.profileImage &&
          other.phoneNumber == this.phoneNumber &&
          other.specialization == this.specialization &&
          other.department == this.department);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<String> email;
  final Value<String> password;
  final Value<String> medicalLicense;
  final Value<String> hospital;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<String?> lastLogin;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> profileImage;
  final Value<String?> phoneNumber;
  final Value<String?> specialization;
  final Value<String?> department;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.medicalLicense = const Value.absent(),
    this.hospital = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.specialization = const Value.absent(),
    this.department = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String fullName,
    required String email,
    required String password,
    required String medicalLicense,
    required String hospital,
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.specialization = const Value.absent(),
    this.department = const Value.absent(),
  }) : fullName = Value(fullName),
       email = Value(email),
       password = Value(password),
       medicalLicense = Value(medicalLicense),
       hospital = Value(hospital);
  static Insertable<UserRow> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? medicalLicense,
    Expression<String>? hospital,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<String>? lastLogin,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? profileImage,
    Expression<String>? phoneNumber,
    Expression<String>? specialization,
    Expression<String>? department,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (medicalLicense != null) 'medical_license': medicalLicense,
      if (hospital != null) 'hospital': hospital,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (lastLogin != null) 'last_login': lastLogin,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (profileImage != null) 'profile_image': profileImage,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (specialization != null) 'specialization': specialization,
      if (department != null) 'department': department,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? fullName,
    Value<String>? email,
    Value<String>? password,
    Value<String>? medicalLicense,
    Value<String>? hospital,
    Value<String>? role,
    Value<bool>? isActive,
    Value<String?>? lastLogin,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<String?>? profileImage,
    Value<String?>? phoneNumber,
    Value<String?>? specialization,
    Value<String?>? department,
  }) {
    return UsersCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (medicalLicense.present) {
      map['medical_license'] = Variable<String>(medicalLicense.value);
    }
    if (hospital.present) {
      map['hospital'] = Variable<String>(hospital.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<String>(lastLogin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (specialization.present) {
      map['specialization'] = Variable<String>(specialization.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('medicalLicense: $medicalLicense, ')
          ..write('hospital: $hospital, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('profileImage: $profileImage, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('specialization: $specialization, ')
          ..write('department: $department')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [patients, users];
}

typedef $$PatientsTableCreateCompanionBuilder =
    PatientsCompanion Function({
      Value<int> id,
      required String patientName,
      Value<String?> patientId,
      Value<String?> dateOfBirth,
      Value<String?> dateOfVisit,
      required String mobileNo,
      Value<String?> email,
      Value<String?> address,
      Value<String?> doctorName,
      Value<String?> referredBy,
      Value<String?> smoking,
      Value<String?> bloodGroup,
      Value<String?> medication,
      Value<String?> allergies,
      Value<String?> menopause,
      Value<String?> lastMenstrualDate,
      Value<String?> sexuallyActive,
      Value<String?> contraception,
      Value<String?> hivStatus,
      Value<String?> pregnant,
      Value<int?> liveBirths,
      Value<int?> stillBirths,
      Value<int?> abortions,
      Value<int?> cesareans,
      Value<int?> miscarriages,
      Value<String?> hpvVaccination,
      Value<String?> referralReason,
      Value<String?> symptoms,
      Value<String?> hpvTest,
      Value<String?> hpvResult,
      Value<String?> hpvDate,
      Value<String?> hcgTest,
      Value<String?> hcgDate,
      Value<double?> hcgLevel,
      Value<String?> patientSummary,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> chiefComplaint,
      Value<String?> cytologyReport,
      Value<String?> pathologicalReport,
      Value<String?> colposcopyFindings,
      Value<String?> finalImpression,
      Value<String?> remarks,
      Value<String?> treatmentProvided,
      Value<String?> precautions,
      Value<String?> examiningPhysician,
      Value<String?> forensicExamination,
      Value<String?> examinationImages,
      Value<String?> imageMetadata,
    });
typedef $$PatientsTableUpdateCompanionBuilder =
    PatientsCompanion Function({
      Value<int> id,
      Value<String> patientName,
      Value<String?> patientId,
      Value<String?> dateOfBirth,
      Value<String?> dateOfVisit,
      Value<String> mobileNo,
      Value<String?> email,
      Value<String?> address,
      Value<String?> doctorName,
      Value<String?> referredBy,
      Value<String?> smoking,
      Value<String?> bloodGroup,
      Value<String?> medication,
      Value<String?> allergies,
      Value<String?> menopause,
      Value<String?> lastMenstrualDate,
      Value<String?> sexuallyActive,
      Value<String?> contraception,
      Value<String?> hivStatus,
      Value<String?> pregnant,
      Value<int?> liveBirths,
      Value<int?> stillBirths,
      Value<int?> abortions,
      Value<int?> cesareans,
      Value<int?> miscarriages,
      Value<String?> hpvVaccination,
      Value<String?> referralReason,
      Value<String?> symptoms,
      Value<String?> hpvTest,
      Value<String?> hpvResult,
      Value<String?> hpvDate,
      Value<String?> hcgTest,
      Value<String?> hcgDate,
      Value<double?> hcgLevel,
      Value<String?> patientSummary,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> chiefComplaint,
      Value<String?> cytologyReport,
      Value<String?> pathologicalReport,
      Value<String?> colposcopyFindings,
      Value<String?> finalImpression,
      Value<String?> remarks,
      Value<String?> treatmentProvided,
      Value<String?> precautions,
      Value<String?> examiningPhysician,
      Value<String?> forensicExamination,
      Value<String?> examinationImages,
      Value<String?> imageMetadata,
    });

class $$PatientsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfVisit => $composableBuilder(
    column: $table.dateOfVisit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobileNo => $composableBuilder(
    column: $table.mobileNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referredBy => $composableBuilder(
    column: $table.referredBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smoking => $composableBuilder(
    column: $table.smoking,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodGroup => $composableBuilder(
    column: $table.bloodGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medication => $composableBuilder(
    column: $table.medication,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get menopause => $composableBuilder(
    column: $table.menopause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMenstrualDate => $composableBuilder(
    column: $table.lastMenstrualDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sexuallyActive => $composableBuilder(
    column: $table.sexuallyActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contraception => $composableBuilder(
    column: $table.contraception,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hivStatus => $composableBuilder(
    column: $table.hivStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pregnant => $composableBuilder(
    column: $table.pregnant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get liveBirths => $composableBuilder(
    column: $table.liveBirths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stillBirths => $composableBuilder(
    column: $table.stillBirths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get abortions => $composableBuilder(
    column: $table.abortions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cesareans => $composableBuilder(
    column: $table.cesareans,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get miscarriages => $composableBuilder(
    column: $table.miscarriages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hpvVaccination => $composableBuilder(
    column: $table.hpvVaccination,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referralReason => $composableBuilder(
    column: $table.referralReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hpvTest => $composableBuilder(
    column: $table.hpvTest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hpvResult => $composableBuilder(
    column: $table.hpvResult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hpvDate => $composableBuilder(
    column: $table.hpvDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hcgTest => $composableBuilder(
    column: $table.hcgTest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hcgDate => $composableBuilder(
    column: $table.hcgDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hcgLevel => $composableBuilder(
    column: $table.hcgLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientSummary => $composableBuilder(
    column: $table.patientSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chiefComplaint => $composableBuilder(
    column: $table.chiefComplaint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cytologyReport => $composableBuilder(
    column: $table.cytologyReport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pathologicalReport => $composableBuilder(
    column: $table.pathologicalReport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colposcopyFindings => $composableBuilder(
    column: $table.colposcopyFindings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get finalImpression => $composableBuilder(
    column: $table.finalImpression,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentProvided => $composableBuilder(
    column: $table.treatmentProvided,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get precautions => $composableBuilder(
    column: $table.precautions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examiningPhysician => $composableBuilder(
    column: $table.examiningPhysician,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get forensicExamination => $composableBuilder(
    column: $table.forensicExamination,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examinationImages => $composableBuilder(
    column: $table.examinationImages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageMetadata => $composableBuilder(
    column: $table.imageMetadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfVisit => $composableBuilder(
    column: $table.dateOfVisit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobileNo => $composableBuilder(
    column: $table.mobileNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referredBy => $composableBuilder(
    column: $table.referredBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smoking => $composableBuilder(
    column: $table.smoking,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodGroup => $composableBuilder(
    column: $table.bloodGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medication => $composableBuilder(
    column: $table.medication,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get menopause => $composableBuilder(
    column: $table.menopause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMenstrualDate => $composableBuilder(
    column: $table.lastMenstrualDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sexuallyActive => $composableBuilder(
    column: $table.sexuallyActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contraception => $composableBuilder(
    column: $table.contraception,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hivStatus => $composableBuilder(
    column: $table.hivStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pregnant => $composableBuilder(
    column: $table.pregnant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get liveBirths => $composableBuilder(
    column: $table.liveBirths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stillBirths => $composableBuilder(
    column: $table.stillBirths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get abortions => $composableBuilder(
    column: $table.abortions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cesareans => $composableBuilder(
    column: $table.cesareans,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get miscarriages => $composableBuilder(
    column: $table.miscarriages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hpvVaccination => $composableBuilder(
    column: $table.hpvVaccination,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referralReason => $composableBuilder(
    column: $table.referralReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hpvTest => $composableBuilder(
    column: $table.hpvTest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hpvResult => $composableBuilder(
    column: $table.hpvResult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hpvDate => $composableBuilder(
    column: $table.hpvDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hcgTest => $composableBuilder(
    column: $table.hcgTest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hcgDate => $composableBuilder(
    column: $table.hcgDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hcgLevel => $composableBuilder(
    column: $table.hcgLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientSummary => $composableBuilder(
    column: $table.patientSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chiefComplaint => $composableBuilder(
    column: $table.chiefComplaint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cytologyReport => $composableBuilder(
    column: $table.cytologyReport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pathologicalReport => $composableBuilder(
    column: $table.pathologicalReport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colposcopyFindings => $composableBuilder(
    column: $table.colposcopyFindings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finalImpression => $composableBuilder(
    column: $table.finalImpression,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentProvided => $composableBuilder(
    column: $table.treatmentProvided,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get precautions => $composableBuilder(
    column: $table.precautions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examiningPhysician => $composableBuilder(
    column: $table.examiningPhysician,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get forensicExamination => $composableBuilder(
    column: $table.forensicExamination,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examinationImages => $composableBuilder(
    column: $table.examinationImages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageMetadata => $composableBuilder(
    column: $table.imageMetadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dateOfVisit => $composableBuilder(
    column: $table.dateOfVisit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mobileNo =>
      $composableBuilder(column: $table.mobileNo, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referredBy => $composableBuilder(
    column: $table.referredBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get smoking =>
      $composableBuilder(column: $table.smoking, builder: (column) => column);

  GeneratedColumn<String> get bloodGroup => $composableBuilder(
    column: $table.bloodGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medication => $composableBuilder(
    column: $table.medication,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get menopause =>
      $composableBuilder(column: $table.menopause, builder: (column) => column);

  GeneratedColumn<String> get lastMenstrualDate => $composableBuilder(
    column: $table.lastMenstrualDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sexuallyActive => $composableBuilder(
    column: $table.sexuallyActive,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contraception => $composableBuilder(
    column: $table.contraception,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hivStatus =>
      $composableBuilder(column: $table.hivStatus, builder: (column) => column);

  GeneratedColumn<String> get pregnant =>
      $composableBuilder(column: $table.pregnant, builder: (column) => column);

  GeneratedColumn<int> get liveBirths => $composableBuilder(
    column: $table.liveBirths,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stillBirths => $composableBuilder(
    column: $table.stillBirths,
    builder: (column) => column,
  );

  GeneratedColumn<int> get abortions =>
      $composableBuilder(column: $table.abortions, builder: (column) => column);

  GeneratedColumn<int> get cesareans =>
      $composableBuilder(column: $table.cesareans, builder: (column) => column);

  GeneratedColumn<int> get miscarriages => $composableBuilder(
    column: $table.miscarriages,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hpvVaccination => $composableBuilder(
    column: $table.hpvVaccination,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referralReason => $composableBuilder(
    column: $table.referralReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<String> get hpvTest =>
      $composableBuilder(column: $table.hpvTest, builder: (column) => column);

  GeneratedColumn<String> get hpvResult =>
      $composableBuilder(column: $table.hpvResult, builder: (column) => column);

  GeneratedColumn<String> get hpvDate =>
      $composableBuilder(column: $table.hpvDate, builder: (column) => column);

  GeneratedColumn<String> get hcgTest =>
      $composableBuilder(column: $table.hcgTest, builder: (column) => column);

  GeneratedColumn<String> get hcgDate =>
      $composableBuilder(column: $table.hcgDate, builder: (column) => column);

  GeneratedColumn<double> get hcgLevel =>
      $composableBuilder(column: $table.hcgLevel, builder: (column) => column);

  GeneratedColumn<String> get patientSummary => $composableBuilder(
    column: $table.patientSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get chiefComplaint => $composableBuilder(
    column: $table.chiefComplaint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cytologyReport => $composableBuilder(
    column: $table.cytologyReport,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pathologicalReport => $composableBuilder(
    column: $table.pathologicalReport,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colposcopyFindings => $composableBuilder(
    column: $table.colposcopyFindings,
    builder: (column) => column,
  );

  GeneratedColumn<String> get finalImpression => $composableBuilder(
    column: $table.finalImpression,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get treatmentProvided => $composableBuilder(
    column: $table.treatmentProvided,
    builder: (column) => column,
  );

  GeneratedColumn<String> get precautions => $composableBuilder(
    column: $table.precautions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get examiningPhysician => $composableBuilder(
    column: $table.examiningPhysician,
    builder: (column) => column,
  );

  GeneratedColumn<String> get forensicExamination => $composableBuilder(
    column: $table.forensicExamination,
    builder: (column) => column,
  );

  GeneratedColumn<String> get examinationImages => $composableBuilder(
    column: $table.examinationImages,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageMetadata => $composableBuilder(
    column: $table.imageMetadata,
    builder: (column) => column,
  );
}

class $$PatientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientsTable,
          PatientRow,
          $$PatientsTableFilterComposer,
          $$PatientsTableOrderingComposer,
          $$PatientsTableAnnotationComposer,
          $$PatientsTableCreateCompanionBuilder,
          $$PatientsTableUpdateCompanionBuilder,
          (
            PatientRow,
            BaseReferences<_$AppDatabase, $PatientsTable, PatientRow>,
          ),
          PatientRow,
          PrefetchHooks Function()
        > {
  $$PatientsTableTableManager(_$AppDatabase db, $PatientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> patientName = const Value.absent(),
                Value<String?> patientId = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> dateOfVisit = const Value.absent(),
                Value<String> mobileNo = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                Value<String?> referredBy = const Value.absent(),
                Value<String?> smoking = const Value.absent(),
                Value<String?> bloodGroup = const Value.absent(),
                Value<String?> medication = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> menopause = const Value.absent(),
                Value<String?> lastMenstrualDate = const Value.absent(),
                Value<String?> sexuallyActive = const Value.absent(),
                Value<String?> contraception = const Value.absent(),
                Value<String?> hivStatus = const Value.absent(),
                Value<String?> pregnant = const Value.absent(),
                Value<int?> liveBirths = const Value.absent(),
                Value<int?> stillBirths = const Value.absent(),
                Value<int?> abortions = const Value.absent(),
                Value<int?> cesareans = const Value.absent(),
                Value<int?> miscarriages = const Value.absent(),
                Value<String?> hpvVaccination = const Value.absent(),
                Value<String?> referralReason = const Value.absent(),
                Value<String?> symptoms = const Value.absent(),
                Value<String?> hpvTest = const Value.absent(),
                Value<String?> hpvResult = const Value.absent(),
                Value<String?> hpvDate = const Value.absent(),
                Value<String?> hcgTest = const Value.absent(),
                Value<String?> hcgDate = const Value.absent(),
                Value<double?> hcgLevel = const Value.absent(),
                Value<String?> patientSummary = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> chiefComplaint = const Value.absent(),
                Value<String?> cytologyReport = const Value.absent(),
                Value<String?> pathologicalReport = const Value.absent(),
                Value<String?> colposcopyFindings = const Value.absent(),
                Value<String?> finalImpression = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String?> treatmentProvided = const Value.absent(),
                Value<String?> precautions = const Value.absent(),
                Value<String?> examiningPhysician = const Value.absent(),
                Value<String?> forensicExamination = const Value.absent(),
                Value<String?> examinationImages = const Value.absent(),
                Value<String?> imageMetadata = const Value.absent(),
              }) => PatientsCompanion(
                id: id,
                patientName: patientName,
                patientId: patientId,
                dateOfBirth: dateOfBirth,
                dateOfVisit: dateOfVisit,
                mobileNo: mobileNo,
                email: email,
                address: address,
                doctorName: doctorName,
                referredBy: referredBy,
                smoking: smoking,
                bloodGroup: bloodGroup,
                medication: medication,
                allergies: allergies,
                menopause: menopause,
                lastMenstrualDate: lastMenstrualDate,
                sexuallyActive: sexuallyActive,
                contraception: contraception,
                hivStatus: hivStatus,
                pregnant: pregnant,
                liveBirths: liveBirths,
                stillBirths: stillBirths,
                abortions: abortions,
                cesareans: cesareans,
                miscarriages: miscarriages,
                hpvVaccination: hpvVaccination,
                referralReason: referralReason,
                symptoms: symptoms,
                hpvTest: hpvTest,
                hpvResult: hpvResult,
                hpvDate: hpvDate,
                hcgTest: hcgTest,
                hcgDate: hcgDate,
                hcgLevel: hcgLevel,
                patientSummary: patientSummary,
                createdAt: createdAt,
                updatedAt: updatedAt,
                chiefComplaint: chiefComplaint,
                cytologyReport: cytologyReport,
                pathologicalReport: pathologicalReport,
                colposcopyFindings: colposcopyFindings,
                finalImpression: finalImpression,
                remarks: remarks,
                treatmentProvided: treatmentProvided,
                precautions: precautions,
                examiningPhysician: examiningPhysician,
                forensicExamination: forensicExamination,
                examinationImages: examinationImages,
                imageMetadata: imageMetadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String patientName,
                Value<String?> patientId = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> dateOfVisit = const Value.absent(),
                required String mobileNo,
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                Value<String?> referredBy = const Value.absent(),
                Value<String?> smoking = const Value.absent(),
                Value<String?> bloodGroup = const Value.absent(),
                Value<String?> medication = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> menopause = const Value.absent(),
                Value<String?> lastMenstrualDate = const Value.absent(),
                Value<String?> sexuallyActive = const Value.absent(),
                Value<String?> contraception = const Value.absent(),
                Value<String?> hivStatus = const Value.absent(),
                Value<String?> pregnant = const Value.absent(),
                Value<int?> liveBirths = const Value.absent(),
                Value<int?> stillBirths = const Value.absent(),
                Value<int?> abortions = const Value.absent(),
                Value<int?> cesareans = const Value.absent(),
                Value<int?> miscarriages = const Value.absent(),
                Value<String?> hpvVaccination = const Value.absent(),
                Value<String?> referralReason = const Value.absent(),
                Value<String?> symptoms = const Value.absent(),
                Value<String?> hpvTest = const Value.absent(),
                Value<String?> hpvResult = const Value.absent(),
                Value<String?> hpvDate = const Value.absent(),
                Value<String?> hcgTest = const Value.absent(),
                Value<String?> hcgDate = const Value.absent(),
                Value<double?> hcgLevel = const Value.absent(),
                Value<String?> patientSummary = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> chiefComplaint = const Value.absent(),
                Value<String?> cytologyReport = const Value.absent(),
                Value<String?> pathologicalReport = const Value.absent(),
                Value<String?> colposcopyFindings = const Value.absent(),
                Value<String?> finalImpression = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String?> treatmentProvided = const Value.absent(),
                Value<String?> precautions = const Value.absent(),
                Value<String?> examiningPhysician = const Value.absent(),
                Value<String?> forensicExamination = const Value.absent(),
                Value<String?> examinationImages = const Value.absent(),
                Value<String?> imageMetadata = const Value.absent(),
              }) => PatientsCompanion.insert(
                id: id,
                patientName: patientName,
                patientId: patientId,
                dateOfBirth: dateOfBirth,
                dateOfVisit: dateOfVisit,
                mobileNo: mobileNo,
                email: email,
                address: address,
                doctorName: doctorName,
                referredBy: referredBy,
                smoking: smoking,
                bloodGroup: bloodGroup,
                medication: medication,
                allergies: allergies,
                menopause: menopause,
                lastMenstrualDate: lastMenstrualDate,
                sexuallyActive: sexuallyActive,
                contraception: contraception,
                hivStatus: hivStatus,
                pregnant: pregnant,
                liveBirths: liveBirths,
                stillBirths: stillBirths,
                abortions: abortions,
                cesareans: cesareans,
                miscarriages: miscarriages,
                hpvVaccination: hpvVaccination,
                referralReason: referralReason,
                symptoms: symptoms,
                hpvTest: hpvTest,
                hpvResult: hpvResult,
                hpvDate: hpvDate,
                hcgTest: hcgTest,
                hcgDate: hcgDate,
                hcgLevel: hcgLevel,
                patientSummary: patientSummary,
                createdAt: createdAt,
                updatedAt: updatedAt,
                chiefComplaint: chiefComplaint,
                cytologyReport: cytologyReport,
                pathologicalReport: pathologicalReport,
                colposcopyFindings: colposcopyFindings,
                finalImpression: finalImpression,
                remarks: remarks,
                treatmentProvided: treatmentProvided,
                precautions: precautions,
                examiningPhysician: examiningPhysician,
                forensicExamination: forensicExamination,
                examinationImages: examinationImages,
                imageMetadata: imageMetadata,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PatientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientsTable,
      PatientRow,
      $$PatientsTableFilterComposer,
      $$PatientsTableOrderingComposer,
      $$PatientsTableAnnotationComposer,
      $$PatientsTableCreateCompanionBuilder,
      $$PatientsTableUpdateCompanionBuilder,
      (PatientRow, BaseReferences<_$AppDatabase, $PatientsTable, PatientRow>),
      PatientRow,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String fullName,
      required String email,
      required String password,
      required String medicalLicense,
      required String hospital,
      Value<String> role,
      Value<bool> isActive,
      Value<String?> lastLogin,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> profileImage,
      Value<String?> phoneNumber,
      Value<String?> specialization,
      Value<String?> department,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> fullName,
      Value<String> email,
      Value<String> password,
      Value<String> medicalLicense,
      Value<String> hospital,
      Value<String> role,
      Value<bool> isActive,
      Value<String?> lastLogin,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> profileImage,
      Value<String?> phoneNumber,
      Value<String?> specialization,
      Value<String?> department,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicalLicense => $composableBuilder(
    column: $table.medicalLicense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hospital => $composableBuilder(
    column: $table.hospital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastLogin => $composableBuilder(
    column: $table.lastLogin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialization => $composableBuilder(
    column: $table.specialization,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicalLicense => $composableBuilder(
    column: $table.medicalLicense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hospital => $composableBuilder(
    column: $table.hospital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastLogin => $composableBuilder(
    column: $table.lastLogin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialization => $composableBuilder(
    column: $table.specialization,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get medicalLicense => $composableBuilder(
    column: $table.medicalLicense,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hospital =>
      $composableBuilder(column: $table.hospital, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialization => $composableBuilder(
    column: $table.specialization,
    builder: (column) => column,
  );

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
          UserRow,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> medicalLicense = const Value.absent(),
                Value<String> hospital = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> lastLogin = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> specialization = const Value.absent(),
                Value<String?> department = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                fullName: fullName,
                email: email,
                password: password,
                medicalLicense: medicalLicense,
                hospital: hospital,
                role: role,
                isActive: isActive,
                lastLogin: lastLogin,
                createdAt: createdAt,
                updatedAt: updatedAt,
                profileImage: profileImage,
                phoneNumber: phoneNumber,
                specialization: specialization,
                department: department,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fullName,
                required String email,
                required String password,
                required String medicalLicense,
                required String hospital,
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> lastLogin = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> specialization = const Value.absent(),
                Value<String?> department = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                fullName: fullName,
                email: email,
                password: password,
                medicalLicense: medicalLicense,
                hospital: hospital,
                role: role,
                isActive: isActive,
                lastLogin: lastLogin,
                createdAt: createdAt,
                updatedAt: updatedAt,
                profileImage: profileImage,
                phoneNumber: phoneNumber,
                specialization: specialization,
                department: department,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
      UserRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
