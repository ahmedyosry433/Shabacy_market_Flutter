import 'package:flutter/material.dart';
import 'package:shabacy_market/core/router/routes.dart';
import 'package:shabacy_market/features/home/ui/home_screen.dart';

import '../../features/login/ui/login_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(' No Route Defined For ${settings.name}'),
            ),
          ),
        );
    }
  }
}
