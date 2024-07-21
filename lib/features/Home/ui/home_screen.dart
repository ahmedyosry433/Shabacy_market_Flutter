import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/widgets/app_custom_drawer.dart';
import 'package:shabacy_market/features/Home/logic/cubit/home_cubit.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/app_coustom_loading_indecator.dart';
import '../../../core/widgets/app_custom_appbar.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_custom_no_internet.dart';

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
      drawer: const AppCustomDrawer(),
      backgroundColor: ColorsManager.backGroundColor,
      body: Column(
        children: [
          AppCustomAppbar(isHome: true),
          OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return buildHomeScreenCards();
              } else {
                return const AppCustomNoInternet();
              }
            },
            child: const AppCustomLoadingIndecator(),
          ),
        ],
      ),
    );
  }

  Widget buildCart(
      {required String title,
      required String iconPath,
      TextStyle? titleStyle,
      EdgeInsetsGeometry? margin}) {
    return Card(
      margin: margin,
      elevation: 0.5,
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
              height: 60.h,
              width: 60.w,
              color: ColorsManager.primryColor,
            ),
            verticalSpace(10.h),
            Text(
              title.tr(),
              style: titleStyle ?? TextStyles.font18BlackRegular,
            )
          ],
        ),
      ),
    );
  }

  Widget buildHomeScreenCards() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const AppCustomLoadingIndecator();
        } else if (state is HomeLoaded) {
          return state.currentUser.role == 'SUPER_ADMIN' ||
                  state.currentUser.role == 'ADMIN'
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: GridView.count(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
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
                              Navigator.pushNamed(context, Routes.payment),
                          child: buildCart(
                              title: 'payment',
                              iconPath: 'assets/image/suppliers.png'),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(Routes.dailyPurchasesScreen),
                          child: buildCart(
                              title: 'DailyPurchases',
                              iconPath: 'assets/image/purchasing.png'),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.usersScreen),
                          child: buildCart(
                              title: 'users',
                              iconPath: 'assets/image/users.png'),
                        ),
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, Routes.categoriesScreen),
                            child: buildCart(
                                title: 'items',
                                iconPath: 'assets/image/items.png')),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.weeklyReportScreen),
                          child: buildCart(
                              title: 'weeklyReport',
                              iconPath: 'assets/image/reports.png'),
                        )
                      ]),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.suppliersScreen),
                      child: buildCart(
                          margin: EdgeInsets.only(bottom: 20.h),
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
                  ]),
                );
        } else if (state is HomeError) {
          return Text(state.errorMsg);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
