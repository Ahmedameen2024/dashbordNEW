import 'package:flutter/material.dart';

class DepartmentTableHelper {
  static DataRow buildRow({
    required Map<String, dynamic> department,
    required int index,
    required bool isMobile,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return DataRow(cells: [
      DataCell(Text(department['name'] ?? '')),
      DataCell(Text(department['description'] ?? '')),
      if (!isMobile) DataCell(Text(department['head'] ?? '')),
      if (!isMobile) DataCell(Text(department['password']?.toString() ?? '')),
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
      const DataColumn(label: Text('اسم القسم')),
      const DataColumn(label: Text('وصف القسم')),
      if (!isMobile) const DataColumn(label: Text('رئيس القسم')),
      if (!isMobile) const DataColumn(label: Text('عدد الطلاب')),
      const DataColumn(label: Text('تحكم')),
    ];
  }
}
