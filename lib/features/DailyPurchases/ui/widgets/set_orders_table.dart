// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

import '../../../../core/theme/style.dart';
import '../../data/model/daily_purchases_model.dart';
import 'edit_and_delete_orders.dart';

class MyData extends DataTableSource {
  final List<GetDailyPurchasesModel> _data;

  MyData(this._data);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text((index + 1).toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].supplierName.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].quantity.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].price.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].total.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].paid.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].remains.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].totalBalance.toString(),
            style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        EditiAndDeleteOrderButton(order: _data[index]),
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
