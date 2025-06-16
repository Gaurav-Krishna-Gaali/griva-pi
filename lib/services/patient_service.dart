import 'dart:convert';
import 'package:http/http.dart' as http;
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

  factory Patient.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr == null) return null;
      try {
        // Try parsing RFC 822 format first
        return DateTime.parse(dateStr);
      } catch (e) {
        try {
          // Try parsing with DateFormat if standard parsing fails
          return DateFormat('yyyy-MM-dd').parse(dateStr);
        } catch (e) {
          return null;
        }
      }
    }

    return Patient(
      id: json['id'],
      patientName: json['patient_name'],
      patientId: json['patient_id'],
      dateOfBirth: parseDate(json['date_of_birth']),
      dateOfVisit: parseDate(json['date_of_visit']),
      mobileNo: json['mobile_no'],
      email: json['email'],
      address: json['address'],
      doctorName: json['doctor_name'],
      referredBy: json['referred_by'],
      smoking: json['smoking'],
      bloodGroup: json['blood_group'],
      medication: json['medication'],
      allergies: json['allergies'],
      menopause: json['menopause'],
      lastMenstrualDate: parseDate(json['last_menstrual_date']),
      sexuallyActive: json['sexually_active'],
      contraception: json['contraception'],
      hivStatus: json['hiv_status'],
      pregnant: json['pregnant'],
      liveBirths: json['live_births'],
      stillBirths: json['still_births'],
      abortions: json['abortions'],
      cesareans: json['cesareans'],
      miscarriages: json['miscarriages'],
      hpvVaccination: json['hpv_vaccination'],
      referralReason: json['referral_reason'],
      symptoms: json['symptoms'],
      hpvTest: json['hpv_test'],
      hpvResult: json['hpv_result'],
      hpvDate: parseDate(json['hpv_date']),
      hcgTest: json['hcg_test'],
      hcgDate: parseDate(json['hcg_date']),
      hcgLevel: json['hcg_level']?.toDouble(),
      patientSummary: json['patient_summary'],
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}

class PatientService {
  // static const String baseUrl = 'http://192.168.1.49:5000/api';
  static const String baseUrl = 'http://localhost:5000/api';

  Future<List<Patient>> getAllPatients() async {
    final response = await http.get(Uri.parse('$baseUrl/patients/'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<Patient> getPatient(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/patients/$id'));
    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load patient');
    }
  }

  Future<Patient> createPatient(Patient patient) async {
    final response = await http.post(
      Uri.parse('$baseUrl/patients/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patient.toJson()),
    );
    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create patient');
    }
  }

  Future<Patient> updatePatient(int id, Patient patient) async {
    final response = await http.put(
      Uri.parse('$baseUrl/patients/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patient.toJson()),
    );
    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update patient');
    }
  }
} 