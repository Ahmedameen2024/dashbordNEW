// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_application_1/controll/listgradustes.dart';
// // import 'package:flutter_application_1/model/modeldepartments.dart';
// import 'package:flutter_application_1/model/modelgraduates.dart';
// import 'package:flutter_application_1/model/modelresearch.dart';
// // import 'package:flutter_application_1/screen/graduatespage.dart';

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// class Faculty {
//   final String name;
//   final String imagePath;
//   final List<Department> departments;

//   Faculty(
//       {required this.name, required this.imagePath, required this.departments});
// }

// class Department {
//   final String name;
//   final String? description;
//   final List<Research>? researches;
//   final List<Graduate>? graduates;

//   Department({
//     required this.name,
//     this.description,
//     this.researches,
//     this.graduates,
//     // this.graduates,
//     // List<Graduates>? graduates,
//   });
// }

// Future<List<Graduate>> getGraduatesByDepartment(String departmentId) async {
//   final snapshot = await FirebaseFirestore.instance
//       .collection('graduates')
//       .where('departmentId', isEqualTo: departmentId)
//       .get();

//   return snapshot.docs.map((doc) => Graduate.fromMap(doc.data())).toList();
// }

// final List<Faculty> faculties = [
//   Faculty(
//     name: 'كلية الهندسة',
//     imagePath: 'images/كلية التربية .png',
//     departments: [
//       Department(
//           name: ' هندسة الأتصالات والحاسوب',
//           description: '',
//           researches: [],
//           graduates: [
//             // Graduate(name: 'name', research: 'research', year: 'year')
//           ]),
//       Department(
//         name: ' هندسة تكنلوجيا المعلومات ',
//         description: 'يركز على الطاقة والإلكترونيات.',
//         researches: [],
//       ),
//       Department(
//         name: 'هندسة البرمجيات',
//         description: '',
//         researches: [],
//       ),
//       Department(
//         name: 'هندسة شبكات الحاسوب ',
//         description: '',
//         researches: [],
//       ),
//       Department(
//         name: 'هندسة الميكاترونيات والروبوتات ',
//         description: '',
//         researches: [],
//       ),
//     ],
//   ),
//   Faculty(
//     name: ' كلية الطب والعلوم الصحية',
//     imagePath: 'images/كلية الطب .png',
//     departments: [
//       Department(
//         name: 'الطب العام والجراحة ',
//         description: 'تعليم أساسيات الجراحة.',
//         researches: [],
//       ),
//       Department(
//         name: 'طب الفم والأسنان',
//         description: '.',
//         researches: [],
//       ),
//       Department(
//         name: 'الصيدلة',
//         researches: [],
//       ),
//       Department(
//         name: 'المختبرات الطبية',
//         researches: [],
//       ),
//     ],
//   ),
//   Faculty(
//     name: '   كلية العلوم الإدارية',
//     imagePath: 'images/العلوم الإدارية.png',
//     departments: [
//       Department(
//         name: 'قسم الإقتصاد',
//         researches: [],
//       ),
//       Department(
//         name: 'قسم المحاسبة والمراجعة',
//         researches: [],
//       ),
//       Department(
//         name: 'قسم العلوم المالية والمصرفية',
//         researches: [],
//       ),
//       Department(
//         name: 'قسم التسويق',
//         researches: [],
//       ),
//     ],
//   ),
//   Faculty(
//     name: 'كلية العلوم التطبيقية',
//     imagePath: 'images/كلية الحقوق .png',
//     departments: [
//       Department(
//         name: 'علوم الحاسوب',
//         description:
//             'قسم يهتم ببرمجة الحاسوب، والذكاء الاصطناعي، وهندسة البرمجيات.',
//         researches: [
//           Research(
//             title: 'أمن المعلومات',
//             summary:
//                 ' بحث حول تقنيات التشفير والحماية من الاختراق. وطورق الحماية من الاختراق واستخدام النت ',
//             downloadUrl: 'https://example.com/security.pdf',
//             year: '2020',
//           ),
//           Research(
//             title: 'تطبيقات الذكاء الاصطناعي',
//             summary: 'دراسة استخدام AI في تشخيص الأمراض.',
//             downloadUrl: 'https://example.com/ai-medicine.pdf',
//             year: '2020',
//           ),
//         ],
//         // graduates: [
//         //   Graduate(name: 'Bilal', research: 'university', year: '2025'),
//         //   Graduate(name: 'Mosab', research: 'university', year: '2023'),
//         //   Graduate(name: 'Ahmed', research: 'university', year: '2024'),
//         // ],
//       ),
//       Department(
//         name: 'أمن سبراني  ',
//         description: '',
//         researches: [
//           Research(
//             title: 'تحليل نظم المستشفيات',
//             summary: 'بحث في تصميم نظام رقمي للمستشفيات.',
//             downloadUrl: 'https://example.com/hospital-system.pdf',
//             year: '2022',
//           ),
//         ],
//       ),
//       Department(name: 'الذكاء الاصطناعي', description: '', researches: []),
//       Department(name: 'ميكرو بيلوجي ', description: '', researches: []),
//       Department(name: 'الكيمياء الصناعية ', description: '', researches: []),
//       Department(name: 'الفيزياء الطبية ', description: '', researches: []),
//       Department(name: 'النفط والتعدين ', description: '', researches: []),
//     ],
//   ),
//   Faculty(
//     name: '   كلية الحقوق ',
//     imagePath: 'images/العلوم الإدارية.png',
//     departments: [
//       Department(
//         name: 'قانون عام ',
//         description: '',
//         researches: [],
//       ),
//       Department(
//         name: ' القانون الجنائي ',
//         description: '',
//         researches: [],
//       ),
//       Department(
//         name: 'القانون الدولي',
//         description: '',
//         researches: [],
//       ),
//       Department(
//         name: 'الشريعة الإسلامية ',
//         description: '',
//         researches: [],
//       ),
//     ],
//   ),
// ];
