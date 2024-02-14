// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/widgets/app_custom_dropdown.dart';
import '../../../../core/widgets/app_custom_dropdwo_with_hint.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/app_text_form_field_with_hint.dart';
import '../../data/models/suppliers_model.dart';
import '../../logic/cubit/suppliers_cubit.dart';

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
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 800.h,
                        child: buildEditSupplier(context),
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
                            widget.supplierModel.name,
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
                            context.read<SuppliersCubit>().deleteSupplierCubit(
                                suppliersId: widget.supplierModel.id);
                            BlocProvider.of<SuppliersCubit>(context)
                                .getAllSuppliersCubit();
                            context.pop();
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                      context.read<SuppliersCubit>().dropdownEditValue = value;
                    });
                  },
                  items: BlocProvider.of<SuppliersCubit>(context)
                      .users
                      .map((value) {
                    return DropdownMenuItem<String>(
                      value: value.id.toString(),
                      child: Text(value.name),
                    );
                  }).toList(),
                  value: BlocProvider.of<SuppliersCubit>(context)
                      .dropdownEditValue,
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

  editSuppliers() {
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

      BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();

      context.pop();
    }
  }
}