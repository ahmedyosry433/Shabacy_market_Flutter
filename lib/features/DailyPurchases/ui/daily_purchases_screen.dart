import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/widgets/app_coustom_loading_indecator.dart';
import 'package:shabacy_market/core/widgets/app_custom_dropdwo_with_hint.dart';
import 'package:shabacy_market/core/widgets/app_text_button.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field_with_hint.dart';
import 'package:shabacy_market/features/DailyPurchases/logic/cubit/daily_purchases_cubit.dart';
import 'package:shabacy_market/features/DailyPurchases/ui/widgets/set_orders_table.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_custom_appbar.dart';
import '../../../core/widgets/app_custom_dropdown.dart';
import '../../../core/widgets/app_text_form_field.dart';

class DailyPurchasesScreen extends StatefulWidget {
  const DailyPurchasesScreen({super.key});

  @override
  State<DailyPurchasesScreen> createState() => _DailyPurchasesScreenState();
}

class _DailyPurchasesScreenState extends State<DailyPurchasesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DailyPurchasesCubit>().initOnce();

    dateController.text =
        formating.format(context.read<DailyPurchasesCubit>().selectDate!);

    context.read<DailyPurchasesCubit>().dropdownPeriodValue =
        _enumToString(Period.AM);
  }

  DateFormat formating = DateFormat.yMd('ar');
  String _enumToString(Period period) {
    switch (period) {
      case Period.AM:
        return 'AM';
      case Period.PM:
        return 'PM';
    }
  }

  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final DataTableSource data = MyData(
      context.watch<DailyPurchasesCubit>().listOfOrders,
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorsManager.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppCustomAppbar(
                profileStyle:
                    TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
              ),
              BlocBuilder<DailyPurchasesCubit, DailyPurchasesState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const AppCustomLoadingIndecator();
                  } else if (state is Loaded) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.h),
                      child: Column(
                        children: [
                          buildCompletFormDayAndPeriodAndItem(context),
                          verticalSpace(20),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'new order'.tr(),
                                style: TextStyles.font16BlackSemiBold
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          buildNewOrder(),
                          verticalSpace(10),
                          buildOrdersTable(source: data),
                        ],
                      ),
                    );
                  } else if (state is Error) {
                    return Text(state.error);
                  }
                  return const SizedBox();
                },
              ),
              buildTableBlocListener(),
              buildEditBlocListener(),
              buildDeleteBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompletFormDayAndPeriodAndItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorsManager.gray.withOpacity(0.08),
        border: Border.all(
          color: ColorsManager.white.withOpacity(0.5),
          width: 1.5.w,
        ),
      ),
      child: Column(
        children: [
          AppTextFormFieldWithTopHint(
              topHintText: 'day'.tr(),
              appTextFormField: AppTextFormField(
                readOnly: true,
                controller: dateController,
                suffixIcon: IconButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final firstDate = DateTime(now.year - 2);
                    final lastDate = DateTime(now.year + 2);
                    showDatePicker(
                            context: context,
                            initialDate:
                                BlocProvider.of<DailyPurchasesCubit>(context)
                                    .selectDate!,
                            firstDate: firstDate,
                            lastDate: lastDate)
                        .then(
                      (value) {
                        setState(() {
                          if (value != null &&
                              value !=
                                  BlocProvider.of<DailyPurchasesCubit>(context)
                                      .selectDate) {
                            BlocProvider.of<DailyPurchasesCubit>(context)
                                .selectDate = value;
                            dateController.text =
                                formating.format(value).toString();
                            BlocProvider.of<DailyPurchasesCubit>(context)
                                .init();
                          }
                        });
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 25,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                hintText: '',
                validator: (validator) {},
                keyboardType: TextInputType.name,
              )),
          verticalSpace(10),
          Row(
            children: [
              Expanded(
                child: AppCustomDropdownWithTopHint(
                    topHintText: 'period'.tr(),
                    appCustomDropdown: AppCustomDropDownFormButton(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                      hintText: Text('select period'.tr()),
                      items: Period.values.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.name,
                          child: Text(e.name.tr()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          BlocProvider.of<DailyPurchasesCubit>(context)
                              .dropdownPeriodValue = value;

                          BlocProvider.of<DailyPurchasesCubit>(context).init();
                        });
                      },
                      validator: (vaild) {},
                      value: BlocProvider.of<DailyPurchasesCubit>(context)
                          .dropdownPeriodValue,
                    )),
              ),
              horizontalSpace(5),
              Expanded(
                child: AppCustomDropdownWithTopHint(
                    topHintText: 'item'.tr(),
                    appCustomDropdown: AppCustomDropDownFormButton(
                      hintText: Text('select item'.tr()),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                      items: BlocProvider.of<DailyPurchasesCubit>(context)
                          .categories
                          .map((e) {
                        return DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          BlocProvider.of<DailyPurchasesCubit>(context)
                              .dropdownCategroyValue = value;
                          BlocProvider.of<DailyPurchasesCubit>(context).init();
                        });
                      },
                      validator: (vaild) {},
                      value: BlocProvider.of<DailyPurchasesCubit>(context)
                          .dropdownCategroyValue,
                    )),
              ),
            ],
          ),
          verticalSpace(10),
        ],
      ),
    );
  }

  Widget buildNewOrder() {
    final blocRead = context.read<DailyPurchasesCubit>();
    final blocWatch = context.watch<DailyPurchasesCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorsManager.gray.withOpacity(0.1),
          width: 2.w,
        ),
      ),
      child: Form(
        key: BlocProvider.of<DailyPurchasesCubit>(context).newOrderFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppCustomDropdownWithTopHint(
                      topHintText: 'customer'.tr(),
                      appCustomDropdown: AppCustomDropDownFormButton(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        hintText: Text('select customer'.tr()),
                        items: BlocProvider.of<DailyPurchasesCubit>(context)
                            .suppliers
                            .map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id,
                            child: Text(e.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            BlocProvider.of<DailyPurchasesCubit>(context)
                                .dropdownSupplierValue = value;
                          });
                        },
                        validator: (vaild) {
                          if (vaild == null || vaild == '') {
                            return 'select customer'.tr();
                          }
                        },
                        value: BlocProvider.of<DailyPurchasesCubit>(context)
                            .dropdownSupplierValue,
                      )),
                ),
                horizontalSpace(5),
                Expanded(
                  child: AppTextFormFieldWithTopHint(
                      topHintText: 'unit price'.tr(),
                      appTextFormField: AppTextFormField(
                        onChanged: (price) {
                          setState(() {
                            blocRead.totalController.text = (int.parse(price) *
                                    int.parse(blocRead.quantityController.text))
                                .toString();
                          });
                        },
                        controller: blocRead.priceController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        hintText: 'enter unit price'.tr(),
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return 'enter unit price'.tr();
                          }
                        },
                        keyboardType: TextInputType.number,
                      )),
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Expanded(
                  child: AppTextFormFieldWithTopHint(
                      topHintText: 'quantity'.tr(),
                      appTextFormField: AppTextFormField(
                        onChanged: (quantity) {
                          setState(() {
                            blocRead
                                .totalController.text = (int.parse(quantity) *
                                    int.parse(blocRead.priceController.text))
                                .toString();
                          });
                        },
                        controller: context
                            .read<DailyPurchasesCubit>()
                            .quantityController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        hintText: 'enter quantity'.tr(),
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return 'enter quantity'.tr();
                          }
                        },
                        keyboardType: TextInputType.number,
                      )),
                ),
                horizontalSpace(5),
                Expanded(
                  child: AppTextFormFieldWithTopHint(
                      topHintText: 'total purchases'.tr(),
                      appTextFormField: AppTextFormField(
                        controller: blocWatch.totalController,
                        readOnly: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        hintText: '',
                        validator: (validator) {},
                        keyboardType: TextInputType.name,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextFormFieldWithTopHint(
                      topHintText: 'paid'.tr(),
                      appTextFormField: AppTextFormField(
                        onChanged: (paid) {
                          setState(() {
                            blocRead.remainsController.text =
                                (int.parse(blocRead.totalController.text) -
                                        int.parse(paid))
                                    .toString();
                          });
                        },
                        controller: blocRead.paidController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        hintText: 'enter paid'.tr(),
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return 'enter paid'.tr();
                          }
                        },
                        keyboardType: TextInputType.number,
                      )),
                ),
                horizontalSpace(5),
                Expanded(
                  child: AppTextFormFieldWithTopHint(
                      topHintText: 'remaining'.tr(),
                      appTextFormField: AppTextFormField(
                        controller: blocWatch.remainsController,
                        readOnly: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        hintText: '',
                        validator: (validator) {},
                        keyboardType: TextInputType.name,
                      )),
                ),
              ],
            ),
            verticalSpace(10),
            AppTextButton(
              buttonHeight: 40.h,
              buttonWidth: 120.w,
              buttonText: 'add order'.tr(),
              textStyle: TextStyles.font13WhiteSemiBold,
              onPressed: () => newOrder(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTableBlocListener() {
    return BlocListener<DailyPurchasesCubit, DailyPurchasesState>(
      listener: (context, state) {
        if (state is AddedOrderLoading) {
          showProgressIndecator(context);
        } else if (state is AddedOrderLoaded) {
          Navigator.of(context).pop();
          BlocProvider.of<DailyPurchasesCubit>(context).init();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "add order successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        } else if (state is AddedOrderError) {
          Navigator.of(context).pop();
          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error adding order".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget buildEditBlocListener() {
    return BlocListener<DailyPurchasesCubit, DailyPurchasesState>(
      listener: (context, state) {
        if (state is EditedOrderLoading) {
          showProgressIndecator(context);
        } else if (state is EditedOrderLoaded) {
          Navigator.of(context).pop();
          BlocProvider.of<DailyPurchasesCubit>(context).init();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "edit order successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          Navigator.of(context).pop();
        } else if (state is EditedOrderError) {
          Navigator.of(context).pop();
          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error updating order".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget buildDeleteBlocListener() {
    return BlocListener<DailyPurchasesCubit, DailyPurchasesState>(
      listener: (context, state) {
        if (state is DeleteOrderLoading) {
          showProgressIndecator(context);
        } else if (state is DeleteOrderLoaded) {
          Navigator.of(context).pop();
          BlocProvider.of<DailyPurchasesCubit>(context).init();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "delete order successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          Navigator.of(context).pop();
        } else if (state is DeleteOrderError) {
          Navigator.of(context).pop();
          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error deleting order".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget buildOrdersTable({required DataTableSource source}) {
    return PaginatedDataTable(
      arrowHeadColor: ColorsManager.primryColor,
      columns: [
        DataColumn(
            label: Text('id'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('customer name'.tr(),
                style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label:
                Text('quantity'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('price'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('total price'.tr(),
                style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('paid'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label:
                Text('remaining'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('total balance'.tr(),
                style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('control'.tr(), style: TextStyles.font14BlackSemiBold)),
      ],
      source: source,
      columnSpacing: 25.w,
      horizontalMargin: 10.w,
      rowsPerPage: 5,
    );
  }

  Widget showProgressIndecator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: AppCustomLoadingIndecator());
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) => alertDialog);
    return alertDialog;
  }

  void newOrder() {
    if (BlocProvider.of<DailyPurchasesCubit>(context)
        .newOrderFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<DailyPurchasesCubit>(context)
          .newOrderFormKey
          .currentState!
          .save();

      BlocProvider.of<DailyPurchasesCubit>(context).addNewOrderCubit();

      // BlocProvider.of<DailyPurchasesCubit>(context).init();
    }
  }
}
