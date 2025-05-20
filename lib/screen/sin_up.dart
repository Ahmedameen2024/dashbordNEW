import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/widget/my_button.dart';

class SinUp extends StatefulWidget {
  static const String sinUpScreenRout = 'SinUp';
  final String? role; // يمكن تمرير الدور عند التنقل إلى الشاشة
  final String? facultyId; // للعميد
  final String? departmentId; // لرئيس القسم

  const SinUp({
    super.key,
    this.role,
    this.facultyId,
    this.departmentId,
  });

  @override
  State<SinUp> createState() => _SinUpState();
}

class _SinUpState extends State<SinUp> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String userName;
  late String email;
  late String password;
  late String confirmPassword;

  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 1. إنشاء مستخدم في Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // 2. تحديد البيانات الإضافية بناءً على الدور
      Map<String, dynamic> userData = {
        'username': userName.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      // إذا تم تمرير دور من الشاشة السابقة
      if (widget.role != null) {
        userData['role'] = widget.role;

        if (widget.role == 'faculty_dean' && widget.facultyId != null) {
          userData['facultyId'] = widget.facultyId;
          // تحديث وثيقة الكلية بإضافة العميد
          await _firestore
              .collection('faculties')
              .doc(widget.facultyId)
              .update({
            'deanId': userCredential.user?.uid,
            'deanName': userName.trim(),
          });
        }

        if (widget.role == 'department_head' && widget.departmentId != null) {
          userData['departmentId'] = widget.departmentId;
          // تحديث وثيقة القسم بإضافة رئيس القسم
          await _firestore
              .collection('departments')
              .doc(widget.departmentId)
              .update({
            'headId': userCredential.user?.uid,
            'headName': userName.trim(),
          });
        }
      } else {
        // إذا لم يتم تحديد دور، يتم تعيينه كمستخدم عادي
        userData['role'] = 'user';
      }

      // 3. حفظ بيانات المستخدم في Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set(userData);

      // 4. عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التسجيل بنجاح!')),
      );

      // يمكنك إضافة الانتقال إلى الشاشة المناسبة حسب الدور
      // Navigator.pushNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ أثناء التسجيل';
      if (e.code == 'weak-password') {
        errorMessage = 'كلمة المرور ضعيفة جداً';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'هذا البريد الإلكتروني مسجل بالفعل';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ غير متوقع: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: Image.asset('images/كلية الطب .png'),
                ),
                const SizedBox(height: 30),

                // حقل اسم المستخدم
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (val) => userName = val,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'يجب إدخال اسم المستخدم' : null,
                  decoration: _buildInputDecoration('اسم المستخدم'),
                ),
                const SizedBox(height: 10),

                // حقل البريد الإلكتروني
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (val) => email = val,
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'يجب إدخال البريد الإلكتروني';
                    if (!value!.contains('@')) return 'بريد إلكتروني غير صالح';
                    return null;
                  },
                  decoration: _buildInputDecoration('البريد الإلكتروني'),
                ),
                const SizedBox(height: 10),

                // حقل كلمة المرور
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (val) => password = val,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'يجب إدخال كلمة المرور' : null,
                  decoration: _buildInputDecoration('كلمة المرور'),
                ),
                const SizedBox(height: 10),

                // حقل تأكيد كلمة المرور
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (val) => confirmPassword = val,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'يجب تأكيد كلمة المرور';
                    if (value != password) return 'كلمة المرور غير متطابقة';
                    return null;
                  },
                  decoration: _buildInputDecoration('تأكيد كلمة المرور'),
                ),
                const SizedBox(height: 30),

                // زر التسجيل
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : MyButton(
                        color: Colors.blue[800]!,
                        titel: 'تسجيل',
                        onpressed: _registerUser,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لبناء تصميم حقول الإدخال
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
