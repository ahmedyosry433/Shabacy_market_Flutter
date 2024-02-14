import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shabacy_market/features/Suppliers/data/repo/suppliers_repo.dart';

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

  // signup
}
