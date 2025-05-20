import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/dashbord/research.dart';
import 'package:flutter_application_1/dashbord/table_griduintData.dart';
import 'package:flutter_application_1/model/modelgraduates.dart';
import 'package:flutter_application_1/model/modelresearch.dart';

class DepartmentheadPage extends StatefulWidget {
  final String departmentId; // معرف الكلية
  const DepartmentheadPage({
    required this.departmentId,
  });

  @override
  State<DepartmentheadPage> createState() => _DepartmentheadPageState();
}

class _DepartmentheadPageState extends State<DepartmentheadPage> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String departmentName = '';
  int gradauteCount = 0;
  int researchCount = 0;
  String headName = '';
  String headUid = '';
  bool isLoading = true;
  Future<int> getGraduatehCount(String departmentId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('graduates')
        .where('departmentId', isEqualTo: departmentId)
        .get();

    return snapshot.docs.length;
  }

  Future<int> getResearchCount(String departmentId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('researches')
        .where('departmentId', isEqualTo: departmentId)
        .get();

    return snapshot.docs.length;
  }

  @override
  void initState() {
    super.initState();
    loadDepartmentInfo();
    getGraduatehCount(widget.departmentId);
    getResearchCount(widget.departmentId);
  }

  Future<void> loadDepartmentInfo() async {
    final doc = await FirebaseFirestore.instance
        .collection('departments')
        .doc(widget.departmentId)
        .get();
    gradauteCount = await getGraduatehCount(widget.departmentId);
    researchCount = await getResearchCount(widget.departmentId);
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        departmentName = data['departmentName'] ?? '';
        _descController.text = data['description'] ?? '';
        headName = data['headName'] ?? '';

        _emailController.text = data['ُemail'] ?? '';
        headUid = data['headUid'] ?? '';
        isLoading = false;
        loadDepartmentInfo();
      });
    }
  }

  Future<void> updatedepartmentInfo() async {
    // تحديث بيانات القسم
    await FirebaseFirestore.instance
        .collection('departments')
        .doc(widget.departmentId)
        .update({
      'description': _descController.text,
      'email': _emailController.text,
    });

    // تحديث بيانات حساب Firebase Auth إذا كان المستخدم الحالي هو العميد
    if (_passwordController.text.isNotEmpty &&
        FirebaseAuth.instance.currentUser?.uid == headUid) {
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
      appBar: AppBar(
        title: const Text('ادارة القسم', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[200],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('اسم القسم: $departmentName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('عدد الخريجين: $gradauteCount',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('عدد الابحاث: ${researchCount}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('اسم رئيس: $headName', style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'وصف القسم', border: OutlineInputBorder()),
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
              onPressed: updatedepartmentInfo,
              child: Text('تحديث المعلومات'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResearchControlPage(
                        departmentId: widget.departmentId)));
              },
              icon: Icon(Icons.account_tree),
              label: Text('إدارة الأبحاث'),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GraduateControlPage(
                          departmentId: widget.departmentId,
                        )));
              },
              icon: Icon(Icons.work),
              label: Text('إدارة الخريجين'),
            ),
          ],
        ),
      ),
    );
  }
}
