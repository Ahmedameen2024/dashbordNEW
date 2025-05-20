import 'package:flutter/material.dart';
import 'package:flutter_application_1/controll/nav_controller.dart';
// import 'package:flutter_application_1/screen/home.dart';
import 'package:get/get.dart';

class Bottomnavigation extends StatefulWidget {
  
  
  final List<Widget> phonePage;
  const Bottomnavigation({super.key,required this.phonePage});
  

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  final NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      currentIndex: navController.selectedPhoneIndex.value,
      onTap: (index) {
        navController.selectedPhoneIndex.value = index;
        navController.currentPage.value =widget.phonePage[index];
      },
      type: BottomNavigationBarType.fixed,
      // backgroundColor: Color(0xFF2A2F4F),
      // selectedItemColor: Colors.white,
      // unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Collage'),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Job'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Services'),
      ],
    );
  }
}