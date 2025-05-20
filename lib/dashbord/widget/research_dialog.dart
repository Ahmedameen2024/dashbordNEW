import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showAddResearchDialog(
    BuildContext context, Function(Map<String, dynamic>) onAddResearch,
    {Map<String, dynamic>? existingResearch, int? index}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController memberController = TextEditingController();
  String? selectedDepartment;
  String? selectedFilePath;
  List<String> teamMembers = [];

  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(index == null ? 'إضافة بحث' : 'تعديل بحث'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'عنوان البحث'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: supervisorController,
                decoration: const InputDecoration(labelText: 'مشرف البحث'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'القسم'),
                value: selectedDepartment,
                items: ['علوم الحاسب', 'نظم المعلومات', 'هندسة البرمجيات']
                    .map(
                        (dep) => DropdownMenuItem(value: dep, child: Text(dep)))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedDepartment = value);
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: memberController,
                      decoration:
                          const InputDecoration(labelText: 'عضو فريق بحثي'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (memberController.text.trim().isNotEmpty) {
                        setState(() {
                          teamMembers.add(memberController.text.trim());
                          memberController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(teamMembers.length, (index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(teamMembers[index]),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            setState(() => teamMembers.removeAt(index));
                          },
                          child: const Icon(Icons.close,
                              size: 16, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'docx', 'txt'],
                  );
                  if (result != null) {
                    setState(() {
                      selectedFilePath = result.files.single.path;
                    });
                  }
                },
                child: const Text('رفع ملف البحث'),
              ),
              if (selectedFilePath != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'تم اختيار الملف: ${selectedFilePath?.split('/').last}',
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty ||
                  supervisorController.text.isEmpty ||
                  selectedDepartment == null) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('يرجى ملء جميع الحقول')),
                // );
                return;
              }

              final newResearch = {
                'title': titleController.text.trim(),
                'supervisor': supervisorController.text.trim(),
                'department': selectedDepartment,
                'team': teamMembers,
                'file': selectedFilePath,
              };

              onAddResearch(newResearch);
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    ),
  );
}
