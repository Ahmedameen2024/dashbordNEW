// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/dashbord/widget/tablerowdata.dart';


// bool isMobileView(BuildContext context) {
//   return MediaQuery.of(context).size.width < 600;
// }

// TableRow buildGraduateRow({
//   required BuildContext context,
//   required String name,
//   required String image,
//   required String year,
//   required String degree,
//   required String major,
//   required String gpa,
//   required String email,
//   required VoidCallback onEdit,
//   required VoidCallback onDelete,
// }) {
//   bool isMobile = isMobileView(context);

//   return TableRowData.build(
//     isMobile: isMobile,
//     cells: [
//       TableCellData(
//         child: Row(
//           children: [
//             CircleAvatar(backgroundImage: AssetImage(image), radius: 25),
//             const SizedBox(width: 8),
//             Expanded(child: Text(name)),
//           ],
//         ),
//       ),
//       TableCellData(child: Text(year), hideOnMobile: true),
//       TableCellData(child: Text(degree), hideOnMobile: true),
//       TableCellData(child: Text(major), hideOnMobile: true),
//       TableCellData(child: Text(gpa), hideOnMobile: false),
//       TableCellData(child: Text(email), hideOnMobile: true),
//       TableCellData(
//         child: isMobile
//             ? PopupMenuButton<String>(
//                 icon: const Icon(Icons.more_vert),
//                 onSelected: (value) {
//                   if (value == 'edit') onEdit();
//                   if (value == 'delete') onDelete();
//                 },
//                 itemBuilder: (_) => [
//                   PopupMenuItem(value: 'email', child: Text('البريد: $email')),
//                   const PopupMenuItem(value: 'edit', child: Text('تعديل')),
//                   const PopupMenuItem(value: 'delete', child: Text('حذف')),
//                 ],
//               )
//             : Row(
//                 children: [
//                   IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
//                   IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
//                 ],
//               ),
//       ),
//     ],
//   );
// }
