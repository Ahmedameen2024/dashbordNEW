// import 'package:flutter/material.dart';

// class Collagemanager extends StatelessWidget {
//   final Map<String, String>? collage;
//   final Function(Map<String, String>) onSave;
//   final Function onDelete;
//   final String dialogType; // "add", "edit", "delete"

//   Collagemanager({
//     Key? key,
//     this.collage,
//     required this.onSave,
//     required this.onDelete,
//     required this.dialogType,
//   }) : super(key: key);

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController deanController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController departmentCountController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // If it's editing, populate the fields with existing department data
//     if (dialogType == 'edit' && collage != null) {
//       nameController.text = collage!['name'] ?? '';
//       deanController.text = collage!['dean'] ?? '';
//       passwordController.text = collage!['password'] ?? '';
//       departmentCountController.text = collage!['departments'] ?? '';
//     }

//     return AlertDialog(
//       title: Text(dialogType == 'add'
//           ? 'Add Collage '
//           : dialogType == 'edit'
//               ? 'Edit collage '
//               : 'تأكيد الحذف'),
//       content: dialogType == 'delete'
//           ? Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('هل أنت متأكد من حذف الكلية ${collage?['name'] ?? ''}?'),
//               ],
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildField(' اسم الكلية ', nameController),
//                   _buildField(' العميد', deanController),
//                   _buildField('كلمة المرور ', passwordController),
//                   _buildField('عدد الاقسام', departmentCountController),
//                 ],
//               ),
//             ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (dialogType == 'add' || dialogType == 'edit') {
//               final updatedDept = {
//                 'name': nameController.text,
//                 'dean': deanController.text,
//                 'password': passwordController.text,
//                 'departments': departmentCountController.text,
//               };
//               onSave(updatedDept);
//             } else if (dialogType == 'delete') {
//               onDelete();
//             }
//             Navigator.pop(context);
//           },
//           child: dialogType == 'delete'
//               ? const Text('حذف')
//               : dialogType == 'edit'
//                   ? const Text('حفظ')
//                   : const Text('إضافة'),
//         ),
//       ],
//     );
//   }

