// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/features/Suppliers/data/models/suppliers_model.dart';
import 'package:shabacy_market/features/Suppliers/logic/cubit/suppliers_cubit.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/widgets/app_custom_dropdown.dart';
import '../../../../core/widgets/app_custom_dropdwo_with_hint.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/app_text_form_field_with_hint.dart';

class SuppliersEditAndDeleteButton extends StatefulWidget {
  SuppliersEditAndDeleteButton({required this.supplierModel, super.key});
  SuppliersModel supplierModel;

  @override
  State<SuppliersEditAndDeleteButton> createState() =>
      _SuppliersEditAndDeleteButtonState();
}

class _SuppliersEditAndDeleteButtonState
    extends State<SuppliersEditAndDeleteButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                context.read<SuppliersCubit>().editNameController.text =
                    widget.supplierModel.name;
                context.read<SuppliersCubit>().editPhoneController.text =
                    widget.supplierModel.mobile;

                context.read<SuppliersCubit>().dropdownEditValue =
                    widget.supplierModel.adminId.toString();
              });
              showDialog(
                  context: context,
                  builder: (_) => Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 30.h, right: 10.w, left: 10.w),
                            child: Material(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: SizedBox(
                                child: buildEditSupplier(
                                  context,
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
                            '${'areYouSureDelete'.tr()} ',
                            style: TextStyles.font14BlackMedium,
                          ),
                          Text(
                            widget.supplierModel.name.substring(0, 7),
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
                            deleteSuppliers();
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

  Widget buildEditSupplier(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Form(
          key: BlocProvider.of<SuppliersCubit>(context).editSupplierFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('editeSupplier'.tr(), style: TextStyles.font20BlackRegular),
              verticalSpace(10.h),
              AppTextFormFieldWithTopHint(
                topHintText: 'name'.tr(),
                appTextFormField: AppTextFormField(
                  controller: context.read<SuppliersCubit>().editNameController,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  hintText: 'enterName'.tr(),
                  validator: (validator) {
                    if (validator!.isEmpty || validator.length < 3) {
                      return 'enterValidName'.tr();
                    }
                  },
                  keyboardType: TextInputType.name,
                ),
              ),
              verticalSpace(10.h),
              AppTextFormFieldWithTopHint(
                topHintText: 'phone'.tr(),
                appTextFormField: AppTextFormField(
                  controller:
                      context.read<SuppliersCubit>().editPhoneController,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  hintText: 'enterPhone'.tr(),
                  validator: (validator) {
                    if (validator!.isEmpty || validator.length < 10) {
                      return 'enterValidPhone'.tr();
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
              verticalSpace(10.h),
              AppCustomDropdownWithTopHint(
                topHintText: 'delegate'.tr(),
                appCustomDropdown: AppCustomDropDownFormButton(
                  validator: (validator) {
                    if (validator == null) {
                      return 'selectDelegate'.tr();
                    }
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  onChanged: (value) {
                    setState(() {
                      BlocProvider.of<SuppliersCubit>(context)
                          .dropdownEditValue = value;
                    });
                  },
                  items: BlocProvider.of<SuppliersCubit>(context)
                      .users
                      .map((value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Row(
                        children: [
                          Icon(Icons.check_sharp,
                              color: BlocProvider.of<SuppliersCubit>(context)
                                          .dropdownEditValue ==
                                      value.id
                                  ? Colors.green
                                  : Colors
                                      .transparent), // Icon when item is selected
                          const SizedBox(width: 8),
                          BlocProvider.of<SuppliersCubit>(context)
                                      .dropdownEditValue ==
                                  value.id
                              ? Text(
                                  value.name,
                                  style: TextStyles.font11BlackSemiBold,
                                )
                              : Text(value.name),
                        ],
                      ),
                    );
                  }).toList(),
                  value: BlocProvider.of<SuppliersCubit>(context)
                      .dropdownEditValue,
                ),
              ),
              verticalSpace(20),
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
                      buttonText: 'edit'.tr(),
                      textStyle: TextStyles.font13WhiteSemiBold,
                      onPressed: () => editSuppliers()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void editSuppliers() {
    if (BlocProvider.of<SuppliersCubit>(context)
        .editSupplierFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<SuppliersCubit>(context)
          .editSupplierFormKey
          .currentState!
          .save();
      BlocProvider.of<SuppliersCubit>(context).editeSupplierCubit(
          suppliersId: widget.supplierModel.id,
          adminId: context.read<SuppliersCubit>().dropdownEditValue);
    }
  }

  void deleteSuppliers() {
    context
        .read<SuppliersCubit>()
        .deleteSupplierCubit(suppliersId: widget.supplierModel.id);
  }
}
