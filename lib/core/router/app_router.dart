import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shabacy_market/features/DailyPurchases/logic/cubit/daily_purchases_cubit.dart';
import 'package:shabacy_market/features/DailyPurchases/ui/daily_purchases_screen.dart';
import 'package:shabacy_market/features/WeeklyReport/logic/cubit/weekly_report_cubit.dart';
import 'package:shabacy_market/features/WeeklyReport/ui/weekly_report_screen.dart';
import 'package:shabacy_market/features/splash/ui/splash_screen.dart';
import '../../features/Home/logic/cubit/home_cubit.dart';
import '../dj/dependency_injection.dart';
import 'routes.dart';
import '../../features/Categories/logic/cubit/categories_cubit.dart';
import '../../features/Categories/ui/categories_screen.dart';
import '../../features/Home/ui/home_screen.dart';
import '../../features/Users/logic/cubit/users_cubit.dart';
import '../../features/Users/ui/users_screen.dart';
import '../../features/Login/logic/cubit/login_cubit.dart';
import '../../features/Profile/logic/cubit/profile_cubit.dart';
import '../../features/Suppliers/logic/cubit/suppliers_cubit.dart';

import '../../features/Login/ui/login_screen.dart';
import '../../features/Profile/ui/profile_screen.dart';
import '../../features/Suppliers/ui/suppliers_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
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
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
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
            child: const UsersScreen(),
          ),
        );

      case Routes.categoriesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CategoriesCubit>(),
            child: const CategoriesScreen(),
          ),
        );
      case Routes.weeklyReportScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<WeeklyReportCubit>(),
            child: const WeeklyReportScreen(),
          ),
        );
      case Routes.dailyPurchasesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<DailyPurchasesCubit>(),
            child: const DailyPurchasesScreen(),
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
