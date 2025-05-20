import 'package:flutter/material.dart';

class Popmenubotton extends StatelessWidget {
  final String? dean;
  final String? password;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const Popmenubotton({
    super.key,
    this.dean,
    this.password,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        if (dean != null)
          PopupMenuItem(
            value: 'dean',
            child: Text('العميد: $dean'),
          ),
        if (password != null)
          PopupMenuItem(
            value: 'password',
            child: Text('كلمة المرور: $password'),
          ),
        const PopupMenuItem(value: 'edit', child: Text('تعديل')),
        const PopupMenuItem(value: 'delete', child: Text('حذف')),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
    );
  }
}
