// import 'package:flutter_application_1/model/modelgraduates.dart';
// import 'package:flutter_application_1/model/modelresearch.dart';

// class Department {
//   final String name;
//   final String? description;
//   final List<Research> researches;

//   Department({
//     required this.name,
//     this.description,
//     List<Graduate>? graduates,
//     List<Research>? researches,
//   }) : researches = researches ?? [];
// }

// // قائمة الأقسام + الأبحاث
// List<Department> departments = [
//   Department(
//     name: 'علوم الحاسوب',
//     description:
//         'قسم يهتم ببرمجة الحاسوب، والذكاء الاصطناعي، وهندسة البرمجيات.',
//     researches: [
//       Research(
//         title: 'أمن المعلومات',
//         summary: 'بحث حول تقنيات التشفير والحماية من الاختراق.',
//         downloadUrl: 'https://example.com/security.pdf',
//         year: '2020',
//       ),
//       Research(
//         title: 'تطبيقات الذكاء الاصطناعي',
//         summary: 'دراسة استخدام AI في تشخيص الأمراض.',
//         downloadUrl: 'https://example.com/ai-medicine.pdf',
//         year: '2020',
//       ),
//     ],
//     // graduates: [
//     //   Graduates(name: 'Ahmed', research: 'university', year: '2024'),
//     // ],
//   ),
//   Department(
//     name: 'نظم المعلومات',
//     description: 'يجمع بين تقنيات الحاسوب وتحليل الأعمال.',
//     researches: [
//       Research(
//         title: 'تحليل نظم المستشفيات',
//         summary: 'بحث في تصميم نظام رقمي للمستشفيات.',
//         downloadUrl: 'https://example.com/hospital-system.pdf',
//         year: '2022',
//       ),
//     ],
//   ),
//   Department(
//     name: 'الهندسة المدنية',
//     description: 'يعنى بتصميم المنشآت والجسور والبنية التحتية.',
//     researches: [
//       Research(
//         title: 'تحليل وتصميم الجسور',
//         summary: 'طرق التصميم الحديثة للجسور باستخدام الخرسانة سابقة الإجهاد.',
//         downloadUrl: 'https://example.com/bridges.pdf',
//         year: '2022',
//       ),
//     ],
//   ),
// ];

// class Department {
//   final String name;
//   final String? description;
//   final List<String>? graduates;
//   final List<String>? researches;
//   final String? id;

//   Department({
//     required this.name,
//     this.description,
//     this.graduates,
//     this.researches,
//     this.id,
//   });

//   factory Department.fromMap(Map<String, dynamic> map) {
//     return Department(

//       name: map['departmentName'],
//       description: map['description'],
//       graduates: List<String>.from(map['graduates'] ?? []),
//       researches: List<String>.from(map['researches'] ?? []),
//       // id: map[''],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'description': description,
//       'graduates': graduates,
//       'researches': researches,
//       'id': id,
//     };
//   }
// }

class Department {
  final String? id;
  final String name;
  final String? description;
  final List<String>? graduates;
  final List<String>? researches;
  final String? collegeId;

  Department({
    required this.id,
    required this.name,
    this.collegeId,
    this.description,
    this.graduates,
    this.researches,
  });

  factory Department.fromMap(Map<String, dynamic> map, String docId) {
    return Department(
      id: docId,
      name: map['departmentName'] ?? map['name'] ?? '',
      description: map['description'],
      graduates: List<String>.from(map['graduates'] ?? []),
      researches: List<String>.from(map['researches'] ?? []),
      collegeId: map['collegeId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'departmentName': name,
      'description': description,
      'graduates': graduates,
      'researches': researches,
      'collegeId': collegeId,
    };
  }
}

// class Faculty {
//   final String name;
//   final String imagePath;
//   final List<Department> departments;

//   Faculty({
//     required this.name,
//     required this.imagePath,
//     required this.departments,
//   });

//   factory Faculty.fromMap(Map<String, dynamic> map) {
//     return Faculty(
//       name: map['name'],
//       imagePath: map['imagePath'],
//       departments: (map['departments'] as List<dynamic>)
//           .map((d) => Department.fromMap(d))
//           .toList(),
//     );
//   }
// }

// class Faculty {
//   final String id;
//   final String name;
//   final String imagePath;
//   final String? description; // ✅ حقل النبذة
//   final List<Department> departments;

//   Faculty({
//     required this.id,
//     required this.name,
//     required this.imagePath,
//     this.description,
//     required this.departments,
//   });

//   factory Faculty.fromMap(Map<String, dynamic> map) {
//     return Faculty(
//       id: map['id'] ?? '',
//       name: map['collegeName'] ?? '',
//       imagePath: map['imagePath'] ?? 'assets/default.jpg',
//       description: map['description'], // ✅ جلب النبذة من قاعدة البيانات
//       departments: (map['departments'] as List<dynamic>? ?? [])
//           .map((d) => Department.fromMap(d as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'imagePath': imagePath,
//       'description': description,
//       'departments': departments.map((d) => d.toMap()).toList(),
//     };
//   }
// }

class Faculty {
  final String id;
  final String name;
  final String imagePath;
  final String? description;
  final List<Department> departments;

  Faculty({
    required this.id,
    required this.name,
    required this.imagePath,
    this.description,
    required this.departments,
  });

  factory Faculty.fromMap(Map<String, dynamic> map, String docId,
      {List<Department> departments = const []}) {
    return Faculty(
      id: docId,
      name: map['collegeName'] ?? map['name'] ?? '',
      imagePath: map['imagePath'] ?? 'assets/default.jpg',
      description: map['description'],
      departments: departments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'collegeName': name,
      'imagePath': imagePath,
      'description': description,
      // 'departments': departments.map((d) => d.toMap()).toList(),
    };
  }
}
