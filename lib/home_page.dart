import 'package:flutter/material.dart';
import 'package:griva_pi/custom_app_bar.dart';
import 'new_patient_form.dart';
import 'custom_drawer.dart';
import 'exam_screen.dart';
import 'screens/patient_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Add state variable for active tab
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
              // Handle logout
              break;
            case 'profile':
              // Navigate to profile
              break;
            case 'settings':
              // Navigate to settings
              break;
            case 'support':
              // Navigate to support
              break;
            case 'logout':
              // Handle logout
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
                "Hello Doctor [Name]!",
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
                        MaterialPageRoute(builder: (context) => const PatientListScreen()),
                      );
                    },
                    child: _buildActionCard(
                      icon: Icons.folder_outlined,
                      title: 'Patient Database',
                      subtitle: 'View all patients',
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
                        child: _buildTab("Upcoming Appointments", _showUpcoming, '8'),
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    if (_showUpcoming) ...[
                                      _buildPatientCard(cardWidth),
                                      SizedBox(width: 16),
                                      _buildPatientCard(cardWidth),
                                      SizedBox(width: 16),
                                      _buildPatientCard(cardWidth),
                                      SizedBox(width: 16),
                                      _buildPatientCard(cardWidth),
                                    ] else ...[
                                      _buildPatientCard(cardWidth, isPending: true),
                                      SizedBox(width: 16),
                                      _buildPatientCard(cardWidth, isPending: true),
                                    ],
                                  ],
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

  Widget _buildPatientCard(double width, {bool isPending = false}) {
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
            '[Patient\'s Name]',
            style: TextStyle(
              fontSize: width * 0.06, // Responsive font size
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Patient ID',
            style: TextStyle(
              fontSize: width * 0.05, // Responsive font size
              color: Colors.grey[600],
            ),
          ),
          Text(
            'Age',
            style: TextStyle(
              fontSize: width * 0.05, // Responsive font size
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
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
                  child: Text(isPending ? 'Review' : 'Start Exam'),
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
