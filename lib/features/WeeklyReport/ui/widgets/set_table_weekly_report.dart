import 'package:flutter/material.dart';

import '../../../../core/theme/style.dart';
import '../../data/model/weekly_report_model.dart';

class WeeklyReportTableData extends DataTableSource {
  final List<WeeklyReportTableModel> _data;

  WeeklyReportTableData(this._data);
  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text((index + 1).toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].name.toString(),
              style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].total.toString(),
              style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].totalPaid.toString(),
              style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].totalQuantity.toString(),
              style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].totalRemains.toString(),
              style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].sat.toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].sun.toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].mon.toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].tue.toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].wed.toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].thu.toString(), style: TextStyles.font14GrayMedium),
        ),
        DataCell(
          Text(_data[index].fri.toString(), style: TextStyles.font14GrayMedium),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
