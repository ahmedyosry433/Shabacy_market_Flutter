import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/core/router/app_router.dart';
import 'package:shabacy_market/shabacy_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', 'AE')],
      path: 'assets/lang',
      fallbackLocale: const Locale('ar', 'AE'),
      child: ShabacyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
