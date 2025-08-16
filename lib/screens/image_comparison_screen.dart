import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import '../custom_app_bar.dart';
import '../custom_drawer.dart';

class ImageComparisonScreen extends StatefulWidget {
  final List<Uint8List> images;
  final Uint8List? currentImage;

  const ImageComparisonScreen({
    Key? key,
    required this.images,
    this.currentImage,
  }) : super(key: key);

  @override
  State<ImageComparisonScreen> createState() => _ImageComparisonScreenState();
}

class _ImageComparisonScreenState extends State<ImageComparisonScreen> {
  late List<Uint8List?> _comparisonImages;
  bool _isGridView = true; // Toggle between single, grid, and side-by-side view
  String? _selectedTag;
  int _selectedComparisonMode = 0; // 0: Grid, 1: Single, 2: Side-by-side
  
  // Medical imaging features
  bool _showGrid = false;
  bool _showRulers = false;
  
  // Zoom controllers for each image slot
  final List<GlobalKey<State<InteractiveViewer>>> _zoomKeys = List.generate(
    4, 
    (index) => GlobalKey<State<InteractiveViewer>>()
  );
  
  // Available tags for medical imaging
  final List<String> _availableTags = [
    'Normal',
    'Abnormal',
    'Suspicious',
    'Benign',
    'Malignant',
    'Inflammation',
    'Erosion',
    'Polyp',
    'Cyst',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _comparisonImages = List.filled(4, null);
    
    // Set the first image if available
    if (widget.images.isNotEmpty) {
      _comparisonImages[0] = widget.images.first;
    }
    
    // Set current image if provided
    if (widget.currentImage != null) {
      _comparisonImages[0] = widget.currentImage;
    }
  }

