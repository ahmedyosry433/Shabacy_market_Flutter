import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';

import '../helper/spacing.dart';
import '../router/routes.dart';
import '../theme/colors.dart';
import '../theme/style.dart';

class AppCustomAppbar extends StatelessWidget {
  AppCustomAppbar({super.key, this.profileStyle, this.homeStyle});
  TextStyle? profileStyle;
  TextStyle? homeStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 70.h,
      color: ColorsManager.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('bussnisName'.tr(), style: TextStyles.font16BlackSemiBold),
        Row(
          children: [
            GestureDetector(
                onTap: () => context.pushNamed(Routes.homeScreen),
                child: Text('home'.tr(),
                    style: homeStyle ?? TextStyles.font14GrayMedium)),
            horizontalSpace(10),
            GestureDetector(
                onTap: () => context.pushNamed(Routes.profileScreen),
                child: Text('profile'.tr(),
                    style: profileStyle ?? TextStyles.font14GrayMedium)),
            horizontalSpace(10),
            Text('logout'.tr(),
                style: TextStyles.font14GrayMedium
                    .copyWith(color: ColorsManager.primryColor.shade300)),
          ],
        ),
      ]),
    );
  }
}
