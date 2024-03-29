import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/features/Profile/logic/cubit/profile_cubit.dart';
import 'package:shabacy_market/features/Users/data/model/user_model.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/app_coustom_loading_indecator.dart';
import '../../../core/widgets/app_custom_appbar.dart';
import '../../../core/widgets/app_custom_no_internet.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/app_text_form_field_with_hint.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManager.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppCustomAppbar(
                isHome: false,
              ),
              OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return buildProfileFormWithBlocBuilder();
                  } else {
                    return const AppCustomNoInternet();
                  }
                },
                child: const AppCustomLoadingIndecator(),
              ),
            ],
          ),
        ));
  }

  Widget buildProfileFormWithBlocBuilder() {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return const AppCustomLoadingIndecator();
      } else if (state is ProfileLoaded) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: ColorsManager.white,
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          height: 500.h,
          width: 300.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: -35.h,
                  left: 120.w,
                  child: SizedBox(
                    height: 70.h,
                    width: 70.w,
                    child: const CircleAvatar(),
                  )),
              buildProfileForm(state.userProfile),
            ],
          ),
        );
      } else if (state is ProfileError) {
        return Text(state.errorMsg);
      }
      return const SizedBox.shrink();
    });
  }

  Widget buildProfileForm(UserModel currentUser) {
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
  }
}
