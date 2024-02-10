// ignore_for_file: unused_field, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../data/models/suppliers_model.dart';
import '../../data/repo/suppliers_repo.dart';

part 'suppliers_state.dart';

class SuppliersCubit extends Cubit<SuppliersState> {
  final SuppliersRepo _suppliersRepo;

  SuppliersCubit(this._suppliersRepo) : super(SuppliersInitial());

  List<SuppliersModel> suppliers = [];
  List<UserModel> users = [];

  void getAllSuppliersCubit() async {
    emit(SuppliersLoading());

    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');

      List<SuppliersModel> response =
          await _suppliersRepo.getAllSuppliersRepo(token: token);

      suppliers = response;

      emit(SuppliersLoaded());
    } catch (error) {
      emit(SuppliersError(error.toString()));
    }
  }

  void getAllUsersCubit() async {
    emit(SuppliersLoading());

    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');

      List<UserModel> response =
          await _suppliersRepo.getAllUsersRepo(token: token);

      users = response;

      emit(SuppliersLoaded());
    } catch (error) {
      emit(SuppliersError(error.toString()));
    }
  }
}
