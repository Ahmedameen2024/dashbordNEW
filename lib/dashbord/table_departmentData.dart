// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashbord/widget/DepartmentTableHelper.dart';
// import 'package:flutter_application_1/dashbord/widget/departmentmangar.dart';

// class TableDepartmentdata extends StatefulWidget {
//   const TableDepartmentdata({super.key});

//   @override
//   State<TableDepartmentdata> createState() => _TableDepartmentdataState();
// }

// class _TableDepartmentdataState extends State<TableDepartmentdata> {
//   List<Map<String, String>> departments = [
//     {
//       'name': 'علوم الحاسوب',
//       'description': 'كلية الحاسبات وتقنية المعلومات',
//       'head': 'د. أحمد العتيبي',
//       'password': "250",
//     },
//     {
//       'name': 'الهندسة الكهربائية',
//       'description': 'كلية الهندسة',
//       'head': 'د. خالد الزهراني',
//       'password': "180",
//     },
//     {
//       'name': 'اللغة الإنجليزية',
//       'description': 'كلية الآداب',
//       'head': 'د. منى الشمري',
//       'password': "320",
//     },
//     {
//       'name': 'القانون العام',
//       'description': 'كلية الحقوق',
//       'head': 'د. عبدالعزيز القرني',
//       'password': '150',
//     },
//     {
//       'name': 'إدارة الأعمال',
//       'description': 'كلية العلوم الإدارية',
//       'head': 'د. سارة السبيعي',
//       'password': "275",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     // final screenWidth = MediaQuery.of(context).size.width;
//     // final screenHeight = MediaQuery.of(context).size.height;
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' التحكم باالاقسام'),
//         actions: [
//           ElevatedButton.icon(
//             icon: const Icon(Icons.add),
//             label: Text('إضافة قسم '),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => DepartmentDialogManager(
//                   dialogType: 'add',
//                   onSave: (newDept) {
//                     setState(() {
//                       departments.add(newDept);
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
//                     columns: DepartmentTableHelper.buildColumns(isMobile),
//                     rows: List.generate(departments.length, (index) {
//                       final dept = departments[index];
//                       return DepartmentTableHelper.buildRow(
//                         department: dept,
//                         index: index,
//                         isMobile: isMobile,
//                         onEdit: () {
//                           // استدعاء دالة تعديل القسم
//                           showDialog(
//                             context: context,
//                             builder: (_) => DepartmentDialogManager(
//                               dialogType: 'edit',
//                               department: dept,
//                               onSave: (updatedDept) {
//                                 setState(() {
//                                   departments[index] = updatedDept;
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
//                             builder: (_) => DepartmentDialogManager(
//                               dialogType: 'delete',
//                               department: dept,
//                               onSave: (newDept) {}, // لن نستخدم التعديل هنا
//                               onDelete: () {
//                                 setState(() {
//                                   departments.removeAt(index);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DepartmentTablePage extends StatefulWidget {
  // final List<Map<String, dynamic>> departments;
  final String collegeId; // يتم تمرير collegeId من صفحة الكلية
  const DepartmentTablePage({super.key, required this.collegeId});

  @override
  State<DepartmentTablePage> createState() => _DepartmentTablePageState();
}

class _DepartmentTablePageState extends State<DepartmentTablePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // حوار إضافة أو تعديل القسم
  void showDepartmentDialog({DocumentSnapshot? doc}) {
    final isEditing = doc != null;
    final data = isEditing ? doc.data() as Map<String, dynamic> : {};

    final TextEditingController nameController =
        TextEditingController(text: data['departmentName'] ?? '');
    final TextEditingController headController =
        TextEditingController(text: data['headName'] ?? '');
    final TextEditingController descController =
        TextEditingController(text: data['description'] ?? '');
    final TextEditingController emailController =
        TextEditingController(text: data['email'] ?? '');
    final TextEditingController passwordController =
        TextEditingController(text: data['password'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'تعديل القسم' : 'إضافة قسم'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم القسم'),
              ),
              TextField(
                controller: headController,
                decoration: const InputDecoration(labelText: 'رئيس القسم'),
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
                'departmentName': nameController.text,
                'headName': headController.text,
                'description': descController.text,
                'collegeId': widget.collegeId,
                'password': passwordController.text,
                'email': emailController.text,
              };

              if (isEditing) {
                await firestore
                    .collection('departments')
                    .doc(doc.id)
                    .update(newData);
                // تحديث بيانات رئيس القسم في Firebase Auth
                final querySnapshot = await firestore
                    .collection('users')
                    .where('departmentId', isEqualTo: doc.id)
                    .get();
                for (var userDoc in querySnapshot.docs) {
                  userDoc.reference.update({
                    'email': emailController.text,
                    'password': passwordController.text,
                  });
                }
              } else {
                // إنشاء حساب رئيس القسم في Firebase Auth
                final userCredential =
                    await _auth.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                final departmentDoc =
                    await firestore.collection('departments').add(newData);

                // استخدام userCredential للحصول على معرف المستخدم
                final userId = userCredential.user!.uid;

                // إنشاء مستند المستخدم (رئيس القسم) في مجموعة users
                await firestore.collection('users').doc(userId).set({
                  'role': 'departmentHead',
                  'username': headController.text,
                  'collegeId': widget.collegeId,
                  'departmentId': departmentDoc.id,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'createdAt': FieldValue.serverTimestamp(),
                });
              }

              // غلق الحوار بعد إضافة أو تعديل البيانات
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text('إدارة الأقسام'),
        actions: [
          ElevatedButton.icon(
            onPressed: () => showDepartmentDialog(),
            icon: const Icon(Icons.add),
            label: const Text('إضافة قسم'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('departments').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('اسم القسم')),
                  DataColumn(label: Text('رئيس القسم')),
                  DataColumn(label: Text('الوصف')),
                  DataColumn(label: Text('ايميل')),
                  DataColumn(label: Text('كلمة المرور')),
                  DataColumn(label: Text('تحكم')),
                ],
                rows: data.map((doc) {
                  final d = doc.data() as Map<String, dynamic>;
                  return DataRow(cells: [
                    DataCell(Text(d['departmentName'] ?? '')),
                    DataCell(Text(d['headName'] ?? '')),
                    DataCell(Text(d['description'] ?? '')),
                    DataCell(Text(d['email'] ?? '')),
                    DataCell(Text(d['password'] ?? '')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showDepartmentDialog(doc: doc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await firestore
                                .collection('departments')
                                .doc(doc.id)
                                .delete();
                            final querySnapshot = await firestore
                                .collection('users')
                                .where('departmentId', isEqualTo: doc.id)
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
    );
  }
}
