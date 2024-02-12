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
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 400.h,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Form(
                              key: BlocProvider.of<UsersCubit>(context)
                                  .editUserFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('addUser'.tr(),
                                      style: TextStyles.font20BlackRegular),
                                  verticalSpace(10.h),
                                  AppTextFormFieldWithTopHint(
                                    topHintText: 'name'.tr(),
                                    appTextFormField: AppTextFormField(
                                      controller:
                                          BlocProvider.of<UsersCubit>(context)
                                              .editNameController,
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
                                      controller:
                                          BlocProvider.of<UsersCubit>(context)
                                              .editEmailController,
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
                                  AppTextFormFieldWithTopHint(
                                    topHintText: 'phone'.tr(),
                                    appTextFormField: AppTextFormField(
                                      controller:
                                          BlocProvider.of<UsersCubit>(context)
                                              .editPhoneController,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 9.h, horizontal: 10.w),
                                      hintText: 'enterPhone'.tr(),
                                      validator: (validator) {
                                        if (validator!.isEmpty ||
                                            validator.length < 10) {
                                          return 'enterValidPhone'.tr();
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
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
                                      onChanged: (value) {
                                        setState(() {
                                          context
                                              .read<UsersCubit>()
                                              .editDropdownValue = value;
                                        });
                                      },
                                      value:
                                          BlocProvider.of<UsersCubit>(context)
                                              .editDropdownValue,
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
                                            editUserSubmit();
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
                            context
                                .read<UsersCubit>()
                                .deleteUserCubit(userId: widget.user.id);
                            context.read<UsersCubit>().getAllUsersCubit();
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

  editUserSubmit() {
    if (BlocProvider.of<UsersCubit>(context)
        .editUserFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<UsersCubit>(context).editUserFormKey.currentState!.save();
      context.read<UsersCubit>().editUserCubit(userId: widget.user.id);
      context.read<UsersCubit>().getAllUsersCubit();
      context.pop();
    }
  }
}
