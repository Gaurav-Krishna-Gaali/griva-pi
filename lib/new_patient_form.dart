import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_app_bar.dart';
import 'custom_drawer.dart';
import "exam_screen.dart";
import 'services/patient_service.dart';

class NewPatientForm extends StatefulWidget {
  const NewPatientForm({Key? key}) : super(key: key);

  @override
  State<NewPatientForm> createState() => _NewPatientFormState();
}

class _NewPatientFormState extends State<NewPatientForm> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _dateOfVisitController = TextEditingController();
  final TextEditingController _lastMenstrualDateController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _referredByController = TextEditingController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _referralReasonController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _patientSummaryController = TextEditingController();
  final TextEditingController _hcgLevelController = TextEditingController();

  // Add state variables for smoking and blood group
  String? _smokingValue;
  String? _selectedBloodGroup = 'Dropdown'; // Default value
  String? _menopauseValue;
  String? _sexuallyActiveValue;
  String? _pregnantValue;
  String? _selectedContraception = 'Dropdown';
  String? _selectedHIVStatus = 'Dropdown';
  String? _selectedHPVVaccination = 'Dropdown';

  // Add counters for pregnancy history
  int _liveBirths = 0;
  int _stillBirths = 0;
  int _abortions = 0;
  int _cesareans = 0;
  int _miscarriages = 0;

  // New state variables for Colposcopy Specific Details
  String? _hpvTestValue;
  String? _hpvResultValue;
  TextEditingController _hpvDateController = TextEditingController();
  String? _hcgTestValue;
  TextEditingController _hcgDateController = TextEditingController();

  final _patientService = PatientService();
  bool _isSaving = false;

  @override
  void dispose() {
    _dateOfBirthController.dispose();
    _dateOfVisitController.dispose();
    _lastMenstrualDateController.dispose();
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
    _hcgLevelController.dispose();
    _hpvDateController.dispose();
    _hcgDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> _savePatient({required bool goToExam}) async {
    setState(() { _isSaving = true; });
    try {
      final patient = Patient(
        patientName: _nameController.text,
        patientId: _patientIdController.text,
        dateOfBirth: _dateOfBirthController.text.isNotEmpty ? DateFormat('MM/dd/yyyy').parse(_dateOfBirthController.text) : null,
        dateOfVisit: _dateOfVisitController.text.isNotEmpty ? DateFormat('MM/dd/yyyy').parse(_dateOfVisitController.text) : null,
        mobileNo: _mobileController.text,
        email: _emailController.text,
        address: _addressController.text,
        doctorName: _doctorNameController.text,
        referredBy: _referredByController.text,
        smoking: _smokingValue,
        bloodGroup: _selectedBloodGroup == 'Dropdown' ? null : _selectedBloodGroup,
        medication: _medicationController.text,
        allergies: _allergiesController.text,
        menopause: _menopauseValue,
        lastMenstrualDate: _lastMenstrualDateController.text.isNotEmpty ? DateFormat('MM/dd/yyyy').parse(_lastMenstrualDateController.text) : null,
        sexuallyActive: _sexuallyActiveValue,
        contraception: _selectedContraception == 'Dropdown' ? null : _selectedContraception,
        hivStatus: _selectedHIVStatus == 'Dropdown' ? null : _selectedHIVStatus,
        pregnant: _pregnantValue,
        liveBirths: _liveBirths,
        stillBirths: _stillBirths,
        abortions: _abortions,
        cesareans: _cesareans,
        miscarriages: _miscarriages,
        hpvVaccination: _selectedHPVVaccination == 'Dropdown' ? null : _selectedHPVVaccination,
        referralReason: _referralReasonController.text,
        symptoms: _symptomsController.text,
        hpvTest: _hpvTestValue,
        hpvResult: _hpvResultValue,
        hpvDate: _hpvDateController.text.isNotEmpty ? DateFormat('MM/dd/yyyy').parse(_hpvDateController.text) : null,
        hcgTest: _hcgTestValue,
        hcgDate: _hcgDateController.text.isNotEmpty ? DateFormat('MM/dd/yyyy').parse(_hcgDateController.text) : null,
        hcgLevel: _hcgLevelController.text.isNotEmpty ? double.tryParse(_hcgLevelController.text) : null,
        patientSummary: _patientSummaryController.text,
      );
      await _patientService.createPatient(patient);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient saved successfully!')),
        );
        if (goToExam) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PiCameraScreen()),
          );
        } else {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving patient: $e')),
        );
      }
    } finally {
      if (mounted) setState(() { _isSaving = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time and Date display
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.purple,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const Text(
                              'New Patient Form',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('hh:mm a').format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              DateFormat(
                                'MMMM dd, yyyy',
                              ).format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Form Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    const Center(
                      child: Text(
                        'General Information',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Row 1: Patient Name and ID
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Patient Name*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Patient ID',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _patientIdController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Row 2: Date of Birth and Visit
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date of Birth',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _dateOfBirthController,
                                readOnly: true,
                                onTap:
                                    () => _selectDate(
                                      context,
                                      _dateOfBirthController,
                                    ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date of Visit',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _dateOfVisitController,
                                readOnly: true,
                                onTap:
                                    () => _selectDate(
                                      context,
                                      _dateOfVisitController,
                                    ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Row 3: Mobile No and Email
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Mobile No.*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Row 4: Address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _addressController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Row 5: Doctor's Name and Referred By
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Doctor\'s Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _doctorNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Referred By',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _referredByController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Space for additional elements
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // New General Medical History Section in a Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'General Medical History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Smoking: '),
                        Radio<String>(
                          value: 'Yes',
                          groupValue: _smokingValue,
                          onChanged: (value) {
                            setState(() {
                              _smokingValue = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        Radio<String>(
                          value: 'No',
                          groupValue: _smokingValue,
                          onChanged: (value) {
                            setState(() {
                              _smokingValue = value;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Blood Group'),
                              DropdownButton<String>(
                                value: _selectedBloodGroup,
                                items:
                                    <String>[
                                      'Dropdown',
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'O+',
                                      'O-',
                                      'AB+',
                                      'AB-',
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedBloodGroup = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Medication'),
                              TextFormField(
                                controller: _medicationController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.all(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Any Allergies'),
                    TextFormField(
                      controller: _allergiesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ],
                ),
              ),
              // New Reproductive & Obstetric History Section in a Card
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Reproductive & Obstetric History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Menopause: '),
                              const SizedBox(width: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Yes',
                                        groupValue: _menopauseValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _menopauseValue = value;
                                          });
                                        },
                                      ),
                                      const Text('Yes'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'No',
                                        groupValue: _menopauseValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _menopauseValue = value;
                                          });
                                        },
                                      ),
                                      const Text('No'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Last Menstrual Date (If not menopausal)',
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _lastMenstrualDateController,
                                readOnly: true,
                                onTap:
                                    () => _selectDate(
                                      context,
                                      _lastMenstrualDateController,
                                    ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.all(8.0),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // New fields from the image
                    const SizedBox(height: 16),

                    // Sexually Active row
                    Row(
                      children: [
                        const Text('Sexually Active?'),
                        Radio<String>(
                          value: 'Yes',
                          groupValue: _sexuallyActiveValue,
                          onChanged: (value) {
                            setState(() {
                              _sexuallyActiveValue = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        Radio<String>(
                          value: 'No',
                          groupValue: _sexuallyActiveValue,
                          onChanged: (value) {
                            setState(() {
                              _sexuallyActiveValue = value;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Contraceptions and HIV Status row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contraceptions Used'),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedContraception,
                                items:
                                    <String>[
                                      'Dropdown',
                                      'None',
                                      'Condoms',
                                      'Pills',
                                      'IUD',
                                      'Implant',
                                      'Injection',
                                      'Sterilization',
                                      'Other',
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedContraception = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('HIV Status'),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedHIVStatus,
                                items:
                                    <String>[
                                      'Dropdown',
                                      'Positive',
                                      'Negative',
                                      'Unknown',
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedHIVStatus = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // B. Pregnancy and Birth History section
                    const Text(
                      'B. Pregnancy and Birth History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Pregnant row
                    Row(
                      children: [
                        const Text('Pregnant?'),
                        Radio<String>(
                          value: 'Yes',
                          groupValue: _pregnantValue,
                          onChanged: (value) {
                            setState(() {
                              _pregnantValue = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        Radio<String>(
                          value: 'No',
                          groupValue: _pregnantValue,
                          onChanged: (value) {
                            setState(() {
                              _pregnantValue = value;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Counter rows
                    Row(
                      children: [
                        Expanded(
                          child: _buildCounter('Live Births', _liveBirths, (
                            value,
                          ) {
                            setState(() {
                              _liveBirths = value;
                            });
                          }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildCounter('Still Births', _stillBirths, (
                            value,
                          ) {
                            setState(() {
                              _stillBirths = value;
                            });
                          }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildCounter('Abortions', _abortions, (
                            value,
                          ) {
                            setState(() {
                              _abortions = value;
                            });
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildCounter('Cesareans', _cesareans, (
                            value,
                          ) {
                            setState(() {
                              _cesareans = value;
                            });
                          }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildCounter('Miscarriages', _miscarriages, (
                            value,
                          ) {
                            setState(() {
                              _miscarriages = value;
                            });
                          }),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ), // Empty space for alignment
                      ],
                    ),

                    const SizedBox(height: 16),

                    // C. Immunization History section
                    const Text(
                      'C. Immunization History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('HPV Vaccination Type'),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedHPVVaccination,
                          items:
                              <String>[
                                'Dropdown',
                                'None',
                                'Gardasil',
                                'Cervarix',
                                'Gardasil 9',
                                'Unknown',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedHPVVaccination = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer
              const SizedBox(height: 20),

              // New Colposcopy Specific Details Section
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Colposcopy Specific Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Referral Reason
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Referral reason'),
                              TextFormField(
                                controller: _referralReasonController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.all(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Symptoms'),
                              TextFormField(
                                controller: _symptomsController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.all(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // HPV Test
                    Row(
                      children: [
                        const Text('HPV Test'),
                        SizedBox(width: 10),
                        Radio<String>(
                          value: 'Yes',
                          groupValue: _hpvTestValue,
                          onChanged: (value) {
                            setState(() {
                              _hpvTestValue = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        Radio<String>(
                          value: 'No',
                          groupValue: _hpvTestValue,
                          onChanged: (value) {
                            setState(() {
                              _hpvTestValue = value;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Result'),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Positive',
                          groupValue: _hpvResultValue,
                          onChanged: (value) {
                            setState(() {
                              _hpvResultValue = value;
                            });
                          },
                        ),
                        const Text('Positive'),
                        Radio<String>(
                          value: 'Negative',
                          groupValue: _hpvResultValue,
                          onChanged: (value) {
                            setState(() {
                              _hpvResultValue = value;
                            });
                          },
                        ),
                        const Text('Negative'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Date'),
                    TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context, _hpvDateController),
                      controller: _hpvDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // HCG Test
                    const Text('HCG Test'),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Yes',
                          groupValue: _hcgTestValue,
                          onChanged: (value) {
                            setState(() {
                              _hcgTestValue = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        Radio<String>(
                          value: 'No',
                          groupValue: _hcgTestValue,
                          onChanged: (value) {
                            setState(() {
                              _hcgTestValue = value;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Date'),
                    TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context, _hcgDateController),
                      controller: _hcgDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('HCG Level (in mIU/ml)'),
                    TextFormField(
                      controller: _hcgLevelController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Patient Summary & Notes
                    const Text('Patient Summary & Notes'),
                    TextFormField(
                      controller: _patientSummaryController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isSaving ? null : () => _savePatient(goToExam: false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Save and Edit'),
                  ),
                  ElevatedButton(
                    onPressed: _isSaving ? null : () => _savePatient(goToExam: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Save and Start Exam'),
                  ),
                ],
              ),

              // Footer
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '© 2025 Griya. All rights reserved.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build consistent counter widgets
  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Row(
      children: [
        Text(label),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
              ),
              SizedBox(
                width: 32,
                child: Text(value.toString(), textAlign: TextAlign.center),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                onPressed: () => onChanged(value + 1),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// To use this screen, just call:
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const NewPatientForm()),
// );
