import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/modelgraduates.dart';
import 'package:flutter_application_1/widget/my_button.dart'; // تأكد من إضافة MyButton.

class Addbutton {
  static void ShowCustomDilalog({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required TextEditingController admin,
    required TextEditingController password,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        titlePadding: const EdgeInsets.symmetric(horizontal: 30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text Field for "Name collage"
            _buildTextField(controller, 'Name collage'),
            SizedBox(height: 5),
            // Text Field for "Admin Name"
            _buildTextField(admin, 'Admin Name'),
            SizedBox(height: 5),
            // Text Field for "Admin Password"
            _buildTextField(password, 'Admin Password', obscureText: true),
          ],
        ),
        actions: [
          Row(
            children: [
              // Save Button
              MyButton(
                color: Colors.blue,
                titel: 'Save',
                onpressed: () {
                  print(controller.text);
                  print(admin.text);
                  print(password.text);
                },
              ),
              Spacer(),
              // Cancel Button
              MyButton(
                color: Colors.red,
                titel: 'Cancel',
                onpressed: () {
                  // Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  // Create a reusable TextField widget
  static Widget _buildTextField(
      TextEditingController controller, String labelText,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}

// class Add extends StatefulWidget {
//   const Add({super.key});

//   @override
//   State<Add> createState() => _AddState();
// }

// class _AddState extends State<Add> {
//   void _addGraduate() {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController deptController = TextEditingController();
//   final TextEditingController gpaController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('إضافة خريج جديد'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             TextField(controller: nameController, decoration: const InputDecoration(labelText: 'الاسم')),
//             TextField(controller: idController, decoration: const InputDecoration(labelText: 'الرقم الجامعي')),
//             TextField(controller: deptController, decoration: const InputDecoration(labelText: 'القسم')),
//             TextField(controller: gpaController, decoration: const InputDecoration(labelText: 'المعدل')),
//             TextField(controller: yearController, decoration: const InputDecoration(labelText: 'سنة التخرج')),
//             TextField(controller: emailController, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               graduates.add({
//                 'name': nameController.text,
//                 'id': idController.text,
//                 'department': deptController.text,
//                 'gpa': gpaController.text,
//                 'graduationYear': yearController.text,
//                 'email': emailController.text,
//               });
//             });
//             Navigator.pop(context);
//           },
//           child: const Text('إضافة'),
//         ),
//       ],
//     ),
//   );
// }

// }

// import 'package:flutter/material.dart';

// class AddGraduateDialog extends StatefulWidget {
//   final Function(Map<String, String>) onAdd;

//   const AddGraduateDialog({super.key, required this.onAdd});

//   @override
//   State<AddGraduateDialog> createState() => _AddGraduateDialogState();
// }

// class _AddGraduateDialogState extends State<AddGraduateDialog> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController departmentController = TextEditingController();
//   final TextEditingController gpaController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   @override
//   void dispose() {
//     nameController.dispose();
//     idController.dispose();
//     departmentController.dispose();
//     gpaController.dispose();
//     yearController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       icon: Icon(Icons.school),
//       iconColor: Colors.black,
//       // titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       title: const Text('إضافة خريج '),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildField('الاسم', nameController),
//             _buildField('الرقم الجامعي', idController),
//             _buildField('القسم', departmentController),
//             _buildField('المعدل', gpaController),
//             _buildField('سنة التخرج', yearController),
//             _buildField('البريد الإلكتروني', emailController),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             widget.onAdd({
//               'name': nameController.text,
//               'id': idController.text,
//               'department': departmentController.text,
//               'gpa': gpaController.text,
//               'graduationYear': yearController.text,
//               'email': emailController.text,
//             });
//             Navigator.pop(context);
//           },
//           child: const Text('إضافة'),
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

// // import 'package:flutter/material.dart';

// class GraduateDialogManager extends StatelessWidget {
//   final Map<String, String>? graduate;
//   final Function(Map<String, String>) onSave;
//   final Function onDelete;
//   final String dialogType; // "add", "edit", "delete"

//   GraduateDialogManager({
//     super.key,
//     this.graduate,
//     required this.onSave,
//     required this.onDelete,
//     required this.dialogType,
//   });

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController departmentController = TextEditingController();
//   final TextEditingController gpaController = TextEditingController();
//   final TextEditingController graduationYearController =
//       TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // If it's editing, populate the fields with existing graduate data
//     if (dialogType == 'edit' && graduate != null) {
//       nameController.text = graduate!['name'] ?? '';
//       idController.text = graduate!['id'] ?? '';
//       departmentController.text = graduate!['department'] ?? '';
//       gpaController.text = graduate!['gpa'] ?? '';
//       graduationYearController.text = graduate!['graduationYear'] ?? '';
//       emailController.text = graduate!['email'] ?? '';
//     }

//     return AlertDialog(
//       title: Text(dialogType == 'add'
//           ? 'إضافة خريج'
//           : dialogType == 'edit'
//               ? 'تعديل الخريج'
//               : 'تأكيد الحذف'),
//       content: dialogType == 'delete'
//           ? Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('هل أنت متأكد من حذف الخريج ${graduate?['name'] ?? ''}?'),
//               ],
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildField('الاسم', nameController),
//                   _buildField('الرقم الجامعي', idController),
//                   _buildField('القسم', departmentController),
//                   _buildField('المعدل', gpaController),
//                   _buildField('سنة التخرج', graduationYearController),
//                   _buildField('البريد الإلكتروني', emailController),
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
//               final updatedGraduate = {
//                 'name': nameController.text,
//                 'id': idController.text,
//                 'department': departmentController.text,
//                 'gpa': gpaController.text,
//                 'graduationYear': graduationYearController.text,
//                 'email': emailController.text,
//               };
//               onSave(updatedGraduate);
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
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }





// class AddGraduateDialog extends StatefulWidget {
//   final String departmentId;
//   final Function(Graduate) onAdd;

//   const AddGraduateDialog({
//     Key? key,
//     required this.departmentId,
//     required this.onAdd,
//   }) : super(key: key);

//   @override
//   State<AddGraduateDialog> createState() => _AddGraduateDialogState();
// }

// class _AddGraduateDialogState extends State<AddGraduateDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final idController = TextEditingController();
//   final gpaController = TextEditingController();
//   final yearController = TextEditingController();
//   final emailController = TextEditingController();

//   bool _loading = false;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('إضافة خريج جديد'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'الاسم'),
//                 validator: (value) => value!.isEmpty ? 'أدخل الاسم' : null,
//               ),
//               TextFormField(
//                 controller: idController,
//                 decoration: const InputDecoration(labelText: 'الرقم الجامعي'),
//                 validator: (value) => value!.isEmpty ? 'أدخل الرقم' : null,
//               ),
//               TextFormField(
//                 controller: gpaController,
//                 decoration: const InputDecoration(labelText: 'المعدل'),
//                 validator: (value) => value!.isEmpty ? 'أدخل المعدل' : null,
//               ),
//               TextFormField(
//                 controller: yearController,
//                 decoration: const InputDecoration(labelText: 'سنة التخرج'),
//                 validator: (value) => value!.isEmpty ? 'أدخل السنة' : null,
//               ),
//               TextFormField(
//                 controller: emailController,
//                 decoration:
//                     const InputDecoration(labelText: 'البريد الإلكتروني'),
//                 validator: (value) => value!.isEmpty ? 'أدخل البريد' : null,
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: _loading ? null : _saveGraduate,
//           child: _loading
//               ? const CircularProgressIndicator()
//               : const Text('إضافة'),
//         ),
//       ],
//     );
//   }

//   Future<void> _saveGraduate() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _loading = true);

//       final newGraduate = Graduate(
//         id: idController.text,
//         name: nameController.text,
//         gpa: gpaController.text,
//         graduationYear: yearController.text,
//         email: emailController.text,
//         departmentId: widget.departmentId,
//       );

//       try {
//         await FirebaseFirestore.instance
//             .collection('graduates')
//             .add(newGraduate.toMap());

//         widget.onAdd(newGraduate); // تحديث الواجهة
//         Navigator.pop(context);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('حدث خطأ: $e')),
//         );
//       } finally {
//         setState(() => _loading = false);
//       }
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_1/model/modelgraduates.dart';

class AddGraduateDialog extends StatefulWidget {
  final String departmentId;
  final Function(Graduate) onAdd;

  const AddGraduateDialog({
    super.key,
    required this.departmentId,
    required this.onAdd,
  });

  @override
  State<AddGraduateDialog> createState() => _AddGraduateDialogState();
}

class _AddGraduateDialogState extends State<AddGraduateDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isSaving = false;

  Future<void> saveGraduate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    try {
      final docRef = FirebaseFirestore.instance.collection('graduates').doc();

      final newGraduate = Graduate(
  id: docRef.id,
  name: nameController.text.trim(),
  gpa: gpaController.text.trim(),
  graduationYear: yearController.text.trim(),
  email: emailController.text.trim(),
  departmentId: widget.departmentId,
  createdAt: DateTime.now(), // <-- تاريخ الإضافة
);
      await docRef.set(newGraduate.toMap());
      widget.onAdd(newGraduate);
      Navigator.of(context).pop(); // إغلاق النافذة بعد الإضافة
    } catch (e) {
      print("خطأ أثناء إضافة الخريج: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حدث خطأ أثناء الإضافة")),
      );
    }

    setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("إضافة خريج جديد"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (value) => value!.isEmpty ? 'أدخل الاسم' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (value) => value!.isEmpty ? 'أدخل البريد الإلكتروني' : null,
              ),
              TextFormField(
                controller: gpaController,
                decoration: const InputDecoration(labelText: 'المعدل'),
                validator: (value) => value!.isEmpty ? 'أدخل المعدل' : null,
              ),
              TextFormField(
                controller: yearController,
                decoration: const InputDecoration(labelText: 'سنة التخرج'),
                validator: (value) => value!.isEmpty ? 'أدخل سنة التخرج' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: isSaving ? null : saveGraduate,
          child: isSaving
              ? const SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('حفظ'),
        ),
      ],
    );
  }
}

