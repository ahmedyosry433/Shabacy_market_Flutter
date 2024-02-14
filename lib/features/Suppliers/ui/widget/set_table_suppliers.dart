// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:shabacy_market/features/Suppliers/data/models/suppliers_model.dart';
import 'package:shabacy_market/features/Suppliers/ui/widget/suppliers_edit_delete_buttons.dart';

import '../../../../core/theme/style.dart';


class MyData extends DataTableSource {
  final List<SuppliersModel> _data;

  MyData(this._data);
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
        Text(_data[index].delegate.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        SuppliersEditAndDeleteButton(supplierModel: _data[index]),
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
