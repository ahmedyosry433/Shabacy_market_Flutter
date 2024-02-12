import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shabacy_market/core/dj/dependency_injection.dart';
import 'package:shabacy_market/core/router/routes.dart';
import 'package:shabacy_market/features/Home/ui/home_screen.dart';
import 'package:shabacy_market/features/Users/logic/cubit/users_cubit.dart';
import 'package:shabacy_market/features/Users/ui/users_screen.dart';
import 'package:shabacy_market/features/login/logic/cubit/login_cubit.dart';
import 'package:shabacy_market/features/profile/logic/cubit/profile_cubit.dart';
import 'package:shabacy_market/features/suppliers/logic/cubit/suppliers_cubit.dart';

import '../../features/login/ui/login_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/suppliers/ui/suppliers_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.suppliersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SuppliersCubit>(),
            child: const SuppliersScreen(),
          ),
        );
      case Routes.usersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UsersCubit>(),
            child:  UsersScreen(),
          ),
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
