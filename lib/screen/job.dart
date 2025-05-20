// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

// class Jobs extends StatefulWidget {
//   const Jobs({super.key});

//   @override
//   State<Jobs> createState() => _JobsState();
// }

// class _JobsState extends State<Jobs> {
//   bool selectedDepartment = false;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         padding: const EdgeInsets.all(12.0),
//         itemCount: 10,
//         itemBuilder: (context, i) {
//           return Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//               side: BorderSide(
//                 color: Colors.teal,
//                 width: 2,
//               ),
//             ),
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             elevation: 3,
//             child: ExpansionTile(
//                 leading: AdvancedAvatar(
//                   size: 45, image: const AssetImage('images/ResearchIcon.png'),
//                   // backgroundImage: AssetImage(faculty.imagePath),
//                   // radius: 25,
//                 ),
//                 title: Text(
//                   'Techear',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text('collage applyed seinces'),
//                 children: [
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           title: Text('dept.name'),
//                           onTap: () {
//                             setState(() {
//                               selectedDepartment != selectedDepartment;
//                             });
//                           },
//                         ),
//                         if (selectedDepartment) ...[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Text(
//                               'لا توجد نبذة متاحة.',
//                               style: TextStyle(color: Colors.grey[700]),
//                             ),
//                           ),
//                           //
//                           Divider(
//                             height: 2,
//                           ),
//                         ],
//                       ]),
//                 ]),
//           );
//         });
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  bool selectedDepartment = false;

  // دالة لجلب اسم الكلية حسب ID
  Future<String> _getCollegeName(String collegeId) async {
    final doc = await FirebaseFirestore.instance
        .collection('colleges')
        .doc(collegeId)
        .get();
    return doc.data()?['collegeName'] ?? 'كلية غير معروفة';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final jobs = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: jobs.length,
              itemBuilder: (context, i) {
                final job = jobs[i];
                final title = job['title'];
                final description = job['description'];
                // final createdBy = job['createdBy'] ?? 'مستخدم غير معروف';
                final collegeId = job['collegeId'];

                return FutureBuilder<String>(
                  future: _getCollegeName(collegeId),
                  builder: (context, collegeSnapshot) {
                    if (!collegeSnapshot.hasData) {
                      return const SizedBox(); // أو Skeleton
                    }

                    final collegeName = collegeSnapshot.data!;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.teal, width: 2),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      child: ExpansionTile(
                        leading: const AdvancedAvatar(
                          size: 45,
                          image: AssetImage('images/ResearchIcon.png'),
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('collageName:  $collegeName'),
                        children: [
                          ListTile(
                            title: Text('requirements:   $description'),
                            // subtitle: Text('أضيف بواسطة: $createdBy'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        });
  }
}
