// import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
// // import 'package:flutter_application_1/controll/listgradustes.dart';
// // import 'package:flutter_application_1/controll/listgradustes.dart';
// // import 'package:flutter_application_1/controll/nav_controller.dart';
// import 'package:flutter_application_1/model/modelgraduates.dart';
// // import 'package:flutter_application_1/screen/collage.dart';
// import 'package:get/get.dart';

// class Graduatespage extends StatelessWidget {
//   // const Graduatespage({super.key});

//   final String departmentName;
//   final List<Graduate> graduates;

//   const Graduatespage(
//       {super.key, required this.departmentName, required this.graduates});

//   @override
//   Widget build(BuildContext context, {Key? key}) {
//     // final NavController navController = Get.find();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Graduates $departmentName'),
//         leading: IconButton(
//             onPressed: () {
//               // Navigator.pop(context);
//               // navController.currentPage.value = FacultiesPage();
//               Get.back();
//             },
//             icon: Icon(Icons.arrow_back)),
//         backgroundColor: Colors.teal,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(12),
//         itemCount: graduates.length,
//         itemBuilder: (context, index) {
//           final graduate = graduates[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8),
//             shape: RoundedRectangleBorder(
//               side: BorderSide(
//                 color: Colors.teal,
//                 width: 2,
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ListTile(
//               title: Text(graduate.name,
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Text(graduate.id),
//               ),
//               trailing: Text(
//                 graduate.graduationYear.toString(),
//               ),
//               leading: const CircleAvatar(
//                 backgroundImage: AssetImage('images/ResearchIcon.png'),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/modelgraduates.dart'; // تأكد من وجود النموذج المناسب
import 'package:get/get.dart';

class GraduatesPage extends StatelessWidget {
  final String departmentId;
  final String departmentName;

  const GraduatesPage({super.key, required this.departmentId, required this.departmentName});

  // تابع لتحميل الخريجين من Firestore بناءً على departmentId
  Stream<List<Graduate>> getGraduatesFromFirestore(String departmentName) {
    return FirebaseFirestore.instance
        .collection('graduates')
        .where('department', isEqualTo: departmentName)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Graduate.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graduates $departmentName'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<List<Graduate>>(
        stream: getGraduatesFromFirestore(departmentName), // جلب البيانات من Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final graduates = snapshot.data ?? [];

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: graduates.length,
            itemBuilder: (context, index) {
              final graduate = graduates[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.teal,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(graduate.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(graduate.id),
                  ),
                  trailing: Text(
                    graduate.graduationYear.toString(),
                  ),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('images/ResearchIcon.png'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