class GraduateDialogManager extends StatelessWidget {
  final String dialogType;
  final Graduate graduate;
  final Function(Graduate) onSave;
  final VoidCallback onDelete;

  const GraduateDialogManager({
    required this.dialogType,
    required this.graduate,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: graduate.name);
    final TextEditingController idController =
        TextEditingController(text: graduate.id);
    final TextEditingController deptController =
        TextEditingController(text: graduate.departmentId);
    final TextEditingController gpaController =
        TextEditingController(text: graduate.gpa);
    final TextEditingController yearController =
        TextEditingController(text: graduate.graduationYear);
    final TextEditingController emailController =
        TextEditingController(text: graduate.email);

    return AlertDialog(
      title: Text(dialogType == 'edit' ? 'تعديل بيانات الخريج' : 'تأكيد الحذف'),
      content: dialogType == 'edit'
          ? Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'الاسم'),
                ),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'الرقم الجامعي'),
                ),
                TextField(
                  controller: deptController,
                  decoration: const InputDecoration(labelText: 'القسم'),
                ),
                TextField(
                  controller: gpaController,
                  decoration: const InputDecoration(labelText: 'المعدل'),
                ),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'سنة التخرج'),
                ),
                TextField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(labelText: 'البريد الإلكتروني'),
                ),
              ],
            )
          : const Text('هل أنت متأكد أنك تريد حذف هذا الخريج؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (dialogType == 'edit') {
              onSave(Graduate(
                id: graduate.id,
                name: nameController.text,
                gpa: gpaController.text,
                graduationYear: yearController.text,
                email: emailController.text,
                departmentId: deptController.text, 
                createdAt: DateTime.now(),
              ));
            } else {
              onDelete();
            }
            Navigator.pop(context);
          },
          child: Text(dialogType == 'edit' ? 'حفظ' : 'حذف'),
        ),
      ],
    );
  }
}
