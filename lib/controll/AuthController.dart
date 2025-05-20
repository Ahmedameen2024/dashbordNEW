import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/dashbord/departmenthead.dart';
import 'package:flutter_application_1/dashbord/faculatydean.dart';
import 'package:flutter_application_1/dashbord/table_collageData.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;
  RxString userRole = 'guest'.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) async {
    if (user != null) {
      await _fetchUserData(user.uid);
    } else {
      userData.value = {};
      userRole.value = 'guest';
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        userData.value = doc.data()!;
        userRole.value = doc['role'] ?? 'user';
        print('Role: ${userRole.value}');
      }
    } catch (e) {
      Get.snackbar("خطأ", "فشل في جلب بيانات المستخدم");
    }
  }

  Future<void> login(String usernameOrEmail, String password) async {
    isLoading.value = true;
    try {
      if (usernameOrEmail.isEmpty || password.isEmpty) {
        Get.snackbar("خطأ", "يرجى إدخال البريد أو اسم المستخدم وكلمة المرور");
        return;
      }

      String email;
      if (usernameOrEmail.contains('@')) {
        email = usernameOrEmail.trim();
      } else {
        email = await _findEmailByUsername(usernameOrEmail.trim());
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password.trim(),
      );

      await _fetchUserData(_auth.currentUser!.uid);

      switch (userRole.value) {
        case 'universityAdmin':
          Get.offAll(
              () => CollegeTablePage(universityId: userData['universityId']));
          break;

        case 'facultyDean':
          Get.offAll(() => FacultyDeanPage(collegeId: userData['collegeId']));
          break;

        case 'departmentHead':
          Get.offAll(
              () => DepartmentheadPage(departmentId: userData['departmentId']));
          break;

        default:
          Get.offAll(() => const Home());
      }

      Get.snackbar("تم", "تم تسجيل الدخول بنجاح");
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      Get.snackbar("خطأ", "فشل تسجيل الدخول: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String role,
    String? universityId,
    String? collegeId,
    String? departmentId,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      String uid = userCredential.user!.uid;

      Map<String, dynamic> userMap = {
        'username': username.trim(),
        'email': email.trim(),
        'role': role,
      };

      if (role == 'universityAdmin' && universityId != null) {
        userMap['universityId'] = universityId;
      } else if (role == 'facultyDean' && collegeId != null) {
        userMap['collegeId'] = collegeId;
      } else if (role == 'departmentHead' && departmentId != null) {
        userMap['departmentId'] = departmentId;
      }

      await _firestore.collection('users').doc(uid).set(userMap);

      userData.value = userMap;
      userRole.value = role;

      Get.snackbar("تم", "تم إنشاء المستخدم بنجاح");
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      Get.snackbar("خطأ", "فشل إنشاء المستخدم: ${e.toString()}");
    }
  }

  Future<String> _findEmailByUsername(String username) async {
    final query = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('اسم المستخدم غير موجود');
    }

    return query.docs.first['email'];
  }

  Future<bool> _checkUniversityHasColleges(String universityId) async {
    final query = await _firestore
        .collection('colleges')
        .where('universityId', isEqualTo: universityId)
        .get();
    return query.docs.isNotEmpty;
  }

  Future<bool> _checkFacultyHasDepartments(String collegeId) async {
    final query = await _firestore
        .collection('departments')
        .where('collegeId', isEqualTo: collegeId)
        .get();
    return query.docs.isNotEmpty;
  }

  Future<bool> _checkDepartmentHasResearchAndGraduates(
      String departmentId) async {
    final research = await _firestore
        .collection('research')
        .where('departmentId', isEqualTo: departmentId)
        .get();
    final graduates = await _firestore
        .collection('graduates')
        .where('departmentId', isEqualTo: departmentId)
        .get();
    return research.docs.isNotEmpty || graduates.docs.isNotEmpty;
  }

  Future<void> logout() async {
    await _auth.signOut();
    userData.value = {};
    userRole.value = 'guest';
    Get.offAllNamed('/');
    Get.snackbar("تم", "تم تسجيل الخروج");
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message = "خطأ أثناء تسجيل الدخول";
    switch (e.code) {
      case 'user-not-found':
        message = "المستخدم غير موجود";
        break;
      case 'wrong-password':
        message = "كلمة المرور غير صحيحة";
        break;
      case 'invalid-email':
        message = "البريد الإلكتروني غير صالح";
        break;
      case 'email-already-in-use':
        message = "البريد مستخدم مسبقًا";
        break;
      case 'weak-password':
        message = "كلمة المرور ضعيفة";
        break;
      case 'too-many-requests':
        message = "تم حظر الحساب مؤقتًا، حاول لاحقًا";
        break;
    }
    Get.snackbar("خطأ", message);
  }

  // Getters
  bool get isGuest => userRole.value == 'guest';
  bool get isRegularUser => userRole.value == 'user';
  bool get isUniversityAdmin => userRole.value == 'universityAdmin';
  bool get isFacultyDean => userRole.value == 'facultyDean';
  bool get isDepartmentHead => userRole.value == 'departmentHead';
}
