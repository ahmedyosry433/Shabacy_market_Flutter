import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/dj/dependency_injection.dart';
import 'core/helper/shared_preferences_helper.dart';
import 'core/router/app_router.dart';
import 'shabacy_app.dart';

void main() async {
  setupGetit();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.getValueForKey('token');
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
