import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

class EditiAndDeleteOrderButton extends StatefulWidget {
  final GetDailyPurchasesModel order;
  const EditiAndDeleteOrderButton({required this.order, super.key});

  @override
  State<EditiAndDeleteOrderButton> createState() =>
      _EditiAndDeleteOrderButtonState();
}

class _EditiAndDeleteOrderButtonState extends State<EditiAndDeleteOrderButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 400.h,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('edite user'.tr(),
                                      style: TextStyles.font20BlackRegular),
                                  verticalSpace(10.h),
                                  AppTextFormFieldWithTopHint(
                                    topHintText: 'name'.tr(),
                                    appTextFormField: AppTextFormField(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 9.h, horizontal: 10.w),
                                      hintText: 'enterName'.tr(),
                                      validator: (validator) {
                                        if (validator!.isEmpty ||
                                            validator.length < 3) {
                                          return 'enterValidName'.tr();
                                        }
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  verticalSpace(10.h),
                                  AppTextFormFieldWithTopHint(
                                    topHintText: 'email'.tr(),
                                    appTextFormField: AppTextFormField(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 9.h, horizontal: 10.w),
                                      hintText: 'enterEmail'.tr(),
                                      validator: (validator) {
                                        if (validator!.isEmpty ||
                                            validator.length < 10) {
                                          return 'enterValidEmail'.tr();
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  verticalSpace(10.h),
                                  AppCustomDropdownWithTopHint(
                                    topHintText: 'typeOfUser'.tr(),
                                    appCustomDropdown:
                                        AppCustomDropDownFormButton(
                                      hintText: Text('selectTypeOfUser'.tr()),
                                      items: [
                                        DropdownMenuItem(
                                          value: 'SUPER_ADMIN',
                                          child: Text(
                                            'SUPER_ADMIN'.tr(),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'ADMIN',
                                          child: Text(
                                            'ADMIN'.tr(),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'EMPLOYEE',
                                          child: Text(
                                            'EMPLOYEE'.tr(),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value == null) {
                                          return 'selectTypeOfUser'.tr();
                                        }
                                      },
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
                                          textStyle:
                                              TextStyles.font13WhiteSemiBold,
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
                                          textStyle:
                                              TextStyles.font13WhiteSemiBold,
                                          onPressed: () {
                                            // editUserSubmit();
                                          }),
                                    ],
                                  )
                                ],
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
                            widget.order.supplierName,
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
                            // deleteUserSubmit();
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

  // void editUserSubmit() {
  //   if (BlocProvider.of<UsersCubit>(context)
  //       .editUserFormKey
  //       .currentState!
  //       .validate()) {
  //     BlocProvider.of<UsersCubit>(context).editUserFormKey.currentState!.save();
  //     BlocProvider.of<UsersCubit>(context)
  //         .editUserCubit(userId: widget.user.id);
  //   }
  // }

  // void deleteUserSubmit() {
  //   context.read<UsersCubit>().deleteUserCubit(userId: widget.user.id);
  // }
}