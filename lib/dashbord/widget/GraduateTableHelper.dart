import 'package:flutter/material.dart';

class GraduateTableHelper {
  static DataRow buildRow({
    required Map<String, dynamic> grad,
    required int index,
    required bool isMobile,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return DataRow(cells: [
      DataCell(Text(grad['name'] ?? '')),
      if (!isMobile) DataCell(Text(grad['id']?.toString() ?? '')),
      DataCell(Text(grad['department'] ?? '')),
      if (!isMobile) DataCell(Text(grad['gpa']?.toString() ?? '')),
      DataCell(Text(grad['graduationYear']?.toString() ?? '')),
      if (!isMobile) DataCell(Text(grad['email'] ?? '')),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      )),
    ]);
  }

  static List<DataColumn> buildColumns(bool isMobile) {
    return [
      const DataColumn(label: Text('الاسم')),
      if (!isMobile) const DataColumn(label: Text('الرقم الجامعي')),
      const DataColumn(label: Text('القسم')),
      if (!isMobile) const DataColumn(label: Text('المعدل')),
      const DataColumn(label: Text('سنة التخرج')),
      if (!isMobile) const DataColumn(label: Text('البريد الإلكتروني')),
      const DataColumn(label: Text('تحكم')),
    ];
  }
}
