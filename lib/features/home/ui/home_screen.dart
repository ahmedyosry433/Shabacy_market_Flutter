import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.suppliersScreen),
                    child: buildCart(
                        title: 'suppliers',
                        iconPath: 'assets/image/suppliers.png'),
                  ),
                  buildCart(
                      title: 'DailyPurchases',
                      iconPath: 'assets/image/purchasing.png'),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.usersScreen),
                    child: buildCart(
                        title: 'users', iconPath: 'assets/image/users.png'),
                  ),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.categoriesScreen),
                      child: buildCart(
                          title: 'items', iconPath: 'assets/image/items.png')),
                  buildCart(
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

  Widget buildCart({
    required String title,
    required String iconPath,
  }) {
    return Card(
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
    );
  }
}
