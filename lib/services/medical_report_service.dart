import 'dart:typed_data';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'patient_service.dart';

class MedicalReportService {
  static Future<String?> generateComprehensiveReport({
    required Patient patient,
    required List<Uint8List> images,
    String? additionalNotes,
    String? diagnosis,
    String? treatmentPlan,
    String? followUpDate,
  }) async {
    try {
      // Create PDF document
      final pdf = pw.Document();

      // Add title page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue900,
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'COMPREHENSIVE MEDICAL REPORT',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'Colposcopy Examination',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.white,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // Patient Information Section
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'PATIENT INFORMATION',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      _buildInfoRow('Patient Name:', patient.patientName),
                      if (patient.patientId != null) _buildInfoRow('Patient ID:', patient.patientId!),
                      if (patient.dateOfBirth != null) _buildInfoRow('Date of Birth:', _formatDate(patient.dateOfBirth!)),
                      _buildInfoRow('Mobile Number:', patient.mobileNo),
                      if (patient.email != null) _buildInfoRow('Email:', patient.email!),
                      if (patient.address != null) _buildInfoRow('Address:', patient.address!),
                      if (patient.dateOfVisit != null) _buildInfoRow('Date of Visit:', _formatDate(patient.dateOfVisit!)),
                      if (patient.doctorName != null) _buildInfoRow('Doctor:', patient.doctorName!),
                      if (patient.referredBy != null) _buildInfoRow('Referred By:', patient.referredBy!),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // Medical History Section
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'MEDICAL HISTORY',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      if (patient.bloodGroup != null) _buildInfoRow('Blood Group:', patient.bloodGroup!),
                      if (patient.smoking != null) _buildInfoRow('Smoking Status:', patient.smoking!),
                      if (patient.allergies != null) _buildInfoRow('Allergies:', patient.allergies!),
                      if (patient.medication != null) _buildInfoRow('Current Medication:', patient.medication!),
                      if (patient.menopause != null) _buildInfoRow('Menopause Status:', patient.menopause!),
                      if (patient.lastMenstrualDate != null) _buildInfoRow('Last Menstrual Date:', _formatDate(patient.lastMenstrualDate!)),
                      if (patient.sexuallyActive != null) _buildInfoRow('Sexually Active:', patient.sexuallyActive!),
                      if (patient.contraception != null) _buildInfoRow('Contraception:', patient.contraception!),
                      if (patient.hivStatus != null) _buildInfoRow('HIV Status:', patient.hivStatus!),
                      if (patient.pregnant != null) _buildInfoRow('Pregnancy Status:', patient.pregnant!),
                      if (patient.hpvVaccination != null) _buildInfoRow('HPV Vaccination:', patient.hpvVaccination!),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // Obstetric History
                if (_hasObstetricHistory(patient))
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(15),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey300),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'OBSTETRIC HISTORY',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue900,
                          ),
                        ),
                        pw.SizedBox(height: 15),
                        if (patient.liveBirths != null) _buildInfoRow('Live Births:', patient.liveBirths.toString()),
                        if (patient.stillBirths != null) _buildInfoRow('Still Births:', patient.stillBirths.toString()),
                        if (patient.abortions != null) _buildInfoRow('Abortions:', patient.abortions.toString()),
                        if (patient.cesareans != null) _buildInfoRow('Cesareans:', patient.cesareans.toString()),
                        if (patient.miscarriages != null) _buildInfoRow('Miscarriages:', patient.miscarriages.toString()),
                      ],
                    ),
                  ),
                pw.SizedBox(height: 20),

                // Test Results Section
                if (_hasTestResults(patient))
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(15),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey300),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'TEST RESULTS',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue900,
                          ),
                        ),
                        pw.SizedBox(height: 15),
                        if (patient.hpvTest != null) _buildInfoRow('HPV Test:', patient.hpvTest!),
                        if (patient.hpvResult != null) _buildInfoRow('HPV Result:', patient.hpvResult!),
                        if (patient.hpvDate != null) _buildInfoRow('HPV Test Date:', _formatDate(patient.hpvDate!)),
                        if (patient.hcgTest != null) _buildInfoRow('HCG Test:', patient.hcgTest!),
                        if (patient.hcgDate != null) _buildInfoRow('HCG Test Date:', _formatDate(patient.hcgDate!)),
                        if (patient.hcgLevel != null) _buildInfoRow('HCG Level:', patient.hcgLevel.toString()),
                      ],
                    ),
                  ),
                pw.SizedBox(height: 20),

                // Report Generation Info
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Text(
                    'Report generated on: ${_formatDate(DateTime.now())}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Add clinical findings page
      if (diagnosis != null || treatmentPlan != null || additionalNotes != null) {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'CLINICAL FINDINGS & RECOMMENDATIONS',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  if (patient.referralReason != null) ...[
                    pw.Text(
                      'Referral Reason:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(patient.referralReason!),
                    pw.SizedBox(height: 15),
                  ],

                  if (patient.symptoms != null) ...[
                    pw.Text(
                      'Symptoms:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(patient.symptoms!),
                    pw.SizedBox(height: 15),
                  ],

                  if (diagnosis != null) ...[
                    pw.Text(
                      'Diagnosis:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(diagnosis),
                    pw.SizedBox(height: 15),
                  ],

                  if (treatmentPlan != null) ...[
                    pw.Text(
                      'Treatment Plan:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(treatmentPlan),
                    pw.SizedBox(height: 15),
                  ],

                  if (followUpDate != null) ...[
                    pw.Text(
                      'Follow-up Date:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(followUpDate),
                    pw.SizedBox(height: 15),
                  ],

                  if (additionalNotes != null) ...[
                    pw.Text(
                      'Additional Notes:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(additionalNotes),
                  ],
                ],
              );
            },
          ),
        );
      }

      // Add image pages
      for (int i = 0; i < images.length; i++) {
        final imageBytes = images[i];
        final image = pw.MemoryImage(imageBytes);
        
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Text(
                    'COLPOSCOPY IMAGE ${i + 1}',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Expanded(
                    child: pw.Center(
                      child: pw.Image(image, fit: pw.BoxFit.contain),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Image captured on: ${_formatDate(DateTime.now())}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }

      // Get appropriate directory for the platform
      final pdfDir = await _getPdfDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final safePatientName = patient.patientName.replaceAll(RegExp(r'[^\w\s-]'), '_');
      final file = File('$pdfDir/${safePatientName}_comprehensive_report_$timestamp.pdf');

      // Save PDF
      await file.writeAsBytes(await pdf.save());

      return file.path;
    } catch (e) {
      throw Exception('Error creating comprehensive report: $e');
    }
  }

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static bool _hasObstetricHistory(Patient patient) {
    return patient.liveBirths != null ||
           patient.stillBirths != null ||
           patient.abortions != null ||
           patient.cesareans != null ||
           patient.miscarriages != null;
  }

  static bool _hasTestResults(Patient patient) {
    return patient.hpvTest != null ||
           patient.hpvResult != null ||
           patient.hpvDate != null ||
           patient.hcgTest != null ||
           patient.hcgDate != null ||
           patient.hcgLevel != null;
  }

  static Future<String> _getPdfDirectory() async {
    if (Platform.isWindows || Platform.isLinux) {
      // For desktop platforms, use documents directory
      final documentsDir = await getApplicationDocumentsDirectory();
      final pdfDir = Directory('${documentsDir.path}/Medical_Reports');
      if (!await pdfDir.exists()) {
        await pdfDir.create(recursive: true);
      }
      return pdfDir.path;
    } else {
      // For mobile platforms, use app documents directory
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  static Future<void> openReport(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      throw Exception('Error opening report: $e');
    }
  }
} 