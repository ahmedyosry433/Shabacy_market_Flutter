import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_custom_appbar.dart';
import '../../../core/widgets/app_progress_indecator.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/app_text_form_field_with_hint.dart';
import '../logic/cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getUserProfile();
  }

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
                        TextStyles.font11BlackSemiBold.copyWith(fontSize: 0)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: ColorsManager.white,
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                  height: 500.h,
                  width: 300.w,
                  child: Stack(clipBehavior: Clip.none, children: [
                    Positioned(
                        top: -35.h,
                        left: 120.w,
                        child: SizedBox(
                          height: 70.h,
                          width: 70.w,
                          child: const CircleAvatar(),
                        )),
                    buildProfileForm(),
                  ]),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildProfileForm() {
    final currentUser = context.watch<ProfileCubit>().currentUser;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const AppShowProgressIndecator();
        } else if (state is ProfileLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
            child: Form(
              child: Column(
                children: [
                  AppTextFormFieldWithTopHint(
                    topHintText: 'name'.tr(),
                    appTextFormField: AppTextFormField(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                      hintText: currentUser.name,
                      validator: (validator) {},
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  verticalSpace(20),
                  AppTextFormFieldWithTopHint(
                    topHintText: 'email'.tr(),
                    appTextFormField: AppTextFormField(
                      readOnly: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                      hintText: currentUser.email,
                      validator: (validator) {},
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  verticalSpace(20),
                  AppTextFormFieldWithTopHint(
                    topHintText: 'role'.tr(),
                    appTextFormField: AppTextFormField(
                      enable: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                      hintText: currentUser.role.tr(),
                      validator: (validator) {},
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Text(state.errorMsg);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
