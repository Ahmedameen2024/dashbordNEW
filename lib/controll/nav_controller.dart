// import 'package:get/get.dart';

// class NavController extends GetxController {
//   var currentIndex = 0.obs;

//   final List<String> titles = [
//     'chat',
//     'Collage',
//     'Jop',
//     'Servecs',
//     'profile',
//     'login',
//     'logout',
//   ];

//   void changePage(int index) {
//     currentIndex.value = index;
//   }

//   String get currentTitle => titles[currentIndex.value];
// }

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var currentPage = Rx<Widget>(Center(child: Text('Welcome')));
  
  var selectedPhoneIndex = 0.obs;
  var selectedDesktopIndex = 0.obs;

  // العنوان الحالي بناءً على الصفحة المختارة
  var titlesPhone = ['Chat', 'Collage', 'Job', 'Services'];
  var titlesDesktop = ['Chat', 'Collage', 'Job', 'Services', 'Profile', 'Login', 'Logout'];

  String get currentTitle {
    if (Get.context != null && MediaQuery.of(Get.context!).size.width > 600) {
      // شاشة عريضة (كمبيوتر)
      return titlesDesktop[selectedDesktopIndex.value];
    } else {
      // شاشة جوال
      return titlesPhone[selectedPhoneIndex.value];
    }
  }
}
