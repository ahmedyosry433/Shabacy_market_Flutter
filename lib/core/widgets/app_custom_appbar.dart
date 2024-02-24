// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';

import '../helper/shared_preferences_helper.dart';
import '../helper/spacing.dart';
import '../router/routes.dart';
import '../theme/colors.dart';
import '../theme/style.dart';

class AppCustomAppbar extends StatelessWidget {
  AppCustomAppbar({
    super.key,
    required this.isHome,
  });
  bool isHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 110.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorsManager.lightPrimryColor, ColorsManager.white]),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
            onTap: () => isHome ? null : context.pushNamed(Routes.homeScreen),
            child: Row(
              children: [
                Image.asset('assets/image/logo_without_background_and_name.png',
                    height: 45.h, width: 45.w),
                horizontalSpace(5),
                Text('bussnisName'.tr(), style: TextStyles.font13BlackSemiBold),
              ],
            ),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: ColorsManager.primryColor, width: 0.5),
                color: ColorsManager.white),
            child: isHome
                ? IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu_rounded,
                        color: ColorsManager.primryColor))
                : IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_forward,
                        color: ColorsManager.primryColor)),
          ),
        ]),
      ),
    );
  }
}
