import 'package:flutter/material.dart';
import 'package:flutter_application_1/controll/nav_controller.dart';
// import 'package:flutter_application_1/screen/collage.dart';
import 'package:flutter_application_1/screen/sin_in.dart';
import 'package:flutter_application_1/screen/welcom_screen.dart';
import 'package:flutter_application_1/them/lightthem.dart';
import 'package:flutter_application_1/them/darkthem.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  VoidCallback? changeThem;

  AppDrawer({
    super.key,
    this.changeThem,
  });
  // void @override

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final NavController navController = Get.put(NavController());
  void _changeTheme() {
    setState(() {
      appTheme = (appTheme == lightTheme) ? darkTheme : lightTheme;
    });
  }

  ThemeData? appTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Color(0xFF2A2F4F),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // decoration: BoxDecoration(color: Color(0xFF1E2336)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person, size: 30, color: Colors.grey),
                IconButton(
                  onPressed: widget.changeThem,
                  icon: Icon(
                      appTheme == lightTheme ? Icons.mode_night : Icons.sunny),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('الإعدادات', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.white),
            title: Text('حول التطبيق', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.login, color: Colors.white),
            title: Text('تسجيل دخول', style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.to(() => SinIn());
              // navController.currentPage.value = SinIn();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
            onTap: () {
              // navController.currentPage.value =
              //     FacultiesPage(); // مثال على التنقل
              Get.to(() => WelcomScreen());
            },
          ),
        ],
      ),
    );
  }
}
