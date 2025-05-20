import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashbord/widget/addbutton.dart';
import 'package:flutter_application_1/dashbord/widget/editbutton.dart';
import 'package:flutter_application_1/dashbord/widget/popmenubutton.dart';

class opreation extends StatelessWidget {
  const opreation({
    super.key,
    required this.isMobile, required Null Function() onEdit, required Null Function() onDelete,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isMobile)
          IconButton(
            onPressed: () {
              Editbutton.showAlert(
                context: context,
                title: 'Edit',
                content: const Text('هل ترغب بتعديل بيانات هذه الكلية؟'),
                action: [
                  TextButton(
                    onPressed: () {
                      Addbutton.ShowCustomDilalog(
                        context: context,
                        title: 'Edit collage or Admin',
                        controller: TextEditingController(),
                        admin: TextEditingController(),
                        password: TextEditingController(),
                      );
                    },
                    child: const Text('موافق'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('إلغاء'),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.edit),
          ),
        if (isMobile) Popmenubotton(onDelete: () {}, onEdit: () {}),
        if (!isMobile)
          IconButton(
            onPressed: () {
              // حذف
            },
            icon: const Icon(Icons.delete),
          ),
      ],
    );
  }
}
