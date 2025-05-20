import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UniversityTablePage extends StatefulWidget {
  const UniversityTablePage({super.key});

  @override
  State<UniversityTablePage> createState() => _UniversityTablePageState();
}

class _UniversityTablePageState extends State<UniversityTablePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // جلب عدد الكليات المرتبطة بجامعة معينة
  Future<int> getNumberOfFaculties(String universityId) async {
    final snapshot = await firestore
        .collection(
            'colleges') // أو collection('universities').doc(id).collection('colleges')
        .where('universityId', isEqualTo: universityId)
        .get();
    return snapshot.docs.length;
  }

  // حوار إضافة أو تعديل الجامعة
  void showUniversityDialog({DocumentSnapshot? doc}) {
    final isEditing = doc != null;
    final data = isEditing ? doc.data() as Map<String, dynamic> : {};

    final TextEditingController nameController =
        TextEditingController(text: data['universityName'] ?? '');
    final TextEditingController adminController =
        TextEditingController(text: data['adminName'] ?? '');
    final TextEditingController descController =
        TextEditingController(text: data['description'] ?? '');
    final TextEditingController passwordController =
        TextEditingController(text: data['password'] ?? '');
    final TextEditingController emailController =
        TextEditingController(text: data['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'تعديل الجامعة' : 'إضافة جامعة'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الجامعة'),
              ),
              TextField(
                controller: adminController,
                decoration: const InputDecoration(labelText: 'المدير'),
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
                'universityName': nameController.text,
                'adminName': adminController.text,
                'description': descController.text,
                'password': passwordController.text,
                'email': emailController.text,
              };

              if (isEditing) {
                await firestore
                    .collection('universities')
                    .doc(doc.id)
                    .update(newData);
                final querySnapshot = await firestore
                    .collection('users')
                    .where('universityId', isEqualTo: doc.id)
                    .get();
                for (var doc in querySnapshot.docs) {
                  doc.reference.update({
                    'email': emailController.text,
                    'password': passwordController.text,
                  });
                }
              } else {
                // إنشاء حساب المدير في Firebase Auth
                final userCredential =
                    await _auth.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                final universityDoc =
                    await firestore.collection('universities').add(newData);

                // Use the userCredential variable to get the user's ID
                final userId = userCredential.user!.uid;
                // إنشاء أدمن للجامعة في مجموعة users
                await firestore.collection('users').doc(userId).set({
                  'role': 'universityAdmin',
                  'username': adminController.text,
                  'universityId': universityDoc.id,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'createdAt': FieldValue.serverTimestamp(),
                });
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
    // final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الجامعات'),
        backgroundColor: Colors.blue[200],
        actions: [
          ElevatedButton.icon(
            onPressed: () => showUniversityDialog(),
            icon: const Icon(Icons.add),
            label: const Text('إضافة جامعة'),
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
          stream: firestore.collection('universities').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('اسم الجامعة')),
                  DataColumn(label: Text('المدير')),
                  DataColumn(label: Text('الوصف')),
                  DataColumn(label: Text('كلمة المرور')),
                  DataColumn(label: Text('الإيميل')),
                  DataColumn(label: Text('عدد الكليات')),
                  DataColumn(label: Text('تحكم')),
                ],
                rows: data.map((doc) {
                  final d = doc.data() as Map<String, dynamic>;
                  return DataRow(cells: [
                    DataCell(Text(d['universityName'] ?? '')),
                    DataCell(Text(d['adminName'] ?? '')),
                    DataCell(Text(d['description'] ?? '')),
                    DataCell(Text(d['password'] ?? '')),
                    DataCell(Text(d['email'] ?? '')),
                    DataCell(
                      FutureBuilder<int>(
                        future: getNumberOfFaculties(doc.id),
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
                          onPressed: () => showUniversityDialog(doc: doc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await firestore
                                .collection('universities')
                                .doc(doc.id)
                                .delete();
                            final querySnapshot = await firestore
                                .collection('users')
                                .where('universityId', isEqualTo: doc.id)
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


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class UniversityTablePage extends StatefulWidget {
//   const UniversityTablePage({super.key});

//   @override
//   State<UniversityTablePage> createState() => _UniversityTablePageState();
// }

// class _UniversityTablePageState extends State<UniversityTablePage> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // جلب عدد الكليات المرتبطة بجامعة معينة
//   Future<int> getNumberOfFaculties(String universityId) async {
//     final snapshot = await firestore
//         .collection('colleges')
//         .where('universityId', isEqualTo: universityId)
//         .get();
//     return snapshot.docs.length;
//   }

//   // حوار إضافة أو تعديل الجامعة
//   void showUniversityDialog({DocumentSnapshot? doc}) {
//     final isEditing = doc != null;
//     final data = isEditing ? doc.data() as Map<String, dynamic> : {};

//     final TextEditingController nameController =
//         TextEditingController(text: data['universityName'] ?? '');
//     final TextEditingController adminController =
//         TextEditingController(text: data['adminName'] ?? '');
//     final TextEditingController descController =
//         TextEditingController(text: data['description'] ?? '');
//     final TextEditingController passwordController =
//         TextEditingController(text: data['password'] ?? '');
//     final TextEditingController emailController =
//         TextEditingController(text: data['email'] ?? '');

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(isEditing ? 'تعديل الجامعة' : 'إضافة جامعة'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'اسم الجامعة'),
//               ),
//               TextField(
//                 controller: adminController,
//                 decoration: const InputDecoration(labelText: 'المدير'),
//               ),
//               TextField(
//                 controller: descController,
//                 decoration: const InputDecoration(labelText: 'الوصف'),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(labelText: 'كلمة المرور'),
//               ),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'الإيميل'),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('إلغاء'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final newData = {
//                 'universityName': nameController.text.trim(),
//                 'adminName': adminController.text.trim(),
//                 'description': descController.text.trim(),
//                 'password': passwordController.text.trim(),
//                 'email': emailController.text.trim(),
//               };

//               if (isEditing) {
//                 await firestore
//                     .collection('universities')
//                     .doc(doc.id)
//                     .update(newData);

//                 final querySnapshot = await firestore
//                     .collection('users')
//                     .where('universityId', isEqualTo: doc.id)
//                     .get();
//                 for (var doc in querySnapshot.docs) {
//                   doc.reference.update({
//                     'email': emailController.text.trim(),
//                     'password': passwordController.text.trim(),
//                   });
//                 }
//               } else {
//                 try {
//                   // إنشاء حساب المدير في Firebase Auth
//                   final userCredential =
//                       await _auth.createUserWithEmailAndPassword(
//                     email: emailController.text.trim(),
//                     password: passwordController.text.trim(),
//                   );

//                   // إضافة الجامعة إلى Firestore
//                   final universityDoc =
//                       await firestore.collection('universities').add(newData);
//                   // إضافة بيانات المستخدم في مجموعة users
//                   await firestore
//                       .collection('users')
//                       .doc(userCredential.user!.uid)
//                       .set({
//                     'role': 'universityAdmin',
//                     'username': adminController.text.trim(),
//                     'email': emailController.text.trim(),
//                     'universityId': universityDoc.id,
//                     'createdAt': FieldValue.serverTimestamp(),
//                   });

//                   // إغلاق الحوار
//                   Navigator.pop(context);
//                 } on FirebaseAuthException catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('خطأ: ${e.message}')),
//                   );
//                 }
//               }
//             },
//             child: Text(isEditing ? 'تحديث' : 'إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('إدارة الجامعات'),
//         actions: [
//           ElevatedButton.icon(
//             onPressed: () => showUniversityDialog(),
//             icon: const Icon(Icons.add),
//             label: const Text('إضافة جامعة'),
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: firestore.collection('universities').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final data = snapshot.data!.docs;

//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text('اسم الجامعة')),
//                   DataColumn(label: Text('المدير')),
//                   DataColumn(label: Text('الوصف')),
//                   DataColumn(label: Text('كلمة المرور')),
//                   DataColumn(label: Text('الإيميل')),
//                   DataColumn(label: Text('عدد الكليات')),
//                   DataColumn(label: Text('تحكم')),
//                 ],
//                 rows: data.map((doc) {
//                   final d = doc.data() as Map<String, dynamic>;
//                   return DataRow(cells: [
//                     DataCell(Text(d['universityName'] ?? '')),
//                     DataCell(Text(d['adminName'] ?? '')),
//                     DataCell(Text(d['description'] ?? '')),
//                     DataCell(Text(d['password'] ?? '')),
//                     DataCell(Text(d['email'] ?? '')),
//                     DataCell(
//                       FutureBuilder<int>(
//                         future: getNumberOfFaculties(doc.id),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) return const Text('...');
//                           return Text(snapshot.data!.toString());
//                         },
//                       ),
//                     ),
//                     DataCell(Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () => showUniversityDialog(doc: doc),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () async {
//                             await firestore
//                                 .collection('universities')
//                                 .doc(doc.id)
//                                 .delete();
//                             final querySnapshot = await firestore
//                                 .collection('users')
//                                 .where('universityId', isEqualTo: doc.id)
//                                 .get();
//                             for (var doc in querySnapshot.docs) {
//                               await doc.reference.delete();
//                             }
//                           },
//                         ),
//                       ],
//                     )),
//                   ]);
//                 }).toList(),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
