// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controll/nav_controller.dart';
import 'package:get/get.dart';
import 'search_page.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final GlobalKey<ScaffoldState>? scaffoldKey;

//   const CustomAppBar({super.key, required this.title, this.scaffoldKey});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color(0xFF2A2F4F),
//       title: Text(title, style: TextStyle(color: Colors.white)),
//       leading: IconButton(
//         icon: Icon(Icons.menu, color: Colors.white),
//         onPressed: () {
//           scaffoldKey?.currentState?.openDrawer();
//         },
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.search, color: Colors.white),
//           onPressed: () {
//             Get.to(() => SearchPage());
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }

// custom_app_bar.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'search_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomAppBar({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.find();

    return Obx(() => AppBar(
          // backgroundColor: Color(0xFF2A2F4F),
          title: Text(
            navController.currentTitle,
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              scaffoldKey?.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Get.to(() => SearchPage());
              },
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
