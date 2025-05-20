import 'package:cloud_firestore/cloud_firestore.dart';

class Graduate {
  final String id;
  final String name;
  final String gpa;
  final String graduationYear;
  final String email;
  final String departmentId;
  final DateTime createdAt;

  Graduate({
    required this.id,
    required this.name,
    required this.gpa,
    required this.graduationYear,
    required this.email,
    required this.departmentId,
    required this.createdAt,
  });

  factory Graduate.fromMap(Map<String, dynamic> map) {
    return Graduate(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      gpa: map['gpa'] ?? '',
      graduationYear: map['graduationYear'] ?? '',
      email: map['email'] ?? '',
      departmentId: map['departmentId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gpa': gpa,
      'graduationYear': graduationYear,
      'email': email,
      'departmentId': departmentId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}




// class Graduate {
//   final String id;
//   final String name;
//   final String department;
//   final String gpa;
//   final String graduationYear;
//   final String email;

//   Graduate({
//     required this.id,
//     required this.name,
//     required this.department,
//     required this.gpa,
//     required this.graduationYear,
//     required this.email,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'department': department,
//       'gpa': gpa,
//       'graduationYear': graduationYear,
//       'email': email,
//     };
//   }

//   factory Graduate.fromMap(Map<String, dynamic> map, String documentId) {
//     return Graduate(
//       id: map['id'],
//       name: map['name'],
//       department: map['department'],
//       gpa: map['gpa'],
//       graduationYear: map['graduationYear'],
//       email: map['email'],
//     );
//   }
// }
