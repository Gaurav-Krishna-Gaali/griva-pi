import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.purple),
          onPressed: () {
            // Add drawer functionality
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 32, // Fixed height for better proportions
            ),
            SizedBox(width: 8), // Fixed spacing
            Text(
              'Colposcope',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20, // Fixed font size
                fontWeight: FontWeight.w500, // Increased weight for better readability
                letterSpacing: 0.5, // Added letter spacing
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Color(0xFF8B44F7)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Color(0xFF8B44F7)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hello Doctor [Name]!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionCard(
                  icon: Icons.person_outline,  // Changed icon
                  title: 'New Patient',
                  subtitle: 'Register a new patient',
                  color: Color(0xFFE6F0FF),
                  iconColor: Colors.black87,  // Added icon color
                ),
                _buildActionCard(
                  icon: Icons.assignment_outlined,  // Changed icon
                  title: 'Start Exam',
                  subtitle: 'Begin patient consultation',
                  color: Color(0xFFE6FFE6),
                  iconColor: Colors.black87,
                ),
                _buildActionCard(
                  icon: Icons.folder_outlined,  // Changed icon
                  title: 'Patient Database',
                  subtitle: '',
                  color: Color(0xFFF5E6FF),
                  iconColor: Colors.black87,
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildTab("Upcoming Appointments", true, '8'),
                    SizedBox(width: 24),
                    _buildTab("Pending Diagnosis", false, '9'),
                  ],
                ),
                // Add search field
                // Expanded(
                //   child: TextField(
                //     decoration: InputDecoration(
                //       hintText: 'Search patient/ID',
                //       prefixIcon: Icon(Icons.search, color: Colors.grey),
                //       border: UnderlineInputBorder(),
                //       contentPadding: EdgeInsets.symmetric(vertical: 8),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth * 0.28; // Match action card width
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildPatientCard(cardWidth),
                            SizedBox(width: 10),
                            _buildPatientCard(cardWidth),
                            SizedBox(width: 10), 
                            _buildPatientCard(cardWidth),
                            SizedBox(width: 10), 
                            _buildPatientCard(cardWidth),
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
      width: MediaQuery.of(context).size.width * 0.28,
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
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

  Widget _buildPatientCard(double width) {
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
}