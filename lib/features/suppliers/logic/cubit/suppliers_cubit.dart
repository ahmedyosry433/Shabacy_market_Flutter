// ignore_for_file: unused_field, depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
  GlobalKey<FormState> addNewSupplierFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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

  var dropdownValue;

  void addNewSupplierCubit() async {
    emit(SuppliersLoading());

    try {
      _suppliersRepo.addNewSupplierRepo(
        addSuppliersModel: AddSuppliersModel(
          nameController.text,
          phoneController.text,
          dropdownValue,
        ),
        token: await SharedPreferencesHelper.getValueForKey('token'),
      );

      emit(SuppliersLoaded());
      nameController.clear();
      phoneController.clear();
      dropdownValue = '';
    } catch (e) {
      emit(SuppliersError(e.toString()));
    }
  }

  void deleteSupplierCubit({required String suppliersId}) async {
    emit(SuppliersLoading());
    try {
      _suppliersRepo.deleteSupplierRepo(
        token: await SharedPreferencesHelper.getValueForKey('token'),
        suppliersId: suppliersId,
      );
      emit(SuppliersLoaded());
    } catch (e) {
      emit(SuppliersError(e.toString()));
    }
  }
}
