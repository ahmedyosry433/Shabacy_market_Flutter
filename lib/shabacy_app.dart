// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/shared_preferences_helper.dart';
import 'package:shabacy_market/core/router/routes.dart';

import 'core/router/app_router.dart';

class ShabacyApp extends StatefulWidget {
  final AppRouter appRouter;
  const ShabacyApp({super.key, required this.appRouter});

  @override
  State<ShabacyApp> createState() => _ShabacyAppState();
}

class _ShabacyAppState extends State<ShabacyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        initialRoute: SharedPreferencesHelper.token == null
            ? Routes.loginScreen
            : Routes.homeScreen,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
      ),
    );
  }
}
