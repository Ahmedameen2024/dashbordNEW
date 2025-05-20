import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controll/nav_controller.dart';
import 'package:flutter_application_1/dashbord/createUniversityAdmin.dart';
import 'package:flutter_application_1/dashbord/homepage_dashbord.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/Tixt.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(NavController());
  runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
}

// void main() {
//   Get.put(NavController()); // تسجيل NavController
//   // Get.put(AuthController()); // تسجيل AuthController
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ThemeData appThem = lightTheme;

  // void _changeTheme() {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: appThem,
      home: HomepageDashbord(),
    );
  }
}

//HomepageDashbord
//Home
