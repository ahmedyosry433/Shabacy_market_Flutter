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
import '../../data/model/user_model.dart';
import '../../logic/cubit/users_cubit.dart';

class EditiAndDeleteUsersButton extends StatefulWidget {
  final UserModel user;
  const EditiAndDeleteUsersButton({required this.user, super.key});

  @override
  State<EditiAndDeleteUsersButton> createState() =>
      _EditiAndDeleteUsersButtonState();
}

class _EditiAndDeleteUsersButtonState extends State<EditiAndDeleteUsersButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                BlocProvider.of<UsersCubit>(context).editNameController.text =
                    widget.user.name;

                BlocProvider.of<UsersCubit>(context).editEmailController.text =
                    widget.user.email;
                BlocProvider.of<UsersCubit>(context).editDropdownValue =
                    widget.user.role;
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
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Form(
                                      key: BlocProvider.of<UsersCubit>(context)
                                          .editUserFormKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('edite user'.tr(),
                                              style: TextStyles
                                                  .font20BlackRegular),
                                          verticalSpace(10.h),
                                          AppTextFormFieldWithTopHint(
                                            topHintText: 'name'.tr(),
                                            appTextFormField: AppTextFormField(
                                              controller:
                                                  BlocProvider.of<UsersCubit>(
                                                          context)
                                                      .editNameController,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 9.h,
                                                      horizontal: 10.w),
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
                                              controller:
                                                  BlocProvider.of<UsersCubit>(
                                                          context)
                                                      .editEmailController,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 9.h,
                                                      horizontal: 10.w),
                                              hintText: 'enterEmail'.tr(),
                                              validator: (validator) {
                                                if (validator!.isEmpty ||
                                                    validator.length < 7) {
                                                  return 'enterValidEmail'.tr();
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                          ),
                                          verticalSpace(10.h),
                                          AppCustomDropdownWithTopHint(
                                            topHintText: 'typeOfUser'.tr(),
                                            appCustomDropdown:
                                                AppCustomDropDownFormButton(
                                              hintText:
                                                  Text('selectTypeOfUser'.tr()),
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
                                              onChanged: (value) {
                                                setState(() {
                                                  context
                                                          .read<UsersCubit>()
                                                          .editDropdownValue =
                                                      value;
                                                });
                                              },
                                              value:
                                                  BlocProvider.of<UsersCubit>(
                                                          context)
                                                      .editDropdownValue,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'selectTypeOfUser'
                                                      .tr();
                                                }
                                              },
                                            ),
                                          ),
                                          verticalSpace(20),
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
                                                    editUserSubmit();
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
                            widget.user.name,
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
                            deleteUserSubmit();
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

  void editUserSubmit() {
    if (BlocProvider.of<UsersCubit>(context)
        .editUserFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<UsersCubit>(context).editUserFormKey.currentState!.save();
      BlocProvider.of<UsersCubit>(context)
          .editUserCubit(userId: widget.user.id);
    }
  }

  void deleteUserSubmit() {
    context.read<UsersCubit>().deleteUserCubit(userId: widget.user.id);
  }
}
