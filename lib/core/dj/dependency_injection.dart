import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shabacy_market/features/DailyPurchases/data/repo/daily_purchases_repo.dart';
import 'package:shabacy_market/features/DailyPurchases/logic/cubit/daily_purchases_cubit.dart';
import 'package:shabacy_market/features/Home/data/repo/home_repo.dart';
import 'package:shabacy_market/features/Home/logic/cubit/home_cubit.dart';
import 'package:shabacy_market/features/Suppliers/data/repo/suppliers_repo.dart';
import 'package:shabacy_market/features/WeeklyReport/data/repo/weekly_report_repo.dart';
import 'package:shabacy_market/features/WeeklyReport/logic/cubit/weekly_report_cubit.dart';
import 'package:shabacy_market/features/payment/logic/cubit/payment_cubit.dart';
import 'package:shabacy_market/features/payment/repo/payment_repo.dart';

import '../../features/Categories/data/repo/categories_repo.dart';
import '../../features/Categories/logic/cubit/categories_cubit.dart';
import '../../features/Suppliers/logic/cubit/suppliers_cubit.dart';
import '../../features/Users/data/repo/users_repo.dart';
import '../../features/Users/logic/cubit/users_cubit.dart';
import '../../features/Login/data/repo/login_repo.dart';
import '../../features/Login/logic/cubit/login_cubit.dart';
import '../../features/Profile/data/repo/profile_repo.dart';
import '../../features/Profile/logic/cubit/profile_cubit.dart';

import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;
Future<void> setupGetit() async {
  // Dio & Api Service
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // getIt.registerLazySingleton<PaymentManager>(() => PaymobManager(dio));

  // login
  getIt.registerLazySingleton(() => LoginRepo(apiService: getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  //Profile
  getIt.registerLazySingleton(() => ProfileRepo(apiService: getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  // Suppliers
  getIt.registerLazySingleton(() => SuppliersRepo(apiService: getIt()));
  getIt.registerFactory<SuppliersCubit>(() => SuppliersCubit(getIt()));
  //Users
  getIt.registerLazySingleton(() => UsersRepo(apiService: getIt()));
  getIt.registerFactory<UsersCubit>(() => UsersCubit(getIt()));
  //Categories
  getIt.registerLazySingleton(() => CategoriesRepo(apiService: getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));
  //HomeScreen
  getIt.registerLazySingleton(() => HomeRepo(apiService: getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  //Weekly Report Screen
  getIt.registerLazySingleton(() => WeeklyReportRepo(apiService: getIt()));
  getIt.registerFactory<WeeklyReportCubit>(() => WeeklyReportCubit(getIt()));
  //Weekly Report Screen
  getIt.registerLazySingleton(() => DailyPurchasesRepo(apiService: getIt()));
  getIt
      .registerFactory<DailyPurchasesCubit>(() => DailyPurchasesCubit(getIt()));
//Payment
  getIt.registerLazySingleton(() => PaymentRepo(getIt()));
  getIt.registerFactory<PaymentCubit>(() => PaymentCubit(getIt()));

  // signup
}
