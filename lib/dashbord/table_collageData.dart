// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashbord/addbutton.dart';
// import 'package:flutter_application_1/dashbord/editbutton.dart';
// import 'package:flutter_application_1/dashbord/hederbardashbord.dart';
// import 'package:flutter_application_1/widget/my_button.dart';

// class TableCollagedata extends StatefulWidget {
//   const TableCollagedata({super.key});

//   @override
//   State<TableCollagedata> createState() => _TableCollagedataState();
// }

// class _TableCollagedataState extends State<TableCollagedata> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 650,
//         decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(20)),
//         padding: EdgeInsets.all(20),
//         child: Column(children: [
//           Hederbardashbord(
//             page_name: 'Collage',
//             button: MyButton(
//                 color: Colors.blue,
//                 titel: 'Add Collage',
//                 onpressed: () {
//                   Addbutton.ShowCustomDilalog(
//                       context: context,
//                       title: 'Add colage',
//                       controller: TextEditingController(),
//                       admin: TextEditingController(),
//                       password: TextEditingController()
//                       // action: []
//                       );
//                 }),
//           ),
//           Divider(thickness: 0.5, color: Colors.green),
//           Table(
//             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//             children: [
//               //HeaderTable
//               TableRow(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(color: Colors.green, width: 0.5),
//                     ),
//                   ),
//                   children: [
//                     tableHedar('collage Name'),
//                     tableHedar('Department'),
//                     tableHedar('Collage Dean'),
//                     tableHedar(''),
//                   ]),
//             ],
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Table(
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 children: [
//                   tabblRow(context,
//                       name: 'الطب',
//                       image: 'images/كلية الطب .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الهندسةوتقنيةالمعلومات',
//                       image: 'images/كلية العلوم الإدارية .png',
//                       department: 10,
//                       dean: 'Ahmed'),
//                   tabblRow(context,
//                       name: 'العلوم التطبيقية',
//                       image: 'images/كلية العلوم التطبيقية .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'العلوم الإدارية',
//                       image: 'images/managmentscinecie.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الحقوق',
//                       image: 'images/كلية الحقوق.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الأداب',
//                       image:
//                           'images/png-transparent-paper-ink-fountain-pen-ballpoint-pen-pen-and-ink-ink-textile-cosmetics-thumbnail.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'التربية',
//                       image: 'images/كلية التربية ٣.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'اللغات والترجمة',
//                       image: 'images/اللغات والترجمة .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الحاسب الالي',
//                       image: 'images/الحاسب الآلي .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'التعليم المستمر',
//                       image: 'images/كلية العلوم الإدارية .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                 ],
//               ),
//             ),
//           )
//           //Data Table
//         ]),
//       ),
//     );
//   }

//   TableRow tabblRow(
//     context, {
//     name,
//     image,
//     department,
//     dean,
//   }) {
//     return TableRow(
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Colors.green, width: 0.5),
//           ),
//         ),
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 15),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(1000),
//                   child: Image.asset(
//                     "$image",
//                     // height: 40,
//                     width: 60,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(name),
//               ],
//             ),
//           ),
//           Text('$department'),
//           Row(
//             children: [
//               // Container(
//               //     decoration: BoxDecoration(
//               //         shape: BoxShape.circle, color: AppColors.maincolor),
//               //     height: 10,
//               //     width: 10),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(dean)
//             ],
//           ),
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {
//                     Editbutton.showAlert(
//                         context: context,
//                         title: 'Edit',
//                         content: Text('Bilalaa dfhjgfsbvs hfhgfjgf ?'),
//                         action: [
//                           TextButton(
//                               onPressed: () {
//                                 Addbutton.ShowCustomDilalog(
//                                     context: context,
//                                     title: 'Edit collage or Admin',
//                                     controller: TextEditingController(),
//                                     admin: TextEditingController(),
//                                     password: TextEditingController());
//                               },
//                               child: Text('oke')),
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('No'))
//                         ]);
//                   },
//                   icon: Icon(Icons.edit)),
//               Icon(Icons.more_vert),
//               IconButton(onPressed: () {}, icon: Icon(Icons.delete))
//             ],
//           )
//         ]);
//   }

