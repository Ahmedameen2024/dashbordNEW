import 'package:flutter/material.dart';
import 'package:flutter_application_1/controll/nav_controller.dart';
import 'package:flutter_application_1/model/modelresearch.dart';
// import 'package:flutter_application_1/screen/collage.dart';
// import 'package:flutter_application_1/widget/custom_app_bar.dart';
// import 'package:flutter_application_1/widget/listcollageanddepartment.dart';
import 'package:get/get.dart';

class ResearchPage extends StatelessWidget {
  final String departmentName;
  final List<Research>? researches;

  ResearchPage({super.key, required this.departmentName, this.researches});
// void openPDF(String url, BuildContext context) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('تعذر فتح الرابط')),
//       );
//     }
//   }
  final NavController navController = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    // Get.put(NavController());
    return Scaffold(
      appBar: AppBar(
        title: Text('أبحاث $departmentName'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: researches!.length,
        itemBuilder: (context, index) {
          final research = researches![index];
          return Card(
            shadowColor: Colors.blueGrey,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              title: Text(research.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(research.summary),
              ),
              trailing: IconButton(
                icon: Icon(Icons.download_rounded, color: Colors.teal),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('جاري تحميل بحث: ${research.title}')),
                  );
                  // يمكنك استخدام launch(url) من حزمة url_launcher
                },
              ),
              leading: Text('2025'),
            ),
          );
        },
      ),
    );
  }
}
