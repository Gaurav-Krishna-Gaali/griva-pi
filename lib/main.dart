import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'screens/patient_list_screen.dart';
import 'login_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  // Initialize FFI
  sqfliteFfiInit();
  // Change the default factory
  databaseFactory = databaseFactoryFfi;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1280, 800),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GrivaLoginPage(),
          navigatorObservers: [routeObserver],
        );
      },
    );
  }
}