//   Widget tableHedar(text) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 15),
//       child: Text(
//         text,
//         style: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   // Widget alertButton({title, p, f, g}) {
//   //   return ListTile(
//   //     title: Text(title),
//   //     onTap: () {
//   //       Editbutton.showAlert(
//   //         context: context,
//   //         title: title,
//   //         content: Column(
//   //           children: [
//   //             Text('Bilalaa dfhjgfsbvs hfhgfjgf $title?'),
//   //             Row(
//   //               children: [
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Addbutton.ShowCustomDilalog(
//   //                         context: context,
//   //                         title: 'Edit $title',
//   //                         controller:f,
//   //                         admin: p,
//   //                         password: g);
//   //                   },
//   //                   child: Text('Oke'),
//   //                 ),
//   //                 TextButton(
//   //                   onPressed: () {},
//   //                   child: Text('No'),
//   //                 ),
//   //               ],
//   //             )
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashbord/widget/addbutton.dart';
// import 'package:flutter_application_1/dashbord/widget/editbutton.dart';
// import 'package:flutter_application_1/dashbord/widget/hederbardashbord.dart';
// import 'package:flutter_application_1/dashbord/widget/opreation.dart';
// import 'package:flutter_application_1/dashbord/widget/popmenubutton.dart';
// import 'package:flutter_application_1/dashbord/widget/tablehedar.dart';
// // import 'package:flutter_application_1/dashbord/widget/tablerowdata.dart';
// import 'package:flutter_application_1/widget/my_button.dart';

// class TableCollagedata extends StatefulWidget {
//   const TableCollagedata({super.key});

//   @override
//   State<TableCollagedata> createState() => _TableCollagedataState();
// }

// class _TableCollagedataState extends State<TableCollagedata> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return Container(
//       height: screenHeight * 0.90,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Hederbardashbord(
//             page_name: 'Collage',
//             button: MyButton(
//               color: Colors.blue,
//               titel: 'Add Collage',
//               onpressed: () {
//                 Addbutton.ShowCustomDilalog(
//                   context: context,
//                   title: 'Add colage',
//                   controller: TextEditingController(),
//                   admin: TextEditingController(),
//                   password: TextEditingController(),
//                 );
//               },
//             ),
//           ),
//           const Divider(thickness: 0.5, color: Colors.green),
//           Table(
//             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//             columnWidths: const {
//               0: FlexColumnWidth(2),
//               1: FlexColumnWidth(2),
//               2: FlexColumnWidth(2),
//               3: FlexColumnWidth(1),
//             },
//             children: [
//               TableRow(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.green, width: 0.5),
//                   ),
//                 ),
//                 children: [
//                   Tablehedar(name: 'collage Name'),
//                   Tablehedar(name: 'Department'),
//                   Tablehedar(name: 'Collage Dean'),
//                   Tablehedar(name: ''),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Table(
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 columnWidths: const {
//                   0: FlexColumnWidth(2),
//                   1: FlexColumnWidth(2),
//                   2: FlexColumnWidth(2),
//                   3: FlexColumnWidth(1.2),
//                 },
//                 children: [
//                   tabblRow(context,
//                       name: 'الطب',
//                       image: 'images/كلية الطب .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الهندسةوتقنيةالمعلومات',
//                       image: 'images/كلية العلوم الإدارية .png',
//                       department: 10,
//                       dean: 'Ahmed'),
//                   tabblRow(context,
//                       name: 'العلوم التطبيقية',
//                       image: 'images/كلية العلوم التطبيقية .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'العلوم الإدارية',
//                       image: 'images/managmentscinecie.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الحقوق',
//                       image: 'images/كلية الحقوق.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الأداب',
//                       image:
//                           'images/png-transparent-paper-ink-fountain-pen-ballpoint-pen-pen-and-ink-ink-textile-cosmetics-thumbnail.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'التربية',
//                       image: 'images/كلية التربية ٣.png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'اللغات والترجمة',
//                       image: 'images/اللغات والترجمة .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'الحاسب الالي',
//                       image: 'images/الحاسب الآلي .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                   tabblRow(context,
//                       name: 'التعليم المستمر',
//                       image: 'images/كلية العلوم الإدارية .png',
//                       department: 10,
//                       dean: 'Dr.jamal AL Ameri'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   TableRow tabblRow(BuildContext context,
//       {required String name,
//       required String image,
//       required int department,
//       required String dean}) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return TableRow(
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.green, width: 0.5),
//         ),
//       ),
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(1000),
//                 child: Image.asset(
//                   image,
//                   width: screenWidth * 0.08,
//                   height: screenWidth * 0.08,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Flexible(
//                 child: Text(name, overflow: TextOverflow.ellipsis),
//               ),
//             ],
//           ),
//         ),
//         Center(child: Text('$department')),
//         // const SizedBox(width: 10),
//         Text(dean, overflow: TextOverflow.ellipsis),
//         opreation(isMobile: isMobile,onEdit: (){},onDelete:(){})
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashbord/collageManager.dart';
// import 'package:flutter_application_1/dashbord/widget/collageTable.dart';

// class TableCollagedata extends StatefulWidget {
//   const TableCollagedata({super.key});

//   @override
//   State<TableCollagedata> createState() => _TableCollagedataState();
// }

// class _TableCollagedataState extends State<TableCollagedata> {
//   List<Map<String, String>> collages = [
//     {
//       'name': 'images/كلية الطب .png',
//       'dean': 'الطب',
//       'password': 'د. أحمد العتيبي',
//       'departments': "250",
//     },
//     {
//       'name': 'images/كلية العلوم الإدارية .png',
//       'dean': 'كلية الهندسة',
//       'password': 'د. خالد الزهراني',
//       'departments': "180",
//     },
//     {
//       'name': 'images/كلية التربية ٣.png',
//       'dean': 'كلية الآداب',
//       'password': 'د. منى الشمري',
//       'departments': "320",
//     },
//     {
//       'name': 'images/كلية الحقوق.png',
//       'dean': 'كلية الحقوق',
//       'password': 'د. عبدالعزيز القرني',
//       'departments': '150',
//     },
//     {
//       'name': 'images/كلية العلوم الإدارية .png',
//       'dean': 'كلية العلوم الإدارية',
//       'password': 'د. سارة السبيعي',
//       'departments': "10",
//     },
//     {
//       'name': 'images/كلية العلوم التطبيقية .png',
//       'dean': 'كلية العلوم التطبيقية',
//       'password': 'د. سارة السبيعي',
//       'departments': "20",
//     },
//     {
//       'name': 'images/الحاسب الآلي .png',
//       'dean': 'الحاسب الالي',
//       'password': 'د. سارة السبيعي',
//       'departments': "10",
//     },
//     {
//       'name': 'images/كلية العلوم الإدارية .png',
//       'dean': 'كلية العلوم الإدارية',
//       'password': 'د. سارة السبيعي',
//       'departments': "275",
//     },
//     {
//       'name': 'images/كلية العلوم الإدارية .png',
//       'dean': 'كلية العلوم الإدارية',
//       'password': 'د. سارة السبيعي',
//       'departments': "275",
//     },
//     {
//       'name': 'كلية العلوم الإدارية',
//       'dean': 'د. سارة السبيعي',
//       'password': 'د. سارة السبيعي',
//       'departments': "275",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('صفحة التحكم با الكليات'),
//         actions: [
//           ElevatedButton.icon(
//             icon: const Icon(Icons.add),
//             label: const Text('إضافة كلية '),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => Collagemanager(
//                   dialogType: 'add',
//                   onSave: (newDept) {
//                     setState(() {
//                       collages.add(newDept);
//                     });
//                   },
//                   onDelete: () {}, // لن نستخدم الحذف هنا
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//                 constraints: BoxConstraints(minWidth: constraints.maxWidth),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: DataTable(
//                     columns: CollageTable.buildColumns(isMobile),
//                     rows: List.generate(collages.length, (index) {
//                       final coll = collages[index];
//                       return CollageTable.buildRow(
//                         collage: coll,
//                         index: index,
//                         isMobile: isMobile,
//                         onEdit: () {
//                           // استدعاء دالة تعديل القسم
//                           showDialog(
//                             context: context,
//                             builder: (_) => Collagemanager(
//                               dialogType: 'edit',
//                               collage: coll,
//                               onSave: (updatedDept) {
//                                 setState(() {
//                                   collages[index] = updatedDept;
//                                 });
//                               },
//                               onDelete: () {}, // لن نستخدم الحذف هنا
//                             ),
//                           );
//                         },
//                         onDelete: () {
//                           // استدعاء دالة حذف القسم

//                           showDialog(
//                             context: context,
//                             builder: (_) => Collagemanager(
//                               dialogType: 'delete',
//                               collage: coll,
//                               onSave: (newDept) {}, // لن نستخدم التعديل هنا
//                               onDelete: () {
//                                 setState(() {
//                                   collages.removeAt(index);
//                                 });
//                               },
//                             ),
//                           );
//                         },
//                       );
//                     }),
//                   ),
//                 )),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_1/dashbord/collageManager.dart';
// import 'package:flutter_application_1/dashbord/widget/collageTable.dart';

// class TableCollagedata extends StatefulWidget {
//   const TableCollagedata({super.key});

//   @override
//   State<TableCollagedata> createState() => _TableCollagedataState();
// }

// class _TableCollagedataState extends State<TableCollagedata> {
//   final CollectionReference collageCollection =
//       FirebaseFirestore.instance.collection('collages');

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('صفحة التحكم بالكليات'),
//         actions: [
//           ElevatedButton.icon(
//             icon: const Icon(Icons.add),
//             label: const Text('إضافة كلية'),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => Collagemanager(
//                   dialogType: 'add',
//                   onSave: (newCollage) async {
//                     await collageCollection.add(newCollage);
//                     // Navigator.pop(context);
//                   },
//                   onDelete: () {},
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: collageCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final collages = snapshot.data!.docs;

//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints:
//                   BoxConstraints(minWidth: MediaQuery.of(context).size.width),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: DataTable(
//                   columns: CollageTable.buildColumns(isMobile),
//                   rows: collages.map((doc) {
//                     final data = doc.data() as Map<String, dynamic>;
//                     return CollageTable.buildRow(
//                       collage: data,
//                       index: 0,
//                       isMobile: isMobile,
//                       onEdit: () {
//                         showDialog(
//                           context: context,
//                           builder: (_) => Collagemanager(
//                             dialogType: 'edit',
//                             collage: data,
//                             onSave: (updatedCollage) async {
//                               await collageCollection
//                                   .doc(doc.id)
//                                   .update(updatedCollage);
//                               // Navigator.pop(context);
//                             },
//                             onDelete: () {},
//                           ),
//                         );
//                       },
//                       onDelete: () {
//                         showDialog(
//                           context: context,
//                           builder: (_) => Collagemanager(
//                             dialogType: 'delete',
//                             collage: data,
//                             onSave: (_) {},
//                             onDelete: () async {
//                               await collageCollection.doc(doc.id).delete();
//                               // Navigator.pop(context);
//                             },
//                           ),
//                         );
//                       },
//                       docId: '',
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CollegeTablePage extends StatefulWidget {
  final String universityId; // يتم تمرير universityId من صفحة الجامعة
  const CollegeTablePage({super.key, required this.universityId});

  @override
  State<CollegeTablePage> createState() => _CollegeTablePageState();
}

class _CollegeTablePageState extends State<CollegeTablePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // جلب عدد الأقسام المرتبطة بكلية معينة
  Future<int> getNumberOfDepartments(String collegeId) async {
    final snapshot = await firestore
        .collection('departments')
        .where('collegeId', isEqualTo: collegeId)
        .get();
    return snapshot.docs.length;
  }

  // حوار إضافة أو تعديل الكلية
  void showCollegeDialog({DocumentSnapshot? doc}) {
    final isEditing = doc != null;
    final data = isEditing ? doc.data() as Map<String, dynamic> : {};

    final TextEditingController nameController =
        TextEditingController(text: data['collegeName'] ?? '');
    final TextEditingController deanController =
        TextEditingController(text: data['deanName'] ?? '');
    final TextEditingController descController =
        TextEditingController(text: data['description'] ?? '');
    final TextEditingController passwordController =
        TextEditingController(text: data['password'] ?? '');
    final TextEditingController emailController =
        TextEditingController(text: data['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'تعديل الكلية' : 'إضافة كلية'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الكلية'),
              ),
              TextField(
                controller: deanController,
                decoration: const InputDecoration(labelText: 'العميد'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'الوصف'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'كلمة المرور'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'الإيميل'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newData = {
                'collegeName': nameController.text,
                'deanName': deanController.text,
                'description': descController.text,
                'password': passwordController.text,
                'email': emailController.text,
                'universityId': widget.universityId
              };

              if (isEditing) {
                await firestore
                    .collection('colleges')
                    .doc(doc.id)
                    .update(newData);
                final querySnapshot = await firestore
                    .collection('users')
                    .where('collegeId', isEqualTo: doc.id)
                    .get();
                for (var doc in querySnapshot.docs) {
                  doc.reference.update({
                    'email': emailController.text,
                    'password': passwordController.text,
                  });
                }
              } else {
                // إنشاء حساب العميد في Firebase Auth
                try {
                  final userCredential =
                      await _auth.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  final collegeDoc =
                      await firestore.collection('colleges').add(newData);

                  // Use the userCredential variable to get the user's ID
                  final userId = userCredential.user!.uid;
                  // إنشاء أدمن للكلية في مجموعة users
                  await firestore.collection('users').doc(userId).set({
                    'role': 'facultyDean',
                    'username': deanController.text,
                    'universityId': widget.universityId,
                    'collegeId': collegeDoc.id,
                    'email': emailController.text,
                    'password': passwordController.text,
                    'createdAt': FieldValue.serverTimestamp(),
                  });
                } catch (e) {
                  print(e);
                }
              }

              Navigator.pop(context);
            },
            child: Text(isEditing ? 'تحديث' : 'إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          title: const Text('إدارة الكليات'),
          actions: [
            ElevatedButton.icon(
              onPressed: () => showCollegeDialog(),
              icon: const Icon(Icons.add),
              label: const Text('إضافة كلية'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('colleges').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.data!.docs;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('اسم الكلية')),
                    DataColumn(label: Text('العميد')),
                    DataColumn(label: Text('الوصف')),
                    DataColumn(label: Text('كلمة المرور')),
                    DataColumn(label: Text('الإيميل')),
                    DataColumn(label: Text('عدد الأقسام')),
                    DataColumn(label: Text('تحكم')),
                  ],
                  rows: data.map((doc) {
                    final d = doc.data() as Map<String, dynamic>;
                    return DataRow(cells: [
                      DataCell(Text(d['collegeName'] ?? '')),
                      DataCell(Text(d['deanName'] ?? '')),
                      DataCell(Text(d['description'] ?? '')),
                      DataCell(Text(d['password'] ?? '')),
                      DataCell(Text(d['email'] ?? '')),
                      DataCell(
                        FutureBuilder<int>(
                          future: getNumberOfDepartments(doc.id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text('...');
                            return Text(snapshot.data!.toString());
                          },
                        ),
                      ),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => showCollegeDialog(doc: doc),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await firestore
                                  .collection('colleges')
                                  .doc(doc.id)
                                  .delete();
                              final querySnapshot = await firestore
                                  .collection('users')
                                  .where('collegeId', isEqualTo: doc.id)
                                  .get();
                              for (var doc in querySnapshot.docs) {
                                await doc.reference.delete();
                              }
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