  void _addImageToSlot(int slotIndex) {
    if (slotIndex == 0) return; // Don't allow changing the first slot
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Image to Compare',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (widget.images.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    final image = widget.images[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _comparisonImages[slotIndex] = image;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Text(
                'No images available',
                style: TextStyle(color: Colors.white70),
              ),
          ],
        ),
      ),
    );
  }

  void _removeImageFromSlot(int slotIndex) {
    if (slotIndex == 0) return; // Don't allow removing the first slot
    setState(() {
      _comparisonImages[slotIndex] = null;
    });
  }

  void _setComparisonMode(int mode) {
    setState(() {
      _selectedComparisonMode = mode;
      _isGridView = mode == 0;
    });
  }

  void _toggleGrid() {
    setState(() {
      _showGrid = !_showGrid;
    });
  }

  void _toggleRulers() {
    setState(() {
      _showRulers = !_showRulers;
    });
  }

  void _resetZoom() {
    // Reset zoom on all image slots
    for (int i = 0; i < _zoomKeys.length; i++) {
      final key = _zoomKeys[i];
      if (key.currentState != null) {
        // Force rebuild to reset zoom
        setState(() {});
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All zoom levels reset')),
    );
  }

  void _saveComparison() {
    // TODO: Implement saving comparison data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Comparison saved successfully')),
    );
  }

  void _exportComparison() {
    // TODO: Implement exporting comparison
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon')),
    );
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
        userEmail: null,
        title: null,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Compare Images',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 20),
                
                // View mode toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _setComparisonMode(0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _selectedComparisonMode == 0 ? const Color(0xFF6B46C1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            color: _selectedComparisonMode == 0 ? Colors.white : Colors.grey[600],
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _setComparisonMode(1),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _selectedComparisonMode == 1 ? const Color(0xFF6B46C1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.crop_square,
                            color: _selectedComparisonMode == 1 ? Colors.white : Colors.grey[600],
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _setComparisonMode(2),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _selectedComparisonMode == 2 ? const Color(0xFF6B46C1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.compare_arrows,
                            color: _selectedComparisonMode == 2 ? Colors.white : Colors.grey[600],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Medical imaging tools
                if (_selectedComparisonMode == 1 || _selectedComparisonMode == 2) ...[
                  IconButton(
                    onPressed: _toggleGrid,
                    icon: Icon(
                      _showGrid ? Icons.grid_on : Icons.grid_off,
                      color: _showGrid ? const Color(0xFF6B46C1) : Colors.grey[600],
                    ),
                    tooltip: 'Toggle Grid',
                  ),
                  IconButton(
                    onPressed: _toggleRulers,
                    icon: Icon(
                      _showRulers ? Icons.straighten : Icons.straighten_outlined,
                      color: _showRulers ? const Color(0xFF6B46C1) : Colors.grey[600],
                    ),
                    tooltip: 'Toggle Rulers',
                  ),
                  const SizedBox(width: 8),
                ],
                
                // Zoom controls for all modes
                IconButton(
                  onPressed: _resetZoom,
                  icon: Icon(Icons.zoom_out, color: Colors.grey[600]),
                  tooltip: 'Reset All Zoom',
                ),
                const SizedBox(width: 8),
                
                // Back button
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('← Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),

          // Main comparison area
          Expanded(
            child: _buildComparisonArea(),
          ),

          // Bottom actions
          Container(
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
                // Tag selector
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedTag,
                    decoration: const InputDecoration(
                      labelText: 'Tags:',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    hint: const Text('Select a tag from the dropdown'),
                    items: _availableTags.map((tag) {
                      return DropdownMenuItem(
                        value: tag,
                        child: Text(tag),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTag = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                
                // Action buttons
                ElevatedButton.icon(
                  onPressed: _saveComparison,
                  icon: const Icon(Icons.save, size: 16),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _exportComparison,
                  icon: const Icon(Icons.download, size: 16),
                  label: const Text('Export'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),

          // Footer with copyright
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
              '© 2025 Griva. All rights reserved.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonArea() {
    switch (_selectedComparisonMode) {
      case 0:
        return _buildGridView();
      case 1:
        return _buildSingleView();
      case 2:
        return _buildSideBySideView();
      default:
        return _buildGridView();
    }
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Top row
          Expanded(
            child: Row(
              children: [
                // Top-left: Current image
                Expanded(
                  child: _buildImageSlot(0, 'Current', true),
                ),
                const SizedBox(width: 16),
                // Top-right: Add image slot
                Expanded(
                  child: _buildImageSlot(1, 'Add Image to Compare', false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Bottom row
          Expanded(
            child: Row(
              children: [
                // Bottom-left: Add image slot
                Expanded(
                  child: _buildImageSlot(2, 'Add Image to Compare', false),
                ),
                const SizedBox(width: 16),
                // Bottom-right: Add image slot
                Expanded(
                  child: _buildImageSlot(3, 'Add Image to Compare', false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleView() {
    if (_comparisonImages[0] == null) {
      return const Center(
        child: Text(
          'No image selected for comparison',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  // Image with zoom capability
                  InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.memory(
                      _comparisonImages[0]!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Static overlays that don't scale with zoom
                  if (_showGrid) _buildGridOverlay(),
                  if (_showRulers) _buildRulersOverlay(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSideBySideView() {
    final hasFirstImage = _comparisonImages[0] != null;
    final hasSecondImage = _comparisonImages[1] != null;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Left image
          Expanded(
            child: hasFirstImage
              ? _buildImageSlot(0, 'Current', true)
              : _buildImageSlot(0, 'Add Image to Compare', false),
          ),
          const SizedBox(width: 16),
          // Right image
          Expanded(
            child: hasSecondImage
              ? _buildImageSlot(1, 'Comparison', false)
              : _buildImageSlot(1, 'Add Image to Compare', false),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOverlay() {
    return IgnorePointer(
      child: CustomPaint(
        painter: GridPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildRulersOverlay() {
    return IgnorePointer(
      child: CustomPaint(
        painter: RulersPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildImageSlot(int slotIndex, String label, bool isCurrent) {
    final hasImage = _comparisonImages[slotIndex] != null;
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: hasImage ? const Color(0xFF6B46C1) : Colors.grey[300]!,
          width: hasImage ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          if (hasImage)
            // Display image with zoom capability
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.memory(
                  _comparisonImages[slotIndex]!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            )
          else
            // Add image placeholder
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          
          // Current tag for first slot
          if (isCurrent && hasImage)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B46C1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Current',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          
          // Remove button for non-current slots
          if (hasImage && !isCurrent)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _removeImageFromSlot(slotIndex),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          
          // Add button for empty slots
          if (!hasImage)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => _addImageToSlot(slotIndex),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom painter for grid overlay
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.0;

    // Vertical lines
    for (int i = 0; i <= 10; i++) {
      final x = (size.width / 10) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (int i = 0; i <= 10; i++) {
      final y = (size.height / 10) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for rulers overlay
class RulersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 2.0;

    // Top ruler
    canvas.drawLine(Offset(0, 20), Offset(size.width, 20), paint);
    // Left ruler
    canvas.drawLine(Offset(20, 0), Offset(20, size.height), paint);

    // Ruler markings
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Top ruler markings
    for (int i = 0; i <= 10; i++) {
      final x = (size.width / 10) * i;
      canvas.drawLine(Offset(x, 15), Offset(x, 25), paint);
      
      textPainter.text = TextSpan(
        text: '${(i * 10).toInt()}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 5, 5));
    }

    // Left ruler markings
    for (int i = 0; i <= 10; i++) {
      final y = (size.height / 10) * i;
      canvas.drawLine(Offset(15, y), Offset(25, y), paint);
      
      textPainter.text = TextSpan(
        text: '${(i * 10).toInt()}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, y - 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
