import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashbord/widget/research_dialog.dart';

// class ResearchControlPage extends StatefulWidget {
//   const ResearchControlPage({super.key});

//   @override
//   State<ResearchControlPage> createState() => _ResearchControlPageState();
// }

// class _ResearchControlPageState extends State<ResearchControlPage> {
//   List<Map<String, dynamic>> researches = [];

//   void _addResearch(Map<String, dynamic> research) {
//     setState(() => researches.add(research));
//   }

//   void _editResearch(int index, Map<String, dynamic> updatedResearch) {
//     setState(() => researches[index] = updatedResearch);
//   }

//   void _showAddDialog({Map<String, dynamic>? existingResearch, int? index}) {
//     showAddResearchDialog(context, (data) {
//       if (existingResearch != null && index != null) {
//         _editResearch(index, data);
//       } else {
//         _addResearch(data);
//       }
//     }, existingResearch: existingResearch);
//   }

//   void _deleteResearch(int index) {
//     setState(() => researches.removeAt(index));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('إدارة الأبحاث'),
//         actions: [
//           ElevatedButton.icon(
//             icon: const Icon(Icons.add),
//             label: const Text('إضافة ابحاث'),
//             onPressed: () => _showAddDialog(),
//           )
//         ],
//       ),
//       body: researches.isEmpty
//           ? const Center(child: Text('لا توجد أبحاث حالياً'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: researches.length,
//               itemBuilder: (context, index) {
//                 final research = researches[index];
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('العنوان: ${research['title']}',
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         Text('المشرف: ${research['supervisor']}'),
//                         Text('القسم: ${research['department']}'),
//                         if (research['team'] != null)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 8),
//                               const Text('الفريق البحثي:',
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                               const SizedBox(height: 4),
//                               Wrap(
//                                 spacing: 10,
//                                 runSpacing: 6,
//                                 children: List.generate(
//                                     (research['team'] as List).length, (i) {
//                                   return Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 4),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade200,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(research['team'][i]),
//                                   );
//                                 }),
//                               ),
//                             ],
//                           ),
//                         if (research['file'] != null) ...[
//                           const SizedBox(height: 8),
//                           Text('الملف: ${research['file'].split('/').last}',
//                               style: const TextStyle(color: Colors.green)),
//                         ],
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, color: Colors.blue),
//                               onPressed: () => _showAddDialog(
//                                   existingResearch: research, index: index),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (_) => AlertDialog(
//                                     title: const Text('تأكيد الحذف'),
//                                     content: const Text(
//                                         'هل أنت متأكد من حذف هذا البحث؟'),
//                                     actions: [
//                                       // TextButton(
//                                       //   child: const Text('إلغاء'),
//                                       //   // onPressed: () => Navigator.pop(context),
//                                       // ),
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.red),
//                                         onPressed: () {
//                                           _deleteResearch(index);
//                                           // Navigator.of(context).pop();
//                                         },
//                                         child: const Text('حذف'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/modelresearch.dart';
import 'package:url_launcher/url_launcher.dart';

class ResearchControlPage extends StatefulWidget {
  final String departmentId;
  const ResearchControlPage({super.key, required this.departmentId});

  @override
  State<ResearchControlPage> createState() => _ResearchControlPageState();
}

class _ResearchControlPageState extends State<ResearchControlPage> {
  List<Research> researches = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadResearches();
  }

  Future<void> loadResearches() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('researches')
          .where('departmentId', isEqualTo: widget.departmentId)
          .get();

      setState(() {
        researches = snapshot.docs
            .map((doc) => Research.fromMap(doc.data(), doc.id))
            .toList();
        loading = false;
      });
    } catch (e) {
      print('Error loading researches: $e');
    }
  }

  Future<String> uploadFile(File file) async {
    final ref = FirebaseStorage.instance
        .ref('research_files/${DateTime.now().millisecondsSinceEpoch}.pdf');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> addOrUpdateResearch({Research? research, File? file}) async {
    try {
      String fileUrl = research?.fileUrl ?? '';
      if (file != null) {
        fileUrl = await uploadFile(file);
      }

      final newData = {
        'departmentId': widget.departmentId,
        'title': titleController.text,
        'team': teamController.text,
        'year': yearController.text,
        'summary': summaryController.text,
        'fileUrl': fileUrl,
      };

      if (research == null) {
        final doc = await FirebaseFirestore.instance
            .collection('researches')
            .add(newData);
        setState(() {
          researches.add(Research.fromMap(newData, doc.id));
        });
      } else {
        await FirebaseFirestore.instance
            .collection('researches')
            .doc(research.id)
            .update(newData);
        await loadResearches();
      }
    } catch (e) {
      print('Error saving research: $e');
    }
  }

  Future<void> deleteResearch(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('researches')
          .doc(id)
          .delete();
      setState(() => researches.removeWhere((r) => r.id == id));
    } catch (e) {
      print('Error deleting research: $e');
    }
  }

  final titleController = TextEditingController();
  final teamController = TextEditingController();
  final yearController = TextEditingController();
  final summaryController = TextEditingController();
  File? selectedFile;

  void showResearchDialog({Research? research}) {
    if (research != null) {
      titleController.text = research.title;
      teamController.text = research.team;
      yearController.text = research.year;
      summaryController.text = research.summary;
    } else {
      titleController.clear();
      teamController.clear();
      yearController.clear();
      summaryController.clear();
      selectedFile = null;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(research == null ? 'إضافة بحث' : 'تعديل بحث'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'عنوان البحث')),
              TextField(
                  controller: teamController,
                  decoration:
                      const InputDecoration(labelText: 'الفريق البحثي')),
              TextField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'سنة البحث')),
              TextField(
                  controller: summaryController,
                  decoration: const InputDecoration(labelText: 'ملخص البحث')),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.attach_file),
                label: const Text('اختر ملف PDF'),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom, allowedExtensions: ['pdf']);
                  if (result != null)
                    selectedFile = File(result.files.single.path!);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  teamController.text.isNotEmpty) {
                addOrUpdateResearch(research: research, file: selectedFile);
                Navigator.pop(context);
              }
            },
            child: Text(research == null ? 'إضافة' : 'حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأبحاث'),
        backgroundColor: Colors.blue[200],
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showResearchDialog(),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('العنوان')),
            DataColumn(label: Text('الفريق')),
            DataColumn(label: Text('السنة')),
            DataColumn(label: Text('الملخص')),
            DataColumn(label: Text('الملف')),
            DataColumn(label: Text('تحكم')),
            // DataColumn(label: Text('حذف')),
          ],
          rows: researches.map((r) {
            return DataRow(cells: [
              DataCell(Text(r.title)),
              DataCell(Text(r.team)),
              DataCell(Text(r.year)),
              DataCell(Text(r.summary,
                  maxLines: 1, overflow: TextOverflow.ellipsis)),
              DataCell(
                TextButton(
                  child: const Text('عرض'),
                  onPressed: () => launchUrl(Uri.parse(r.fileUrl)),
                ),
              ),
              DataCell(Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showResearchDialog(research: r)),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteResearch(r.id),
                  ),
                ],
              )),
              // DataCell(IconButton(icon: const Icon(Icons.edit), onPressed: () => showResearchDialog(research: r))),
              // DataCell(IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteResearch(r.id))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
