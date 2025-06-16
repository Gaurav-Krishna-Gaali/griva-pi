import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/patient_service.dart';

class PatientFormScreen extends StatefulWidget {
  final Patient? patient;

  const PatientFormScreen({super.key, this.patient});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientService = PatientService();
  bool _isLoading = false;
  String? _error;

  // Form controllers
  final _nameController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _referredByController = TextEditingController();
  final _medicationController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _referralReasonController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _patientSummaryController = TextEditingController();

  DateTime? _dateOfBirth;
  DateTime? _dateOfVisit;
  DateTime? _lastMenstrualDate;
  DateTime? _hpvDate;
  DateTime? _hcgDate;

  String? _smoking;
  String? _bloodGroup;
  String? _menopause;
  String? _sexuallyActive;
  String? _contraception;
  String? _hivStatus;
  String? _pregnant;
  String? _hpvTest;
  String? _hpvResult;
  String? _hcgTest;
  String? _hpvVaccination;

  int _liveBirths = 0;
  int _stillBirths = 0;
  int _abortions = 0;
  int _cesareans = 0;
  int _miscarriages = 0;
  double? _hcgLevel;

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _populateForm();
    }
  }

  void _populateForm() {
    final patient = widget.patient!;
    _nameController.text = patient.patientName;
    _patientIdController.text = patient.patientId ?? '';
    _mobileController.text = patient.mobileNo;
    _emailController.text = patient.email ?? '';
    _addressController.text = patient.address ?? '';
    _doctorNameController.text = patient.doctorName ?? '';
    _referredByController.text = patient.referredBy ?? '';
    _medicationController.text = patient.medication ?? '';
    _allergiesController.text = patient.allergies ?? '';
    _referralReasonController.text = patient.referralReason ?? '';
    _symptomsController.text = patient.symptoms ?? '';
    _patientSummaryController.text = patient.patientSummary ?? '';

    _dateOfBirth = patient.dateOfBirth;
    _dateOfVisit = patient.dateOfVisit;
    _lastMenstrualDate = patient.lastMenstrualDate;
    _hpvDate = patient.hpvDate;
    _hcgDate = patient.hcgDate;

    _smoking = patient.smoking;
    _bloodGroup = patient.bloodGroup;
    _menopause = patient.menopause;
    _sexuallyActive = patient.sexuallyActive;
    _contraception = patient.contraception;
    _hivStatus = patient.hivStatus;
    _pregnant = patient.pregnant;
    _hpvTest = patient.hpvTest;
    _hpvResult = patient.hpvResult;
    _hcgTest = patient.hcgTest;
    _hpvVaccination = patient.hpvVaccination;

    _liveBirths = patient.liveBirths ?? 0;
    _stillBirths = patient.stillBirths ?? 0;
    _abortions = patient.abortions ?? 0;
    _cesareans = patient.cesareans ?? 0;
    _miscarriages = patient.miscarriages ?? 0;
    _hcgLevel = patient.hcgLevel;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _patientIdController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _doctorNameController.dispose();
    _referredByController.dispose();
    _medicationController.dispose();
    _allergiesController.dispose();
    _referralReasonController.dispose();
    _symptomsController.dispose();
    _patientSummaryController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  Future<void> _savePatient() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final patient = Patient(
        patientName: _nameController.text,
        patientId: _patientIdController.text.isEmpty ? null : _patientIdController.text,
        dateOfBirth: _dateOfBirth,
        dateOfVisit: _dateOfVisit,
        mobileNo: _mobileController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        address: _addressController.text.isEmpty ? null : _addressController.text,
        doctorName: _doctorNameController.text.isEmpty ? null : _doctorNameController.text,
        referredBy: _referredByController.text.isEmpty ? null : _referredByController.text,
        smoking: _smoking,
        bloodGroup: _bloodGroup,
        medication: _medicationController.text.isEmpty ? null : _medicationController.text,
        allergies: _allergiesController.text.isEmpty ? null : _allergiesController.text,
        menopause: _menopause,
        lastMenstrualDate: _lastMenstrualDate,
        sexuallyActive: _sexuallyActive,
        contraception: _contraception,
        hivStatus: _hivStatus,
        pregnant: _pregnant,
        liveBirths: _liveBirths,
        stillBirths: _stillBirths,
        abortions: _abortions,
        cesareans: _cesareans,
        miscarriages: _miscarriages,
        hpvVaccination: _hpvVaccination,
        referralReason: _referralReasonController.text.isEmpty ? null : _referralReasonController.text,
        symptoms: _symptomsController.text.isEmpty ? null : _symptomsController.text,
        hpvTest: _hpvTest,
        hpvResult: _hpvResult,
        hpvDate: _hpvDate,
        hcgTest: _hcgTest,
        hcgDate: _hcgDate,
        hcgLevel: _hcgLevel,
        patientSummary: _patientSummaryController.text.isEmpty ? null : _patientSummaryController.text,
      );

      if (widget.patient != null) {
        await _patientService.updatePatient(widget.patient!.id!, patient);
      } else {
        await _patientService.createPatient(patient);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient == null ? 'Add Patient' : 'Edit Patient'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Patient Name *'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter patient name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _patientIdController,
                    decoration: const InputDecoration(labelText: 'Patient ID'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(labelText: 'Mobile Number *'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _doctorNameController,
                    decoration: const InputDecoration(labelText: 'Doctor Name'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _referredByController,
                    decoration: const InputDecoration(labelText: 'Referred By'),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Date of Birth'),
                    subtitle: Text(_dateOfBirth == null
                        ? 'Not set'
                        : DateFormat('yyyy-MM-dd').format(_dateOfBirth!)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(
                      context,
                      _dateOfBirth,
                      (date) => setState(() => _dateOfBirth = date),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Date of Visit'),
                    subtitle: Text(_dateOfVisit == null
                        ? 'Not set'
                        : DateFormat('yyyy-MM-dd').format(_dateOfVisit!)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(
                      context,
                      _dateOfVisit,
                      (date) => setState(() => _dateOfVisit = date),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _bloodGroup,
                    decoration: const InputDecoration(labelText: 'Blood Group'),
                    items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                        .map((group) => DropdownMenuItem(
                              value: group,
                              child: Text(group),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _bloodGroup = value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _medicationController,
                    decoration: const InputDecoration(labelText: 'Medication'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _allergiesController,
                    decoration: const InputDecoration(labelText: 'Allergies'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _smoking,
                    decoration: const InputDecoration(labelText: 'Smoking Status'),
                    items: ['Yes', 'No', 'Former']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _smoking = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _menopause,
                    decoration: const InputDecoration(labelText: 'Menopause Status'),
                    items: ['Yes', 'No', 'Peri-menopausal']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _menopause = value),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Last Menstrual Date'),
                    subtitle: Text(_lastMenstrualDate == null
                        ? 'Not set'
                        : DateFormat('yyyy-MM-dd').format(_lastMenstrualDate!)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(
                      context,
                      _lastMenstrualDate,
                      (date) => setState(() => _lastMenstrualDate = date),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _sexuallyActive,
                    decoration: const InputDecoration(labelText: 'Sexually Active'),
                    items: ['Yes', 'No']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _sexuallyActive = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _contraception,
                    decoration: const InputDecoration(labelText: 'Contraception'),
                    items: ['None', 'Condom', 'Pill', 'IUD', 'Other']
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _contraception = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _hivStatus,
                    decoration: const InputDecoration(labelText: 'HIV Status'),
                    items: ['Negative', 'Positive', 'Unknown']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _hivStatus = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _pregnant,
                    decoration: const InputDecoration(labelText: 'Pregnancy Status'),
                    items: ['Yes', 'No', 'Unknown']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _pregnant = value),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _liveBirths.toString(),
                          decoration: const InputDecoration(labelText: 'Live Births'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() => _liveBirths = int.tryParse(value) ?? 0),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: _stillBirths.toString(),
                          decoration: const InputDecoration(labelText: 'Still Births'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() => _stillBirths = int.tryParse(value) ?? 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _abortions.toString(),
                          decoration: const InputDecoration(labelText: 'Abortions'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() => _abortions = int.tryParse(value) ?? 0),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: _cesareans.toString(),
                          decoration: const InputDecoration(labelText: 'Cesareans'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() => _cesareans = int.tryParse(value) ?? 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _miscarriages.toString(),
                    decoration: const InputDecoration(labelText: 'Miscarriages'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() => _miscarriages = int.tryParse(value) ?? 0),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _hpvVaccination,
                    decoration: const InputDecoration(labelText: 'HPV Vaccination'),
                    items: ['Yes', 'No', 'Partial', 'Unknown']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _hpvVaccination = value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _referralReasonController,
                    decoration: const InputDecoration(labelText: 'Referral Reason'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _symptomsController,
                    decoration: const InputDecoration(labelText: 'Symptoms'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _hpvTest,
                    decoration: const InputDecoration(labelText: 'HPV Test'),
                    items: ['Positive', 'Negative', 'Not Done']
                        .map((result) => DropdownMenuItem(
                              value: result,
                              child: Text(result),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _hpvTest = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _hpvResult,
                    decoration: const InputDecoration(labelText: 'HPV Result'),
                    items: ['Positive', 'Negative', 'Not Done']
                        .map((result) => DropdownMenuItem(
                              value: result,
                              child: Text(result),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _hpvResult = value),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('HPV Test Date'),
                    subtitle: Text(_hpvDate == null
                        ? 'Not set'
                        : DateFormat('yyyy-MM-dd').format(_hpvDate!)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(
                      context,
                      _hpvDate,
                      (date) => setState(() => _hpvDate = date),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _hcgTest,
                    decoration: const InputDecoration(labelText: 'HCG Test'),
                    items: ['Positive', 'Negative', 'Not Done']
                        .map((result) => DropdownMenuItem(
                              value: result,
                              child: Text(result),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _hcgTest = value),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('HCG Test Date'),
                    subtitle: Text(_hcgDate == null
                        ? 'Not set'
                        : DateFormat('yyyy-MM-dd').format(_hcgDate!)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(
                      context,
                      _hcgDate,
                      (date) => setState(() => _hcgDate = date),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _hcgLevel?.toString(),
                    decoration: const InputDecoration(labelText: 'HCG Level'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() => _hcgLevel = double.tryParse(value)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _patientSummaryController,
                    decoration: const InputDecoration(labelText: 'Patient Summary'),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _savePatient,
                    child: Text(widget.patient == null ? 'Add Patient' : 'Update Patient'),
                  ),
                ],
              ),
            ),
    );
  }
} 