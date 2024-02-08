// import 'dart:math';

// import 'package:flutter/material.dart';

// import '../../../../core/helper/spacing.dart';
// import '../../../../core/theme/colors.dart';
// import '../../../../core/theme/style.dart';

// class MyData extends DataTableSource {
//   final List<Map<String, dynamic>> _data = List.generate(
//     200,
//     (index) => {
//       "id": index,
//       "name": "Name $index",
//       "balance": Random().nextInt(10000),
//       "delegate": "delegate $index",
//     },
//   );
//   @override
//   DataRow? getRow(int index) {
//     return DataRow(cells: [
//       DataCell(
//         Text(_data[index]['id'].toString(), style: TextStyles.font14GrayMedium),
//       ),
//       DataCell(
//         Text(_data[index]['name'].toString(),
//             style: TextStyles.font14GrayMedium),
//       ),
//       DataCell(
//         Text(_data[index]['balance'].toString(),
//             style: TextStyles.font14GrayMedium),
//       ),
//       DataCell(
//         Text(_data[index]['delegate'].toString(),
//             style: TextStyles.font14GrayMedium),
//       ),
//       DataCell(
//         buildDeleteAndEditButton(index),
//       ),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => _data.length;

//   @override
//   int get selectedRowCount => 0;

//   Widget buildDeleteAndEditButton(index) {
//     return Row(
//       children: [
//         const Icon(Icons.edit, color: ColorsManager.primryColor),
//         horizontalSpace(10),
//         const Icon(Icons.delete, color: ColorsManager.red),
//       ],
//     );
//   }
// }
