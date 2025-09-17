import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../services/patient_service.dart';
import 'patient_form_screen.dart';
import 'dart:io';
import '../widgets/centralized_footer.dart';
import '../custom_app_bar.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final PatientService _patientService = PatientService();
  List<Patient> _patients = [];
  bool _isLoading = true;
  String? _error;
  Patient? _selectedPatient;

  final TextEditingController _searchController = TextEditingController();
  String _timeFilter = 'All time';
  String _ageFilter = 'All ages';

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
      await _patientService.insertSamplePatients();
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

  Future<void> _navigateToAddPatient() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PatientFormScreen(),
      ),
    );
    if (result == true) {
      _loadPatients();
    }
  }

  Future<void> _navigateToEditPatient(Patient patient) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientFormScreen(patient: patient),
      ),
    );
    if (result == true) {
      _loadPatients();
    }
  }

  Future<void> _deletePatient(Patient patient) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Patient'),
        content: Text('Are you sure you want to delete ${patient.patientName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _patientService.deletePatient(patient.id!);
        if (Navigator.canPop(context)) {
          Navigator.pop(context, true);
        } else {
          _loadPatients();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting patient: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // title: const Text('Patient Database', style: TextStyle(color: Colors.black)),
        
      ),
      body: _buildBody(),
      bottomNavigationBar: const CentralizedFooter(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
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
        child: Text('No patients found'),
      );
    }

    final filtered = _applyFilters(_patients);

    final leftPane = Expanded(
      flex: 6,
      child: Column(
        children: [
          _buildToolbar(),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildHeading(filtered.length),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _buildDataGrid(filtered),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // Compose the main content area (list only or split view)
    final Widget mainArea = (_selectedPatient == null)
        ? Row(children: [leftPane])
        : Row(
            children: [
              leftPane,
              Container(width: 1, color: Colors.grey.shade300),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildPreview(),
                ),
              ),
            ],
          );

    // Return with top header under custom app bar
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopHeader(),
        const SizedBox(height: 8),
        Expanded(child: mainArea),
      ],
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                    hintText: 'Search with patient name, ID, phone number or condition…',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF8B44F7)),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _exportCsv,
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Export CSV'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF0F172A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Filter by:', style: TextStyle(color: Color(0xFF475569))),
              const SizedBox(width: 16),
              const Text('Time Period:', style: TextStyle(color: Color(0xFF475569))),
              const SizedBox(width: 8),
              _buildDropdown<String>(
                value: _timeFilter,
                items: const ['All time', 'Last 7 days', 'Last 30 days', 'This year'],
                onChanged: (v) => setState(() => _timeFilter = v ?? 'All time'),
                label: '',
              ),
              const SizedBox(width: 24),
              const Text('Age Group:', style: TextStyle(color: Color(0xFF475569))),
              const SizedBox(width: 8),
              _buildDropdown<String>(
                value: _ageFilter,
                items: const ['All ages', '18-30', '31-45', '46+'],
                onChanged: (v) => setState(() => _ageFilter = v ?? 'All ages'),
                label: '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String label,
  }) {
    return SizedBox(
      width: 180,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label.isEmpty ? null : label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF8B44F7)),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: items
                .map((e) => DropdownMenuItem<T>(value: e, child: Text('$e')))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  List<Patient> _applyFilters(List<Patient> input) {
    Iterable<Patient> result = input;

    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      result = result.where((p) {
        final name = p.patientName.toLowerCase();
        final id = (p.patientId ?? '').toString().toLowerCase();
        final mobile = (p.mobileNo ?? '').toString().toLowerCase();
        return name.contains(query) || id.contains(query) || mobile.contains(query);
      });
    }

    final now = DateTime.now();
    if (_timeFilter != 'All time') {
      result = result.where((p) {
        final d = p.dateOfVisit;
        if (d == null) return false;
        switch (_timeFilter) {
          case 'Last 7 days':
            return d.isAfter(now.subtract(const Duration(days: 7)));
          case 'Last 30 days':
            return d.isAfter(now.subtract(const Duration(days: 30)));
          case 'This year':
            return d.year == now.year;
          default:
            return true;
        }
      });
    }

    // Age filter is a placeholder until age is available in model
    // Kept for UI completeness; it does not filter the list yet.

    return result.toList();
  }

  Widget _buildHeading(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Image.asset('assets/images/icons/users.png'),
            ),
            const SizedBox(width: 8),
            const Text(
              'Patient Records',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                '$count patients',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _navigateToAddPatient,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add New Patient'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B44F7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: Center(
              child: const Text(
                'Patient Database',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildDataGrid(List<Patient> rows) {
    final headerStyle = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Container(
              height: 44,
              color: const Color(0xFFF8FAFC),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _gridCell('Patient Name', flex: 3, style: headerStyle),
                  _gridCell('Patient ID', flex: 2, style: headerStyle),
                  _gridCell('Issue Name', flex: 3, style: headerStyle),
                  _gridCell('Latest Visit Date', flex: 2, style: headerStyle, align: TextAlign.right),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Expanded(
              child: ListView.separated(
                itemCount: rows.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
      itemBuilder: (context, index) {
                  final p = rows[index];
                  final isSelected = _selectedPatient?.id == p.id;
                  return InkWell(
                    onTap: () => setState(() => _selectedPatient = p),
                    child: Container(
                      color: isSelected ? const Color(0xFFF1F5FF) : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          _gridCell(p.patientName, flex: 3),
                          _gridCell(p.patientId ?? '-', flex: 2),
                          _gridCell(p.referralReason ?? p.finalImpression ?? '—', flex: 3),
                          _gridCell(
                            p.dateOfVisit != null ? p.dateOfVisit!.toLocal().toString().split(' ')[0] : '—',
                            flex: 2,
                            align: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridCell(String text, {int flex = 1, TextAlign align = TextAlign.left, TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
  Widget _buildPreview() {
    if (_selectedPatient == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.image, size: 72, color: Colors.deepPurple),
            SizedBox(height: 12),
            Text('Select a patient to preview their latest report images'),
          ],
        ),
      );
    }

    final p = _selectedPatient!;
        return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 28),
                const SizedBox(width: 8),
                Text(p.patientName, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                if (p.patientId != null) Text('ID: ${p.patientId}'),
                if (p.mobileNo != null) Text('Mobile: ${p.mobileNo}'),
                if (p.dateOfVisit != null) Text('Visit: ${p.dateOfVisit!.toLocal().toString().split(' ')[0]}'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.photo_library_outlined, size: 64, color: Colors.deepPurple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportCsv() async {
    try {
      final buffer = StringBuffer('Name,PatientID,Mobile,VisitDate\n');
      for (final p in _applyFilters(_patients)) {
        final date = p.dateOfVisit?.toIso8601String() ?? '';
        final id = p.patientId?.toString() ?? '';
        final mobile = p.mobileNo?.toString() ?? '';
        buffer.writeln('"${p.patientName}","$id","$mobile","$date"');
      }

      final dir = await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();
      final file = File('${dir.path}${Platform.pathSeparator}patients.csv');
      await file.writeAsString(buffer.toString());
      await OpenFile.open(file.path);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CSV exported to ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to export CSV: $e')),
        );
      }
    }
  }
} 