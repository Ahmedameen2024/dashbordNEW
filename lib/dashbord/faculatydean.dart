import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/dashbord/jopmanagment.dart';
// import 'package:flutter_application_1/dashbord/table_collegeData.dart';
import 'package:flutter_application_1/dashbord/table_departmentData.dart';

class FacultyDeanPage extends StatefulWidget {
  final String collegeId; // معرف الكلية
  const FacultyDeanPage({required this.collegeId});

  @override
  State<FacultyDeanPage> createState() => _FacultyDeanPageState();
}

class _FacultyDeanPageState extends State<FacultyDeanPage> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String facultyName = '';
  int departmentCount = 0;
  int jobCount = 0;
  String deanName = '';
  String deanUid = '';
  bool isLoading = true;
  Future<int> getNumberOfDepartments(String collageId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('departments')
        .where('collegeId', isEqualTo: collageId)
        .get();

    return snapshot.docs.length;
  }

  Future<int> getNumberOfJobs(String collegeId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('jobs')
        .where('collegeId', isEqualTo: collegeId)
        .get();

    return snapshot.docs.length;
  }

  @override
  void initState() {
    super.initState();
    loadFacultyInfo();
  }

  Future<void> loadFacultyInfo() async {
    final doc = await FirebaseFirestore.instance
        .collection('colleges')
        .doc(widget.collegeId)
        .get();
    departmentCount = await getNumberOfDepartments(widget.collegeId);
    jobCount = await getNumberOfJobs(widget.collegeId);
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        facultyName = data['collegeName'] ?? '';
        _descController.text = data['description'] ?? '';
        // departmentCount = data['departmentCount'] ?? 0;
        // jobCount = data['jobCount'] ?? 0;
        deanName = data['deanName'] ?? '';
        _emailController.text = data['ُemail'] ?? '';
        deanUid = data['deanUid'] ?? '';
        isLoading = false;
      });
    }
  }

  Future<void> updateFacultyInfo() async {
    // تحديث بيانات الكلية
    await FirebaseFirestore.instance
        .collection('colleges')
        .doc(widget.collegeId)
        .update({
      'description': _descController.text,
      'email': _emailController.text,
    });

    // تحديث بيانات حساب Firebase Auth إذا كان المستخدم الحالي هو العميد
    if (_passwordController.text.isNotEmpty &&
        FirebaseAuth.instance.currentUser?.uid == deanUid) {
      try {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(_passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل تغيير كلمة المرور: $e')),
        );
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('تم التحديث بنجاح')));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    return Scaffold(

      appBar: AppBar(title: Text('صفحة ادارة الكلية'),
      backgroundColor: Colors.blue[200],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('اسم الكلية: $facultyName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('عدد الأقسام: $departmentCount',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('عدد الوظايف: $jobCount', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('اسم العميد: $deanName', style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'وصف الكلية', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'كلمة المرور الجديدة (اختياري)',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateFacultyInfo,
              child: Text('تحديث المعلومات'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DepartmentTablePage(collegeId: widget.collegeId)));
              },
              icon: Icon(Icons.account_tree),
              label: Text('إدارة الأقسام'),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddJobPage(
                          collegeId: widget.collegeId,
                        )));
              },
              icon: Icon(Icons.work),
              label: Text('إدارة الوظائف'),
            ),
          ],
        ),
      ),
    );
  }
}
