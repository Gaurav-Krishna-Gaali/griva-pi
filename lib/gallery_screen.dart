import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import 'services/pdf_service.dart';
import 'screens/patient_selection_screen.dart';
import 'custom_app_bar.dart';
import 'custom_drawer.dart';

class GalleryScreen extends StatefulWidget {
  final List<Uint8List> images;
  final Function(int) onDelete;

  const GalleryScreen({
    Key? key,
    required this.images,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late List<Uint8List> _images;
  Set<int> _selectedIndices = {};
  bool _isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.images);
  }

  @override
  void didUpdateWidget(GalleryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.images != widget.images) {
      setState(() {
        _images = List.from(widget.images);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
      _selectedIndices.remove(index);
      // Adjust indices for selected items after deletion
      _selectedIndices = _selectedIndices.map((i) => i > index ? i - 1 : i).toSet();
    });
    widget.onDelete(index);
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedIndices.clear();
      }
    });
  }

  void _toggleImageSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _editSelectedImages() {
    // TODO: Implement edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality coming soon')),
    );
  }

  void _compareSelectedImages() {
    // TODO: Implement compare functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compare functionality coming soon')),
    );
  }

  void _proceedToDiagnosis() {
    if (_selectedIndices.isEmpty) return;
    
    final selectedImages = _selectedIndices.map((index) => _images[index]).toList();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientSelectionScreen(
          images: selectedImages,
        ),
      ),
    ).then((_) {
      // Exit selection mode when returning from patient selection
      setState(() {
        _isSelectionMode = false;
        _selectedIndices.clear();
      });
    });
  }

  Future<void> _showPdfOptions() async {
    if (_selectedIndices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one image')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create Report',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.white),
              title: const Text(
                'Simple PDF',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Images only',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.pop(context);
                _createSimplePdf();
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.white),
              title: const Text(
                'Detailed Report',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'With patient information',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.pop(context);
                _createDetailedPdf();
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services, color: Colors.white),
              title: const Text(
                'Comprehensive Medical Report',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'SQL data + images + clinical findings',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.pop(context);
                _createComprehensiveReport();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createSimplePdf() async {
    try {
      final selectedImages = _selectedIndices.map((index) => _images[index]).toList();
      final filePath = await PdfService.createImagePdf(selectedImages, 'gallery_images');
      
      if (mounted && filePath != null) {
        final pdfDir = await PdfService.getPdfDirectoryPath();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved successfully\nLocation: $pdfDir'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => PdfService.openPdf(filePath),
            ),
          ),
        );
        
        // Exit selection mode
        setState(() {
          _isSelectionMode = false;
          _selectedIndices.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating PDF: $e')),
        );
      }
    }
  }

  Future<void> _createDetailedPdf() async {
    // Show dialog to get patient information
    final patientName = await _showPatientInfoDialog('Patient Name');
    if (patientName == null) return;
    
    final patientId = await _showPatientInfoDialog('Patient ID');
    if (patientId == null) return;
    
    final notes = await _showPatientInfoDialog('Notes (optional)', isRequired: false);

    try {
      final selectedImages = _selectedIndices.map((index) => _images[index]).toList();
      final filePath = await PdfService.createDetailedPdf(
        images: selectedImages,
        patientName: patientName,
        patientId: patientId,
        dateOfVisit: DateTime.now().toString().split(' ')[0],
        notes: notes,
      );
      
      if (mounted && filePath != null) {
        final pdfDir = await PdfService.getPdfDirectoryPath();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Detailed PDF saved successfully\nLocation: $pdfDir'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => PdfService.openPdf(filePath),
            ),
          ),
        );
        
        // Exit selection mode
        setState(() {
          _isSelectionMode = false;
          _selectedIndices.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating detailed PDF: $e')),
        );
      }
    }
  }

  void _createComprehensiveReport() {
    final selectedImages = _selectedIndices.map((index) => _images[index]).toList();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientSelectionScreen(
          images: selectedImages,
        ),
      ),
    ).then((_) {
      // Exit selection mode when returning from patient selection
      setState(() {
        _isSelectionMode = false;
        _selectedIndices.clear();
      });
    });
  }

  Future<String?> _showPatientInfoDialog(String title, {bool isRequired = true}) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: isRequired ? 'Required' : 'Optional',
            hintStyle: const TextStyle(color: Colors.white70),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (isRequired && value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This field is required')),
                );
                return;
              }
              Navigator.pop(context, value.isEmpty ? null : value);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _getPlatformInfo() {
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isMacOS) return 'macOS';
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onLogout: () {
          // TODO: Implement logout logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout clicked')),
          );
        },
        onProfile: () {
          // TODO: Implement profile logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile clicked')),
          );
        },
      ),
      appBar: CustomAppBar(
        userEmail: null, // Pass user email if available
        title: _isSelectionMode 
          ? Text(
              'Select Images (${_selectedIndices.length}/${_images.length})',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          : null, // Use default title when not in selection mode
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button - always visible
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF6B46C1)),
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                ),
              ],
            ),
          ),
          
          // Main content
          if (_images.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No images captured yet',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Selection mode indicator
                  if (_isSelectionMode)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: const Color(0xFF6B46C1).withOpacity(0.1),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF6B46C1),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Selection Mode - Tap images to select/deselect',
                            style: const TextStyle(
                              color: Color(0xFF6B46C1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _toggleSelectionMode,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFF6B46C1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Section title and selection count
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      children: [
                        const Text(
                          'Review and edit captured Images',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${_selectedIndices.length}/${_images.length} Selected for Report',
                          style: const TextStyle(
                            color: Color(0xFF6B46C1), // Purple color
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Action buttons when images are selected
                  if (_selectedIndices.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Edit'),
                            onPressed: _editSelectedImages,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B46C1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              minimumSize: const Size(0, 32),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.compare, size: 16),
                            label: const Text('Compare'),
                            onPressed: _compareSelectedImages,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B46C1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              minimumSize: const Size(0, 32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Image grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedIndices.contains(index);
                        return GestureDetector(
                          onTap: () {
                            if (_isSelectionMode) {
                              _toggleImageSelection(index);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageDetailScreen(
                                    imageBytes: _images[index],
                                    onDelete: () {
                                      _deleteImage(index);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                          onLongPress: () {
                            if (!_isSelectionMode) {
                              _toggleSelectionMode();
                              _toggleImageSelection(index);
                            }
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected ? const Color(0xFF6B46C1) : Colors.grey.shade300,
                                          width: isSelected ? 2 : 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.memory(
                                          _images[index],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF6B46C1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Cervix Image ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '© 2025 Griya. All rights reserved.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('Proceed to Diagnosis'),
              onPressed: _selectedIndices.isNotEmpty ? _proceedToDiagnosis : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B46C1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                minimumSize: const Size(0, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Gallery Help',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to use:',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Tap the select button to enter selection mode\n'
              '• Long press any image to quickly select it\n'
              '• Tap images to select/deselect them\n'
              '• Use the PDF button to create reports\n'
              '• Choose from three report types:\n'
              '  - Simple PDF: Images only\n'
              '  - Detailed Report: With patient info\n'
              '  - Comprehensive Report: SQL data + images',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Text(
              'Platform:',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Running on: ${_getPlatformInfo()}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            FutureBuilder<String>(
              future: PdfService.getPdfDirectoryPath(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'PDFs saved to:\n${snapshot.data}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  );
                }
                return const Text(
                  'Loading PDF directory...',
                  style: TextStyle(color: Colors.white70),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final Uint8List imageBytes;
  final VoidCallback onDelete;

  const ImageDetailScreen({
    Key? key,
    required this.imageBytes,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: const Text(
                    'Delete Image',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Are you sure you want to delete this image?',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        onDelete();
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Image.memory(
          imageBytes,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
} 