import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import 'services/pdf_service.dart';
import 'screens/patient_selection_screen.dart';

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
      appBar: AppBar(
        title: Text(_isSelectionMode ? 'Select Images (${_selectedIndices.length})' : 'Gallery'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: _showPdfOptions,
              tooltip: 'Create Report',
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _toggleSelectionMode,
              tooltip: 'Cancel Selection',
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: _showHelpDialog,
              tooltip: 'Help',
            ),
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: _toggleSelectionMode,
              tooltip: 'Select Images',
            ),
          ],
        ],
      ),
      backgroundColor: Colors.black,
      body: _images.isEmpty
          ? const Center(
              child: Text(
                'No images captured yet',
                style: TextStyle(color: Colors.white),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
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
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.white24,
                            width: isSelected ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            _images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
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
                );
              },
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