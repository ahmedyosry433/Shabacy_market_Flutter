import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shabacy_market/features/Categories/data/repo/categories_repo.dart';
import 'package:shabacy_market/features/Categories/logic/cubit/categories_cubit.dart';
import 'package:shabacy_market/features/Users/data/repo/users_repo.dart';
import 'package:shabacy_market/features/Users/logic/cubit/users_cubit.dart';
import 'package:shabacy_market/features/profile/data/repo/profile_repo.dart';
import 'package:shabacy_market/features/profile/logic/cubit/profile_cubit.dart';
import 'package:shabacy_market/features/suppliers/logic/cubit/suppliers_cubit.dart';

import '../../features/login/data/repo/login_repo.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/suppliers/data/repo/suppliers_repo.dart';
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
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit( getIt()));

  // signup
}
