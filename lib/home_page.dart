import 'package:flutter/material.dart';
import 'package:griva_pi/custom_app_bar.dart';
import 'new_patient_form.dart';
import 'custom_drawer.dart';
import 'exam_screen.dart';
import 'screens/patient_list_screen.dart';
import 'services/patient_service.dart';
import 'services/user_service.dart';
import 'screens/patient_form_screen.dart';
import 'screens/user_profile_screen.dart';
import 'main.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String? userEmail;
  
  const HomePage({Key? key, this.userEmail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  // Add state variable for active tab
  bool _showUpcoming = true;
  List<Patient> _patients = [];
  bool _isLoading = true;
  String _userName = 'Doctor';
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchPatients();
    _loadUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when coming back to this page
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    final patients = await PatientService().getAllPatients();
    setState(() {
      _patients = patients;
      _isLoading = false;
    });
  }

  Future<void> _loadUserData() async {
    if (widget.userEmail != null) {
      try {
        final user = await _userService.getUserByEmail(widget.userEmail!);
        if (user != null) {
          print('Loaded user: ${user.fullName} with role: ${user.role}'); // Debug log
          setState(() {
            // Format the name based on role
            if (user.role == 'admin') {
              _userName = user.fullName;
            } else {
              // For doctors, add Dr. prefix if not already present
              _userName = user.fullName.startsWith('Dr.') 
                  ? user.fullName 
                  : 'Dr. ${user.fullName}';
            }
          });
        } else {
          print('User not found for email: ${widget.userEmail}');
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    } else {
      print('No user email provided to HomePage');
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login page and clear the navigation stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GrivaLoginPage()),
                  (route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showProfile() {
    if (widget.userEmail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(userEmail: widget.userEmail!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User information not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onLogout: _logout,
        onProfile: _showProfile,
      ),
      appBar: CustomAppBar(
        onMenuSelected: (String value) {
          // Handle menu item selection
          switch (value) {
            case 'wifi':
              // Handle Wifi selection
              break;
            case 'microphone':
              // Handle Microphone selection
              break;
            case 'bluetooth':
              // Handle Bluetooth selection
              break;
            case 'logout':
              _logout();
              break;
            case 'profile':
              _showProfile();
              break;
            case 'settings':
              // Navigate to settings
              break;
            case 'support':
              // Navigate to support
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            Center(
              child: Text(
                "Hello ${_userName}!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewPatientForm()),
                      );
                    },
                  child: _buildActionCard(
                    icon: Icons.person_outline,
                    title: 'New Patient',
                    subtitle: 'Register a new patient',
                    color: Color(0xFFE6F0FF),
                    iconColor: Colors.black87,
                  ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child:GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PiCameraScreen()),
                      );
                    },
                  child: _buildActionCard(
                    icon: Icons.assignment_outlined,
                    title: 'Start Exam',
                    subtitle: 'Begin patient consultation',
                    color: Color(0xFFE6FFE6),
                    iconColor: Colors.black87,
                  ),)
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PatientListScreen(),
                        ),
                      );
                    },
                    child: _buildActionCard(
                      icon: Icons.folder_outlined,
                      title: 'Patient Database',
                      subtitle: ' ',
                      color: Color(0xFFF5E6FF),
                      iconColor: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _showUpcoming = true),
                        child: _buildTab("Upcoming Appointments", _showUpcoming, _patients.length.toString()),
                      ),
                      SizedBox(width: 24),
                      GestureDetector(
                        onTap: () => setState(() => _showUpcoming = false),
                        child: _buildTab("Pending Diagnosis", !_showUpcoming, '9'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = 320.0;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180,
                          child: Stack(
                            children: [
                              _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : _patients.isEmpty
                                    ? Center(child: Text('No upcoming appointments'))
                                    : SizedBox(
                                        height: 180,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _patients.length,
                                          separatorBuilder: (_, __) => SizedBox(width: 16),
                                          itemBuilder: (context, index) {
                                            return _buildPatientCard(_patients[index], cardWidth);
                                          },
                                        ),
                                      ),
                              Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.white.withOpacity(0),
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF8B44F7),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: iconColor),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildTab(String title, bool isActive, String count) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Color(0xFF8B44F7) : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? Color(0xFF8B44F7) : Colors.grey,
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isActive ? Color(0xFF8B44F7) : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(Patient patient, double width, {bool isPending = false}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            patient.patientName,
            style: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            patient.patientId ?? '',
            style: TextStyle(
              fontSize: width * 0.05,
              color: Colors.grey[600],
            ),
          ),
          Text(
            patient.dateOfBirth != null
              ? 'Age: ${DateTime.now().year - patient.dateOfBirth!.year}'
              : '',
            style: TextStyle(
              fontSize: width * 0.05,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientFormScreen(patient: patient),
                      ),
                    );
                    if (updated == true) {
                      _fetchPatients();
                    }
                  },
                  child: Text('Details'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[700],
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Start Exam'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B44F7),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenuItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
