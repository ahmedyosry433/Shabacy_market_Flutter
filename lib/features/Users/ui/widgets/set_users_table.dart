// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/features/Users/data/model/profile_model.dart';
import 'package:shabacy_market/features/Users/ui/widgets/edit_and_delete_user.dart';

import '../../../../core/theme/style.dart';

class MyData extends DataTableSource {
  final List<UserModel> _data;

  MyData(this._data);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text((index + 1).toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].name.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].email.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].role.tr().toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        EditiAndDeleteUsersButton(),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
