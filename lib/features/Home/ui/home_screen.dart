import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/widgets/app_custom_drawer.dart';
import 'package:shabacy_market/features/Home/logic/cubit/home_cubit.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/app_coustom_loading_indecator.dart';
import '../../../core/widgets/app_custom_appbar.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppCustomDrawer(
       
      ),
      backgroundColor: ColorsManager.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppCustomAppbar(
              isHome: true,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const AppCustomLoadingIndecator();
                } else if (state is HomeLoaded) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.suppliersScreen),
                          child: buildCart(
                              title: 'suppliers',
                              iconPath: 'assets/image/suppliers.png'),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(Routes.dailyPurchasesScreen),
                          child: buildCart(
                              title: 'DailyPurchases',
                              iconPath: 'assets/image/purchasing.png'),
                        ),
                        state.currentUser.role == 'SUPER_ADMIN' ||
                                state.currentUser.role == 'ADMIN'
                            ? GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.usersScreen),
                                child: buildCart(
                                    title: 'users',
                                    iconPath: 'assets/image/users.png'),
                              )
                            : const SizedBox.shrink(),
                        state.currentUser.role == 'SUPER_ADMIN' ||
                                state.currentUser.role == 'ADMIN'
                            ? GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.categoriesScreen),
                                child: buildCart(
                                    title: 'items',
                                    iconPath: 'assets/image/items.png'))
                            : const SizedBox.shrink(),
                        state.currentUser.role == 'SUPER_ADMIN' ||
                                state.currentUser.role == 'ADMIN'
                            ? GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.weeklyReportScreen),
                                child: buildCart(
                                    title: 'weeklyReport',
                                    iconPath: 'assets/image/reports.png'),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                } else if (state is HomeError) {
                  return Text(state.errorMsg);
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
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
