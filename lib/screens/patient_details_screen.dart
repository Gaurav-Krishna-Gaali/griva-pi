import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../custom_app_bar.dart';
import '../widgets/centralized_footer.dart';
import '../services/patient_service.dart';
import '../services/image_service.dart';
import '../new_patient_form.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Patient patient;

  const PatientDetailsScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final PatientService _patientService = PatientService();
  late Patient _patient;
  List<String> _examinationImages = [];
  bool _isLoadingImages = true;

  @override
  void initState() {
    super.initState();
    _patient = widget.patient;
    _loadExaminationImages();
  }

  Future<void> _loadExaminationImages() async {
    try {
      final images = await ImageService.getPatientImages(_patient.id!);
      setState(() {
        _examinationImages = images;
        _isLoadingImages = false;
      });
    } catch (e) {
      print('Error loading examination images: $e');
      setState(() {
        _isLoadingImages = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Details Header
              const Center(
                child: Text(
                  'Patient Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Main Patient Information Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                 child: Column(
                   children: [
                     // Top row with name and menu
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             const Icon(Icons.person, color: Color(0xFF8B44F7), size: 24),
                             const SizedBox(width: 12),
                             Text(
                              _patient.patientName,
                               style: const TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Color(0xFF1F2937),
                               ),
                             ),
                           ],
                         ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.grey),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          offset: const Offset(0, 36), color: Colors.white,
                          onSelected: (value) {
                            switch (value) {
                              case 'edit':
                                _navigateToEdit();
                                break;
                              case 'delete':
                                _confirmAndDelete();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: Row(
                                children: const [
                                  Icon(Icons.edit, size: 18, color: Colors.grey),
                                  SizedBox(width: 12),
                                  Text('Edit', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Row(
                                children: const [
                                  Icon(Icons.delete, size: 18, color: Colors.red),
                                  SizedBox(width: 12),
                                  Text('Delete', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                       ],
                     ),
                     const SizedBox(height: 20),
                     // Patient info in two rows
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              _buildInlineInfo(Icons.medication_outlined, 'Patient ID', _patient.patientId ?? 'N/A'),
                              _buildInlineInfo(Icons.person_outline, 'Age', _calculateAge()),
                              _buildInlineInfo(Icons.calendar_today_outlined, 'DOB', _formatDate(_patient.dateOfBirth)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                         Expanded(
                           child: Wrap(
                            spacing: 16, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center,
                             children: [
                               _buildInlineInfo(Icons.phone, '', _patient.mobileNo),
                               _buildInlineInfo(Icons.email, '', _patient.email ?? 'N/A'),
                               _buildInlineInfo(Icons.location_on, '', _patient.address ?? 'N/A'),
                             ],
                           ),
                         ),
                         const SizedBox(width: 20),
                         const Spacer(),
                         // Action Button
                         ElevatedButton.icon(
                           onPressed: () {
                             // Navigate to exam screen
                             Navigator.pushNamed(context, '/exam');
                           },
                           icon: const Icon(Icons.add, size: 18),
                           label: const Text('Start New Scan'),
                           style: ElevatedButton.styleFrom(
                             backgroundColor: const Color(0xFF8B44F7),
                             foregroundColor: Colors.white,
                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
              ),

              const SizedBox(height: 24),

              // Two Column Layout
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cervical Health Information
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.favorite, color: Color(0xFF8B44F7), size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Cervical Health Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildHealthInfo('Primary Condition', 'Colposcopy Follow-up', isHighlighted: true),
                          const SizedBox(height: 12),
                          _buildHealthInfo('Total Visits', '2'),
                          const SizedBox(height: 12),
                          _buildHealthInfo('Latest Visit', _formatDate(_patient.dateOfVisit)),
                          const SizedBox(height: 12),
                          _buildHealthInfo('Next Follow-up', '05/08/2025'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Examination Images
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.photo_camera, color: Color(0xFF8B44F7), size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Examination Images',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${_examinationImages.length}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF8B44F7),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildExaminationImagesGrid(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Visit History Section
              Row(
                children: [
                  const Icon(Icons.flash_on, color: Color(0xFF8B44F7), size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Visit History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Visit History Cards
              Row(
                children: [
                  Expanded(
                    child: _buildVisitCard(
                      'Colposcopy Examination (Visit #1)',
                      '15/01/2024',
                      'Cervical Dysplasia - Grade 2',
                      'Visible acetowhite changes in transformation zone.',
                      'Schedule biopsy in 2 weeks',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildVisitCard(
                      'Initial Check-up (Visit #2)',
                      '16/01/2024',
                      'HPV Positive - High Risk',
                      'HPV 16/18 detected. Patient counseled on treatment options.',
                      'Schedule biopsy in 2 weeks',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CentralizedFooter(),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF8B44F7), size: 20),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1F2937),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF8B44F7), size: 16),
        const SizedBox(width: 8),
        if (label.isNotEmpty) ...[
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ],
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInlineInfo(IconData icon, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF94A3B8), size: 16),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Future<void> _navigateToEdit() async {
    try {
      Patient? patientToEdit = widget.patient;
      if (widget.patient.id != null) {
        // Fetch the latest data from the SQL DB using the primary key
        patientToEdit = await _patientService.getPatient(widget.patient.id!);
      }

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPatientForm(patient: patientToEdit),
        ),
      );
      if (result == true) {
        if (_patient.id != null) {
          final refreshed = await _patientService.getPatient(_patient.id!);
          if (mounted) setState(() { _patient = refreshed; });
        } else if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load patient: $e')),
        );
      }
    }
  }

  Future<void> _confirmAndDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Patient'),
        content: Text('Are you sure you want to delete ${widget.patient.patientName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        if (widget.patient.id != null) {
          await _patientService.deletePatient(widget.patient.id!);
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Patient deleted')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete: $e')),
          );
        }
      }
    }
  }

  Widget _dot() => Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFD1D5DB),
          borderRadius: BorderRadius.circular(2),
        ),
      );

  Widget _buildHealthInfo(String label, String value, {bool isHighlighted = false}) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        if (isHighlighted)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE7F3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFFBE185D),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1F2937),
            ),
          ),
      ],
    );
  }

  Widget _buildClinicalNote(String date, String note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B44F7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          note,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildVisitCard(String title, String date, String diagnosis, String notes, String followUp) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          _buildVisitInfo('Date', date),
          const SizedBox(height: 8),
          _buildVisitInfo('Diagnosis', diagnosis),
          const SizedBox(height: 8),
          _buildVisitInfo('Notes', notes),
          const SizedBox(height: 8),
          _buildVisitInfo('Follow-up', followUp),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF8B44F7)),
                    foregroundColor: const Color(0xFF8B44F7),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('View Images'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF8B44F7)),
                    foregroundColor: const Color(0xFF8B44F7),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('View Reports'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisitInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  String _calculateAge() {
    if (_patient.dateOfBirth == null) return 'N/A';
    final now = DateTime.now();
    final birthDate = _patient.dateOfBirth!;
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Widget _buildExaminationImagesGrid() {
    if (_isLoadingImages) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B44F7)),
        ),
      );
    }

    if (_examinationImages.isEmpty) {
      return Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_camera_outlined,
                size: 32,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'No examination images',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _examinationImages.length,
        itemBuilder: (context, index) {
          return _buildImageThumbnail(_examinationImages[index], index);
        },
      ),
    );
  }

  Widget _buildImageThumbnail(String imagePath, int index) {
    return GestureDetector(
      onTap: () => _showImageDialog(imagePath, index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF8B44F7).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: FutureBuilder<Uint8List?>(
            future: ImageService.loadImage(imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B44F7)),
                    strokeWidth: 2,
                  ),
                );
              }
              
              if (snapshot.hasError || snapshot.data == null) {
                return Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 32,
                  ),
                );
              }

              return Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showImageDialog(String imagePath, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FutureBuilder<Uint8List?>(
                      future: ImageService.loadImage(imagePath),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B44F7)),
                            ),
                          );
                        }
                        
                        if (snapshot.hasError || snapshot.data == null) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.broken_image, size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text('Failed to load image'),
                              ],
                            ),
                          );
                        }

                        return InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 3.0,
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 28,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    shape: const CircleBorder(),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Image ${index + 1} of ${_examinationImages.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
