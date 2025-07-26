import 'package:flutter/material.dart';
import 'home_page.dart';
import 'custom_app_bar.dart';
import 'custom_drawer.dart';

class ConnectColposcopeScreen extends StatelessWidget {
  const ConnectColposcopeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FA),
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Text(
                    'Connecting to Colposcope',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Make sure your colposcope device is powered on and nearby. We\'ll scan automatically for available devices.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 28),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: Text(
                        'Devices Nearby',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ),
                  ),
                  _deviceCard('Colposcope A23'),
                  SizedBox(height: 10),
                  _deviceCard('Colposcope X18'),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.refresh, color: Color(0xFF8B44F7)),
                        label: Text('Refresh Scan', style: TextStyle(color: Color(0xFF8B44F7))),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF8B44F7)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        ),
                      ),
                      SizedBox(width: 18),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => HomePage()),
                            (route) => false,
                          );
                        },
                        child: Text('Back to Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Tip: Your device name usually appears as "Colposcope" followed by its model or ID.',
                      style: TextStyle(fontSize: 13, color: Colors.black54, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _deviceCard(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F9ED),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Text(
                          'Ready to connect',
                          style: TextStyle(fontSize: 12, color: Color(0xFF2ECC71), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text('Medical Colposcope', style: TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8B44F7),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
} 