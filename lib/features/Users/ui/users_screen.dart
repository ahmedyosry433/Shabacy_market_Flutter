import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../core/helper/extensions.dart';
import '../../../core/widgets/app_custom_appbar.dart';
import '../logic/cubit/users_cubit.dart';
import 'widgets/set_users_table.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_custom_dropdown.dart';
import '../../../core/widgets/app_custom_dropdwo_with_hint.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/app_text_form_field_with_hint.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    BlocProvider.of<UsersCubit>(context).getAllUsersCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataTableSource data = MyData(
      context.watch<UsersCubit>().users,
    );
    return Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppCustomAppbar(
              profileStyle:
                  TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
            ),
            buildAddNewUserAndTextButton(),
            buildAddNewUsersLisenerBloc(),
            BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is UsersLoading) {
                  return Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is UsersLoaded) {
                  return buildUsersTable(source: data);
                } else if (state is UsersError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            buildEditUsersBloc(),
            buildDeleteUsersBloc(),
          ],
        ),
      ),
    );
  }

  Widget buildAddNewUserAndTextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('usersList'.tr(), style: TextStyles.font16BlackSemiBold),
          AppTextButton(
              buttonHeight: 40.h,
              buttonWidth: 100.w,
              backgroundColor: ColorsManager.primryColor,
              buttonText: 'addUser'.tr(),
              textStyle: TextStyles.font13WhiteSemiBold,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => SizedBox(
                          height: 400.h,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: buildFormAddNewUser(),
                            ),
                          ),
                        ));
              })
        ],
      ),
    );
  }

  Widget buildFormAddNewUser() {
    return Form(
      key: BlocProvider.of<UsersCubit>(context).addNewUserFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('addUser'.tr(), style: TextStyles.font20BlackRegular),
          verticalSpace(10.h),
          AppTextFormFieldWithTopHint(
            topHintText: 'name'.tr(),
            appTextFormField: AppTextFormField(
              controller: BlocProvider.of<UsersCubit>(context).nameController,
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
            topHintText: 'email'.tr(),
            appTextFormField: AppTextFormField(
              controller: BlocProvider.of<UsersCubit>(context).emailController,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
              hintText: 'enterEmail'.tr(),
              validator: (validator) {
                if (validator!.isEmpty || validator.length < 10) {
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
              controller: BlocProvider.of<UsersCubit>(context).phoneController,
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
          AppTextFormFieldWithTopHint(
            topHintText: 'password'.tr(),
            appTextFormField: AppTextFormField(
              controller:
                  BlocProvider.of<UsersCubit>(context).passwordController,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
              hintText: 'enterPassword'.tr(),
              validator: (validator) {},
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          verticalSpace(10.h),
          AppCustomDropdownWithTopHint(
            topHintText: 'typeOfUser'.tr(),
            appCustomDropdown: AppCustomDropDownFormButton(
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
                  context.read<UsersCubit>().dropdownValue = value;
                });
              },
              value: BlocProvider.of<UsersCubit>(context).dropdownValue,
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
                    saveAddUser();
                  }),
            ],
          )
        ],
      ),
    );
  }

  Widget buildUsersTable({required DataTableSource source}) {
    return PaginatedDataTable(
      arrowHeadColor: ColorsManager.primryColor,
      columns: [
        DataColumn(
            label: Text('id'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('name'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('email'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label:
                Text('typeOfUser'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('control'.tr(), style: TextStyles.font14BlackSemiBold)),
      ],
      source: source,
      columnSpacing: 45.w,
      horizontalMargin: 20.w,
      rowsPerPage: 6,
    );
  }

  Widget buildAddNewUsersLisenerBloc() {
    return BlocListener<UsersCubit, UsersState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AddUsersLoading) {
          showProgressIndecator(context);
        } else if (state is AddUsersLoaded) {
          context.pop();
          BlocProvider.of<UsersCubit>(context).getAllUsersCubit();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "add user successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          context.pop();
        } else if (state is AddUsersError) {
          context.pop();

          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error adding user ".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
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

  saveAddUser() {
    if (BlocProvider.of<UsersCubit>(context)
        .addNewUserFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<UsersCubit>(context)
          .addNewUserFormKey
          .currentState!
          .save();
      BlocProvider.of<UsersCubit>(context).addUsersRegisterCubit();
    }
  }

  Widget buildEditUsersBloc() {
    return BlocListener<UsersCubit, UsersState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is EditUsersLoading) {
          showProgressIndecator(context);
        } else if (state is EditUsersLoaded) {
          Navigator.of(context).pop();
          BlocProvider.of<UsersCubit>(context).getAllUsersCubit();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "edit user successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          Navigator.of(context).pop();
        } else if (state is EditUsersError) {
          Navigator.of(context).pop();

          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error editing user ".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget buildDeleteUsersBloc() {
    return BlocListener<UsersCubit, UsersState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is DeleteUsersLoading) {
          showProgressIndecator(context);
        } else if (state is DeleteUsersLoaded) {
          context.pop();
          BlocProvider.of<UsersCubit>(context).getAllUsersCubit();
          MotionToast.success(
            position: MotionToastPosition.top,
            iconSize: 30.w,
            width: 500.w,
            height: 80.h,
            description: Row(
              children: [
                Text(
                  "delete user successfully".tr(),
                  style: TextStyles.font14BlackSemiBold,
                ),
                Text(
                  '',
                  style: TextStyles.font14RedMedium,
                ),
              ],
            ),
          ).show(context);
          context.pop();
        } else if (state is DeleteUsersError) {
          context.pop();
          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error deleting user ".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
