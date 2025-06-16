import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'screens/patient_list_screen.dart';
import 'screens/patient_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 800),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Patient Management System',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: const GrivaLoginPage(),
          routes: {
            '/patients': (context) => const PatientListScreen(),
            '/add-patient': (context) => const PatientFormScreen(),
          },
        );
      },
    );
  }
}
