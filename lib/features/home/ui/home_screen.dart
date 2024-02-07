import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/theme/colors.dart';
import 'package:shabacy_market/core/widgets/app_custom_appbar.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppCustomAppbar(
              homeStyle: TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              child: Column(
                children: [
                  buildCart(
                      onTap: () {},
                      title: 'suppliers',
                      iconPath: 'assets/image/suppliers.png'),
                  buildCart(
                      onTap: () {},
                      title: 'DailyPurchases',
                      iconPath: 'assets/image/purchasing.png'),
                  buildCart(
                      onTap: () {},
                      title: 'users',
                      iconPath: 'assets/image/users.png'),
                  buildCart(
                      onTap: () {},
                      title: 'items',
                      iconPath: 'assets/image/items.png'),
                  buildCart(
                      onTap: () {},
                      title: 'weeklyReport',
                      iconPath: 'assets/image/reports.png'),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget coustomAppbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 70.h,
      color: ColorsManager.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('bussnisName'.tr(), style: TextStyles.font16BlackSemiBold),
        Row(
          children: [
            Text('home'.tr(), style: TextStyles.font14GrayMedium),
            horizontalSpace(10),
            GestureDetector(
                onTap: () => context.pushNamed(Routes.profileScreen),
                child:
                    Text('profile'.tr(), style: TextStyles.font14GrayMedium)),
            horizontalSpace(10),
            Text('logout'.tr(),
                style: TextStyles.font14GrayMedium
                    .copyWith(color: ColorsManager.primryColor.shade300)),
          ],
        ),
      ]),
    );
  }

  Widget buildCart(
      {required String title,
      required String iconPath,
      required Function onTap}) {
    return GestureDetector(
      onTap: onTap(),
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        color: ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: SizedBox(
          width: 288.w,
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 50.h,
                width: 50.w,
                color: ColorsManager.primryColor,
              ),
              Text(
                title.tr(),
                style: TextStyles.font20BlackRegular,
              )
            ],
          ),
        ),
      ),
    );
  }
}
