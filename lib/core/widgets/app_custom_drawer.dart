// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/Home/logic/cubit/home_cubit.dart';
import '../router/routes.dart';
import '../theme/colors.dart';
import '../theme/style.dart';

class AppCustomDrawer extends StatelessWidget {
  const AppCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 210.w,
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                    '${'hello'.tr()}, ${context.read<HomeCubit>().currentUser!.name}',
                    style: TextStyles.font14BlueSemiBold),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 40.w),
                  child: Text(
                    'nice day'.tr(),
                    style: TextStyles.font14GrayMedium,
                  )),
              Divider(),
              ListTile(
                leading: const Icon(Icons.person_2_outlined),
                title: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profileScreen);
                  },
                  child: Text(
                    'profile'.tr(),
                    style: TextStyles.font16BlackRegular,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: ColorsManager.red,
                ),
                title: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
                  child: Text(
                    'logout'.tr(),
                    style: TextStyles.font16RedRegular,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
