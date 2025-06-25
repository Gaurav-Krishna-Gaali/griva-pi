import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../services/patient_service.dart';
import '../services/medical_report_service.dart';
import 'clinical_data_form_screen.dart';

class PatientSelectionScreen extends StatefulWidget {
  final List<Uint8List> images;

  const PatientSelectionScreen({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<PatientSelectionScreen> createState() => _PatientSelectionScreenState();
}

class _PatientSelectionScreenState extends State<PatientSelectionScreen> {
  final PatientService _patientService = PatientService();
  List<Patient> _patients = [];
  bool _isLoading = true;
  String? _error;
  Patient? _selectedPatient;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final patients = await _patientService.getAllPatients();
      setState(() {
        _patients = patients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _createComprehensiveReport() async {
    if (_selectedPatient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a patient first')),
      );
      return;
    }

    // Navigate to the new clinical data form
    final reportData = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const ClinicalDataFormScreen(),
      ),
    );

    if (reportData == null) return; // User cancelled

    try {
      setState(() {
        _isLoading = true;
      });

      final filePath = await MedicalReportService.generateComprehensiveReport(
        patient: _selectedPatient!,
        images: widget.images,
        chiefComplaint: reportData['chiefComplaint'],
        cytologyReport: reportData['cytologyReport'],
        pathologicalReport: reportData['pathologicalReport'],
        colposcopyFindings: reportData['colposcopyFindings'],
        finalImpression: reportData['finalImpression'],
        remarks: reportData['remarks'],
        treatmentProvided: reportData['treatmentProvided'],
        precautions: reportData['precautions'],
        examiningPhysician: reportData['examiningPhysician'],
        forensicExamination: reportData['forensicExamination'] as Map<String, String>?,
      );

      if (mounted && filePath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Comprehensive report generated successfully!'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => MedicalReportService.openReport(filePath),
            ),
          ),
        );
        
        // Navigate back to gallery
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating report: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Patient for Report'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          if (_selectedPatient != null)
            ElevatedButton(
              onPressed: _isLoading ? null : _createComprehensiveReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Generate Report'),
            ),
        ],
      ),
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $_error',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPatients,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_patients.isEmpty) {
      return const Center(
        child: Text(
          'No patients found in database',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Column(
      children: [
        // Header info
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.grey[900],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Images to include: ${widget.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (_selectedPatient != null)
                Text(
                  'Selected: ${_selectedPatient!.patientName}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
        
        // Patient list
        Expanded(
          child: ListView.builder(
            itemCount: _patients.length,
            itemBuilder: (context, index) {
              final patient = _patients[index];
              final isSelected = _selectedPatient?.id == patient.id;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.grey[900],
                child: ListTile(
                  title: Text(
                    patient.patientName,
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (patient.patientId != null)
                        Text(
                          'ID: ${patient.patientId}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      Text(
                        'Mobile: ${patient.mobileNo}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      if (patient.dateOfVisit != null)
                        Text(
                          'Visit: ${patient.dateOfVisit!.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                    ],
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedPatient = patient;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 