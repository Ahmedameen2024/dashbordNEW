import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
// import 'package:flutter_application_1/controll/nav_controller.dart';
import 'package:flutter_application_1/model/modeldepartments.dart';
import 'package:flutter_application_1/model/modelgraduates.dart';
// import 'package:flutter_application_1/model/modeldepartments.dart';
// import 'package:flutter_application_1/model/modelgraduates.dart';
import 'package:flutter_application_1/model/modelresearch.dart';
// import 'package:flutter_application_1/screen/chat_screen.dart';
import 'package:flutter_application_1/screen/graduatespage.dart';
import 'package:flutter_application_1/screen/researchpage.dart';
// import 'package:flutter_application_1/widget/listcollageanddepartment.dart';
import 'package:get/get.dart';

class FacultiesPage extends StatefulWidget {
  @override
  State<FacultiesPage> createState() => _FacultiesPageState();
}

class _FacultiesPageState extends State<FacultiesPage> {
  int?
      expandedFacultyIndex; // تتبع الكلية المفتوحة او لتحديد الكلية المفتوحة حاليًا (expand/collapse).
  final Map<String, bool> _expandedDepartments =
      {}; // لتخزين الأقسام المفتوحة لكل كلية.
  final Map<String, bool> _showFullDesc =
      {}; // تتبع حالة "قراءة المزيد" لكل قسم
  final Map<String, bool> _showFullFacultyDesc =
      {}; // تتبع حالة "قراءة المزيد" لكل كلية
  late Future<List<Faculty>>
      facultiesFuture; //المتغير الذي سيحمل الكليات من قاعدة البيانات أو من دالة fetch.

//عند تحميل الصفحة، يتم تحميل بيانات الكليات باستخدام دالة fetchFacultiesWithDepartments.
  @override
  void initState() {
    super.initState();
    facultiesFuture = fetchFaculties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Faculty>>(
        future: facultiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          final faculties = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: faculties.length,
            itemBuilder: (context, index) {
              final faculty =
                  faculties[index]; //الحصول على بيانات الكلية الحالية.
              final isFacultyExpanded =
                  expandedFacultyIndex == index; //التحقق هل هذه الكلية مفتوحة.

              // خصائص النبذة التعريفية للكلية
              final facultyDesc = faculty.description ?? 'لا توجد نبذة متاحة.';
              final bool facultyNeedsReadMore = facultyDesc.length > 100;
              final bool facultyShowAll =
                  _showFullFacultyDesc[faculty.name] ?? false;
              final String facultyShortDesc = facultyNeedsReadMore
                  ? facultyDesc.substring(0, 100) + '...'
                  : facultyDesc;

              return Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shadowColor: Colors.teal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان الكلية
                    InkWell(
                      onTap: () {
                        setState(() {
                          expandedFacultyIndex =
                              isFacultyExpanded ? null : index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            AdvancedAvatar(
                              size: 45,
                              image: AssetImage(faculty.imagePath),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              faculty.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              isFacultyExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // النبذة التعريفية للكلية (فوق الأقسام)
                    if (isFacultyExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          color: Colors.blue.shade50.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.blue.shade200, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  facultyShowAll
                                      ? facultyDesc
                                      : facultyShortDesc,
                                  maxLines: facultyShowAll ? null : 3,
                                  overflow: facultyShowAll
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                                if (facultyNeedsReadMore)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      child: Text(facultyShowAll
                                          ? 'إخفاء'
                                          : 'قراءة المزيد'),
                                      onPressed: () {
                                        setState(() {
                                          _showFullFacultyDesc[faculty.name] =
                                              !facultyShowAll;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(50, 30),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    // الأقسام (تظهر فقط إذا الكلية مفتوحة)
                    if (isFacultyExpanded)
                      ...faculty.departments.map((deptDoc) {
                        final isExpanded =
                            _expandedDepartments[deptDoc.name] ?? false;
                        final desc =
                            deptDoc.description ?? 'لا توجد نبذة متاحة.';
                        final bool needsReadMore = desc.length > 100;
                        final bool showAll =
                            _showFullDesc[deptDoc.name] ?? false;
                        final String shortDescription = needsReadMore
                            ? desc.substring(0, 100) + '...'
                            : desc;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(height: 24),
                            // عنوان القسم وزر الفتح
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _expandedDepartments[deptDoc.name] =
                                      !isExpanded;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_right,
                                    color: Colors.teal,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    deptDoc.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // تفاصيل القسم
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // النبذة التعريفية في Card مستقل
                                    Card(
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      color:
                                          Colors.blue.shade50.withOpacity(0.2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.blue.shade200,
                                            width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              showAll ? desc : shortDescription,
                                              maxLines: showAll ? null : 3,
                                              overflow: showAll
                                                  ? TextOverflow.visible
                                                  : TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            if (needsReadMore)
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextButton(
                                                  child: Text(showAll
                                                      ? 'إخفاء'
                                                      : 'قراءة المزيد'),
                                                  onPressed: () {
                                                    setState(() {
                                                      _showFullDesc[deptDoc
                                                          .name] = !showAll;
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize:
                                                        const Size(50, 30),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // الأزرار دائماً تظهر أسفل النبذة
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton.icon(
                                            label: const Column(
                                              children: [
                                                Icon(Icons.school),
                                                Text('الخريجين'),
                                              ],
                                            ),
                                            onPressed: () async {
                                              try {
                                                final querySnapshot =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('graduates')
                                                        .where('departmentId',
                                                            isEqualTo: deptDoc
                                                                .id) // تأكد أن dept.id موجود
                                                        .get();

                                                if (querySnapshot
                                                    .docs.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'لا توجد خريجين')),
                                                  );
                                                  return;
                                                }

                                                querySnapshot.docs.map((doc) {
                                                  return Graduate.fromMap(
                                                    doc.data(),
                                                  );
                                                }).toList();

                                                Get.to(() => GraduatesPage(
                                                      departmentId: deptDoc.id!,
                                                      departmentName:
                                                          deptDoc.name,
                                                      // graduates: gradauts,
                                                    ));
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'عرض not found Graduates ${deptDoc.name}')),
                                                );
                                              }
                                            },
                                          ),
                                          ElevatedButton.icon(
                                            label: const Column(
                                              children: [
                                                Icon(Icons.download),
                                                Text('الخطةالدراسية'),
                                              ],
                                            ),
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'تحميل الخطة الدراسية${deptDoc.name}')),
                                              );
                                            },
                                          ),
                                          ElevatedButton.icon(
                                            label: const Column(
                                              children: [
                                                Icon(Icons.menu_book),
                                                Text('الأبحاث'),
                                              ],
                                            ),
                                            onPressed: () async {
                                              try {
                                                final querySnapshot =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'researches')
                                                        .where('departmentId',
                                                            isEqualTo: deptDoc
                                                                .id) // تأكد أن dept.id موجود
                                                        .get();

                                                if (querySnapshot
                                                    .docs.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'لا توجد أبحاث')),
                                                  );
                                                  return;
                                                }

                                                final researches = querySnapshot
                                                    .docs
                                                    .map((doc) {
                                                  return Research.fromMap(
                                                      doc.data(), doc.id);
                                                }).toList();

                                                Get.to(() => ResearchPage(
                                                      departmentName:
                                                          deptDoc.name,
                                                      // departmentId: dept.id!,
                                                      researches: researches,
                                                    ));
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'حدث خطأ أثناء تحميل الأبحاث: $e')),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Faculty>> fetchFaculties() async {
    // final snapshot =
    //     await FirebaseFirestore.instance.collection('colleges').get();
    final departmentsSnapshot =
        await FirebaseFirestore.instance.collection('departments').get();
    final collegesSnapshot =
        await FirebaseFirestore.instance.collection('colleges').get();
    final allDepartments = departmentsSnapshot.docs.map((deptDoc) {
      final data = deptDoc.data();
      return Department.fromMap(data, deptDoc.id);
    }).toList();

    List<Faculty> faculties = [];

    for (var college in collegesSnapshot.docs) {
      final data = college.data();
      final collegeId = college.id;
      final facultyDepartments =
          allDepartments.where((dept) => dept.collegeId == collegeId).toList();
      faculties.add(
          Faculty.fromMap(data, college.id, departments: facultyDepartments));
    }
    return faculties;
  }
}
