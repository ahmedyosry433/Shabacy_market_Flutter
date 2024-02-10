// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../data/models/suppliers_model.dart';

class MyData extends DataTableSource {
  final List<SuppliersModel> _data;
  final List<UserModel> _users;
  MyData(this._data, this._users);
  @override
  DataRow? getRow(int index) {
    // final UserModel query =
    //     _users.firstWhere((item) => item.id == _data[index].name);
    return DataRow(cells: [
      DataCell(
        Text((index + 1).toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].name.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].mobile.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].deposits.toString(),
            style: _data[index].deposits >= 0
                ? TextStyles.font14GrayMedium
                : TextStyles.font14RedMedium),
      ),
      DataCell(
        Text(_data[index].name.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        buildDeleteAndEditButton(index),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  Widget buildDeleteAndEditButton(index) {
    return Row(
      children: [
        const Icon(Icons.edit, color: ColorsManager.primryColor),
        horizontalSpace(10),
        const Icon(Icons.delete, color: ColorsManager.red),
      ],
    );
  }
}
