// ignore_for_file: unrelated_type_equality_checks, file_names

import 'package:flutter/material.dart';
import 'package:shabacy_market/features/Categories/ui/widget/edit_and_delete_Categories.dart';

import '../../../../core/theme/style.dart';
import '../../data/model/categories_model.dart';

class CategoriesTableData extends DataTableSource {
  final List<CategoriesModel> _data;

  CategoriesTableData(this._data);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text((index + 1).toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(
        Text(_data[index].name.toString(), style: TextStyles.font14GrayMedium),
      ),
      DataCell(EditCategoriesButton(categories: _data[index])),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
