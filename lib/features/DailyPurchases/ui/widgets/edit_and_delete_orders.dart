import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/extensions.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/widgets/app_custom_dropdown.dart';
import '../../../../core/widgets/app_custom_dropdwo_with_hint.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/app_text_form_field_with_hint.dart';
import '../../data/model/daily_purchases_model.dart';
import '../../logic/cubit/daily_purchases_cubit.dart';

class EditiAndDeleteOrderButton extends StatefulWidget {
  final GetDailyPurchasesModel order;
  final int index;
  const EditiAndDeleteOrderButton(
      {required this.order, required this.index, super.key});

  @override
  State<EditiAndDeleteOrderButton> createState() =>
      _EditiAndDeleteOrderButtonState();
}

class _EditiAndDeleteOrderButtonState extends State<EditiAndDeleteOrderButton> {
  @override
  Widget build(BuildContext context) {
    final blocRead = context.read<DailyPurchasesCubit>();
    final blocWatch = context.watch<DailyPurchasesCubit>();
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                blocRead.editselectDate = blocRead.selectDate;
                blocRead.editDateController.text =
                    blocRead.formatting.format(blocRead.editselectDate!);
                blocRead.editDropdownSupplierValue = widget.order.supplierId;

                blocRead.editPriceController.text =
                    widget.order.price.toString();
                blocRead.editQuantityController.text =
                    widget.order.quantity.toString();
                blocRead.editPaidController.text = widget.order.paid.toString();

                blocRead.editRemainsController.text =
                    (widget.order.total - widget.order.paid).toString();
                blocRead.editTotalController.text =
                    (widget.order.price * widget.order.quantity).toString();
              });
              showDialog(
                  context: context,
                  builder: (_) => Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 30.h, right: 10.w, left: 10.w),
                          child: Material(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            child: SizedBox(
                              height: 400.h,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: Form(
                                    key: blocRead.editOrderFormKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('edit order'.tr(),
                                            style:
                                                TextStyles.font20BlackRegular),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                            topHintText: 'day'.tr(),
                                            appTextFormField: AppTextFormField(
                                              readOnly: true,
                                              controller: context
                                                  .read<DailyPurchasesCubit>()
                                                  .editDateController,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  final now = DateTime.now();
                                                  final firstDate =
                                                      DateTime(now.year - 2);
                                                  final lastDate =
                                                      DateTime(now.year + 2);
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate: BlocProvider
                                                                  .of<DailyPurchasesCubit>(
                                                                      context)
                                                              .editselectDate!,
                                                          firstDate: firstDate,
                                                          lastDate: lastDate)
                                                      .then(
                                                    (value) {
                                                      setState(() {
                                                        if (value != null &&
                                                            value !=
                                                                blocRead
                                                                    .editselectDate) {
                                                          blocRead.editselectDate =
                                                              value;
                                                          blocRead.editDateController
                                                                  .text =
                                                              blocRead
                                                                  .formatting
                                                                  .format(value)
                                                                  .toString();
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
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText: '',
                                              validator: (validator) {},
                                              keyboardType: TextInputType.name,
                                            )),
                                        verticalSpace(10.h),
                                        AppCustomDropdownWithTopHint(
                                            topHintText: 'customer'.tr(),
                                            appCustomDropdown:
                                                AppCustomDropDownFormButton(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText:
                                                  Text('select customer'.tr()),
                                              items:
                                                  blocRead.suppliers.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.id,
                                                  child: Text(e.name),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  blocRead.editDropdownSupplierValue =
                                                      value;
                                                });
                                              },
                                              validator: (vaild) {
                                                if (vaild == null ||
                                                    vaild == '') {
                                                  return 'select customer'.tr();
                                                }
                                              },
                                              value: blocRead
                                                  .editDropdownSupplierValue,
                                            )),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                            topHintText: 'unit price'.tr(),
                                            appTextFormField: AppTextFormField(
                                              onChanged: (price) {
                                                setState(() {
                                                  blocRead.editTotalController
                                                      .text = (int.parse(
                                                              price) *
                                                          int.parse(blocRead
                                                              .editQuantityController
                                                              .text))
                                                      .toString();
                                                });
                                              },
                                              controller:
                                                  blocRead.editPriceController,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText: 'enter unit price'.tr(),
                                              validator: (validator) {
                                                if (validator!.isEmpty) {
                                                  return 'enter unit price'
                                                      .tr();
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                            )),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                            topHintText: 'quantity'.tr(),
                                            appTextFormField: AppTextFormField(
                                              onChanged: (quantity) {
                                                setState(() {
                                                  blocRead.editTotalController
                                                      .text = (int.parse(
                                                              quantity) *
                                                          int.parse(blocRead
                                                              .editPriceController
                                                              .text))
                                                      .toString();
                                                });
                                              },
                                              controller: blocRead
                                                  .editQuantityController,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText: 'enter quantity'.tr(),
                                              validator: (validator) {
                                                if (validator!.isEmpty) {
                                                  return 'enter quantity'.tr();
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                            )),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                            topHintText: 'total purchases'.tr(),
                                            appTextFormField: AppTextFormField(
                                              controller:
                                                  blocWatch.editTotalController,
                                              readOnly: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText: '',
                                              validator: (validator) {},
                                              keyboardType: TextInputType.name,
                                            )),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                            topHintText: 'paid'.tr(),
                                            appTextFormField: AppTextFormField(
                                              onChanged: (paid) {
                                                setState(() {
                                                  blocRead.editRemainsController
                                                      .text = (int.parse(blocRead
                                                              .editTotalController
                                                              .text) -
                                                          int.parse(paid))
                                                      .toString();
                                                });
                                              },
                                              controller:
                                                  blocRead.editPaidController,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText: 'enter paid'.tr(),
                                              validator: (validator) {
                                                if (validator!.isEmpty) {
                                                  return 'enter paid'.tr();
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                            )),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                            topHintText: 'remaining'.tr(),
                                            appTextFormField: AppTextFormField(
                                              controller: blocWatch
                                                  .editRemainsController,
                                              readOnly: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.h,
                                                      horizontal: 10.w),
                                              hintText: '',
                                              validator: (validator) {},
                                              keyboardType: TextInputType.name,
                                            )),
                                        verticalSpace(10.h),
                                        Row(
                                          children: [
                                            AppTextButton(
                                                backgroundColor:
                                                    ColorsManager.red,
                                                verticalPadding: 0,
                                                horizontalPadding: 0,
                                                buttonHeight: 30.h,
                                                buttonWidth: 60.w,
                                                buttonText: 'cancel'.tr(),
                                                textStyle: TextStyles
                                                    .font13WhiteSemiBold,
                                                onPressed: () {
                                                  context.pop();
                                                }),
                                            horizontalSpace(10),
                                            AppTextButton(
                                                verticalPadding: 0,
                                                horizontalPadding: 0,
                                                buttonHeight: 30.h,
                                                buttonWidth: 60.w,
                                                buttonText: 'edit'.tr(),
                                                textStyle: TextStyles
                                                    .font13WhiteSemiBold,
                                                onPressed: () {
                                                  editOrderSubmit();
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
            },
            child: const Icon(Icons.edit, color: ColorsManager.primryColor)),
        horizontalSpace(10),
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'sureDelete'.tr(),
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      content: Row(
                        children: [
                          Text(
                            '${'are you sure delete order'.tr()} ',
                            style: TextStyles.font14BlackMedium,
                          ),
                          Text(
                            'nummber'.tr() + widget.index.toString(),
                            style: TextStyles.font14RedMedium,
                          ),
                          Text(
                            '?'.tr(),
                            style: TextStyles.font14BlackMedium,
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            'cancel'.tr(),
                            style: TextStyles.font14BlackMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteOrderSubmit();
                          },
                          child: Text(
                            'yes'.tr(),
                            style: TextStyles.font14RedMedium,
                          ),
                        )
                      ],
                    );
                  });
            },
            child: const Icon(Icons.delete, color: ColorsManager.red)),
      ],
    );
  }

  Widget showProgressIndecator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          color: ColorsManager.black,
          valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) => alertDialog);
    return alertDialog;
  }

  void editOrderSubmit() {
    if (BlocProvider.of<DailyPurchasesCubit>(context)
        .editOrderFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<DailyPurchasesCubit>(context)
          .editOrderFormKey
          .currentState!
          .save();
      BlocProvider.of<DailyPurchasesCubit>(context)
          .editOrderCubit(orderId: widget.order.orderId);
    }
  }

  void deleteOrderSubmit() {
    context
        .read<DailyPurchasesCubit>()
        .deleteOrderCubit(orderId: widget.order.orderId);
  }
}