//   Widget _buildField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.orange, width: 1),
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue, width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class Collagemanager extends StatefulWidget {
//   final String? universityId;
//   final Map<String, dynamic>? collage;
//   final Function(Map<String, dynamic>) onSave;
//   final Function onDelete;
//   final String dialogType; // "add", "edit", "delete"

//   const Collagemanager({
//     super.key,
//     this.collage,
//     required this.onSave,
//     required this.onDelete,
//     required this.dialogType,  required this.universityId,
//   });

//   @override
//   State<Collagemanager> createState() => _CollagemanagerState();
// }

// class _CollagemanagerState extends State<Collagemanager> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController deanController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController departmentCountController = TextEditingController();

//   @override
//   void initState() {

//     super.initState();
//     final universityId = widget.universityId;
//     if (widget.dialogType == 'edit' && widget.collage != null) {

//       nameController.text = widget.collage!['name'] ?? '';
//       deanController.text = widget.collage!['dean'] ?? '';
//       passwordController.text = widget.collage!['password'] ?? '';
//       departmentCountController.text = widget.collage!['departments'] ?? '';
//     }
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     deanController.dispose();
//     passwordController.dispose();
//     departmentCountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.dialogType == 'add'
//           ? 'إضافة كلية جديدة'
//           : widget.dialogType == 'edit'
//               ? 'تعديل بيانات الكلية'
//               : 'تأكيد الحذف'),
//       content: widget.dialogType == 'delete'
//           ? Text('هل أنت متأكد من حذف الكلية "${widget.collage?['name'] ?? ''}"؟')
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildField('اسم الكلية', nameController),
//                   _buildField('اسم العميد', deanController),
//                   _buildField('كلمة المرور', passwordController),
//                   _buildField('عدد الأقسام', departmentCountController, inputType: TextInputType.number),
//                 ],
//               ),
//             ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (widget.dialogType == 'delete') {
//               widget.onDelete();
//               Navigator.pop(context);
//               return;
//             }

//             if (nameController.text.isEmpty ||
//                 deanController.text.isEmpty ||
//                 passwordController.text.isEmpty ||
//                 departmentCountController.text.isEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('يرجى تعبئة جميع الحقول')),
//               );
//               return;
//             }

//             final collageData = {
//               'role': 'collageAdmin',
//               'universityId': widget.universityId,
//               'name': nameController.text,
//               'dean': deanController.text,
//               'password': passwordController.text,
//               'departments': departmentCountController.text,
//             };

//             widget.onSave(collageData);
//             Navigator.pop(context);
//           },
//           child: Text(
//             widget.dialogType == 'delete'
//                 ? 'حذف'
//                 : widget.dialogType == 'edit'
//                     ? 'حفظ'
//                     : 'إضافة',
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildField(String label, TextEditingController controller, {TextInputType inputType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         controller: controller,
//         keyboardType: inputType,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.orange, width: 1),
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue, width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Collagemanager extends StatefulWidget {
  final Map<String, dynamic>? collage;
  final String universityId;
  final Function() onSuccess;
  final String dialogType; // "add", "edit", "delete"

  const Collagemanager({
    super.key,
    required this.universityId,
    this.collage,
    required this.onSuccess,
    required this.dialogType,
  });

  @override
  State<Collagemanager> createState() => _CollagemanagerState();
}

class _CollagemanagerState extends State<Collagemanager> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deanController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if (widget.dialogType == 'edit' && widget.collage != null) {
      nameController.text = widget.collage!['name'] ?? '';
      deanController.text = widget.collage!['dean'] ?? '';
      passwordController.text = widget.collage!['password'] ?? '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    deanController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveCollege() async {
    final name = nameController.text.trim();
    final deanEmail = deanController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || deanEmail.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة جميع الحقول')),
      );
      return;
    }

    final universityRef =
        firestore.collection('universities').doc(widget.universityId);
    final collegesRef = universityRef.collection('colleges');

    try {
      if (widget.dialogType == 'add') {
        // 1. إنشاء مستخدم جديد
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: deanEmail, password: password);

        final uid = userCredential.user!.uid;

        // 2. إضافة الكلية وربطها بالمستخدم
        final doc = await collegesRef.add({
          'name': name,
          'dean': deanEmail,
          'password': password,
          'universityId': widget.universityId,
          'createdAt': FieldValue.serverTimestamp(),
        });

        await doc.update({'id': doc.id});

        // 3. حفظ بيانات المستخدم في Firestore
        await firestore.collection('users').doc(uid).set({
          'email': deanEmail,
          'role': 'facultyAdmin',
          'collegeId': doc.id,
          'universityId': widget.universityId,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else if (widget.dialogType == 'edit' && widget.collage != null) {
        final collegeId = widget.collage!['id'];
        await collegesRef.doc(collegeId).update({
          'name': name,
          'dean': deanEmail,
          'password': password,
        });

        final userDocs = await firestore
            .collection('users')
            .where('collegeId', isEqualTo: collegeId)
            .get();

        for (var doc in userDocs.docs) {
          await doc.reference.update({'password': password});
        }
      }

      widget.onSuccess();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message = 'حدث خطأ أثناء إنشاء الحساب';
      if (e.code == 'email-already-in-use') {
        message = 'البريد الإلكتروني مستخدم بالفعل';
      } else if (e.code == 'invalid-email') {
        message = 'بريد إلكتروني غير صالح';
      } else if (e.code == 'weak-password') {
        message = 'كلمة المرور ضعيفة';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _deleteCollege() async {
    final collegeId = widget.collage?['id'];
    if (collegeId == null) return;

    final collegeRef = firestore
        .collection('universities')
        .doc(widget.universityId)
        .collection('colleges')
        .doc(collegeId);

    await collegeRef.delete();

    // حذف المستخدم المرتبط
    final userDocs = await firestore
        .collection('users')
        .where('collegeId', isEqualTo: collegeId)
        .get();

    for (var doc in userDocs.docs) {
      await doc.reference.delete();
    }

    widget.onSuccess();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dialogType == 'add'
          ? 'إضافة كلية جديدة'
          : widget.dialogType == 'edit'
              ? 'تعديل بيانات الكلية'
              : 'تأكيد الحذف'),
      content: widget.dialogType == 'delete'
          ? Text(
              'هل أنت متأكد من حذف الكلية "${widget.collage?['name'] ?? ''}"؟')
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildField('اسم الكلية', nameController),
                  _buildField('بريد العميد', deanController),
                  _buildField('كلمة المرور', passwordController),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.dialogType == 'delete') {
              _deleteCollege();
            } else {
              _saveCollege();
            }
          },
          child: Text(widget.dialogType == 'delete'
              ? 'حذف'
              : widget.dialogType == 'edit'
                  ? 'حفظ'
                  : 'إضافة'),
        ),
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
