import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/theme/colors.dart';
import 'package:shabacy_market/core/widgets/app_custom_appbar.dart';
import 'package:shabacy_market/core/widgets/app_text_button.dart';

import '../../../core/theme/style.dart';
import 'widget/set_table.dart';

class SuppliersScreen extends StatelessWidget {
  SuppliersScreen({super.key});

  final DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppCustomAppbar(
              profileStyle:
                  TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
              child: Column(
                children: [
                  buildAddNewAndText(),
                  PaginatedDataTable(
                    arrowHeadColor: ColorsManager.primryColor,
                    columns: [
                      DataColumn(
                          label: Text('id'.tr(),
                              style: TextStyles.font14BlackSemiBold)),
                      DataColumn(
                          label: Text('name'.tr(),
                              style: TextStyles.font14BlackSemiBold)),
                      DataColumn(
                          label: Text('balance'.tr(),
                              style: TextStyles.font14BlackSemiBold)),
                      DataColumn(
                          label: Text('delegate'.tr(),
                              style: TextStyles.font14BlackSemiBold)),
                      DataColumn(
                          label: Text('control'.tr(),
                              style: TextStyles.font14BlackSemiBold)),
                    ],
                    source: _data,
                    columnSpacing: 45.w,
                    horizontalMargin: 20.w,
                    rowsPerPage: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildAddNewAndText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('suppliersList'.tr(), style: TextStyles.font16BlackSemiBold),
          AppTextButton(
              buttonHeight: 40.h,
              buttonWidth: 100.w,
              backgroundColor: ColorsManager.primryColor,
              buttonText: 'addNewSupplier'.tr(),
              textStyle: TextStyles.font13WhiteSemiBold,
              onPressed: () {})
        ],
      ),
    );
  }
}
