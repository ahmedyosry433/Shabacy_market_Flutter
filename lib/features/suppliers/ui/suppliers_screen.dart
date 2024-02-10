import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/theme/colors.dart';
import 'package:shabacy_market/core/widgets/app_custom_appbar.dart';
import 'package:shabacy_market/core/widgets/app_custom_dropdwo_with_hint.dart';
import 'package:shabacy_market/core/widgets/app_text_button.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field_with_hint.dart';
import 'package:shabacy_market/features/suppliers/logic/cubit/suppliers_cubit.dart';
import 'package:shabacy_market/features/suppliers/ui/widget/set_table.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_custom_dropdown.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
    BlocProvider.of<SuppliersCubit>(context).getAllUsersCubit();
  }

  @override
  Widget build(BuildContext context) {
    final DataTableSource data = MyData(
        context.watch<SuppliersCubit>().suppliers,
        context.watch<SuppliersCubit>().users);
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
            buildAddNewAndText(),
            buildBloc(data: data),
          ],
        ),
      ),
    ));
  }

  Widget buildBloc({required DataTableSource data}) {
    return BlocBuilder<SuppliersCubit, SuppliersState>(
      builder: (context, state) {
        if (state is SuppliersLoading) {
          return Padding(
            padding: EdgeInsets.only(top: 250.h),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SuppliersLoaded) {
          return Column(
            children: [
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
                      label: Text('phone'.tr(),
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
                source: data,
                columnSpacing: 45.w,
                horizontalMargin: 20.w,
                rowsPerPage: 6,
              ),
            ],
          );
        } else if (state is SuppliersError) {
          return Text(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget buildAddNewAndText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
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
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => SizedBox(
                          height: 500.h,
                          child: buildAddNewSupplier(),
                        ));
              })
        ],
      ),
    );
  }

  Widget buildAddNewSupplier() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('addNewSupplier'.tr(), style: TextStyles.font20BlackRegular),
            verticalSpace(10.h),
            AppTextFormFieldWithTopHint(
              topHintText: 'name'.tr(),
              appTextFormField: AppTextFormField(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                hintText: 'enterName'.tr(),
                validator: (validator) {},
                keyboardType: TextInputType.name,
              ),
            ),
            verticalSpace(10.h),
            AppTextFormFieldWithTopHint(
              topHintText: 'phone'.tr(),
              appTextFormField: AppTextFormField(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                hintText: 'enterPhone'.tr(),
                validator: (validator) {},
                keyboardType: TextInputType.phone,
              ),
            ),
            verticalSpace(10.h),
            AppCustomDropdownWithTopHint(
              topHintText: 'delegate'.tr(),
              appCustomDropdown: AppCustomDropDownFormButton(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                onChanged: (value) {},
                items:
                    BlocProvider.of<SuppliersCubit>(context).users.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.id.toString(),
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                AppTextButton(
                    backgroundColor: ColorsManager.red,
                    verticalPadding: 0,
                    horizontalPadding: 0,
                    buttonHeight: 30.h,
                    buttonWidth: 60.w,
                    buttonText: 'cancel'.tr(),
                    textStyle: TextStyles.font13WhiteSemiBold,
                    onPressed: () {
                      context.pop();
                    }),
                horizontalSpace(10),
                AppTextButton(
                    verticalPadding: 0,
                    horizontalPadding: 0,
                    buttonHeight: 30.h,
                    buttonWidth: 60.w,
                    buttonText: 'save'.tr(),
                    textStyle: TextStyles.font13WhiteSemiBold,
                    onPressed: () {
                      context.pop();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
