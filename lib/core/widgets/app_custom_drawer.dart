import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          padding: EdgeInsets.only(top: 50.h),
          child: ListView(
            children: [
              ListTile(
                titleTextStyle:
                    const TextStyle(fontSize: 20, color: Colors.black),
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
                    Navigator.pushNamed(context, Routes.profileScreen);
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
