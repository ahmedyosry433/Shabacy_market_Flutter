// ignore_for_file: unused_field, depend_on_referenced_packages, prefer_typing_uninitialized_variables, unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/features/Users/logic/cubit/users_cubit.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../../Users/data/model/user_model.dart';
import '../../data/models/suppliers_model.dart';
import '../../data/repo/suppliers_repo.dart';

part 'suppliers_state.dart';

class SuppliersCubit extends Cubit<SuppliersState> {
  final SuppliersRepo _suppliersRepo;

  SuppliersCubit(this._suppliersRepo) : super(SuppliersInitial());

  List<SuppliersModel> suppliers = [];
  List<UserModel> users = [];
  GlobalKey<FormState> addNewSupplierFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editSupplierFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController editNameController = TextEditingController();
  TextEditingController editPhoneController = TextEditingController();
  var dropdownValue;
  var dropdownEditValue;

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

  void addNewSupplierCubit() async {
    emit(AddSuppliersLoading());

    try {
      _suppliersRepo.addNewSupplierRepo(
        addSuppliersModel: ModifySuppliersModel(
          nameController.text,
          phoneController.text,
          dropdownValue,
        ),
        token: await SharedPreferencesHelper.getValueForKey('token'),
      );

      emit(AddSuppliersLoaded());
      nameController.clear();
      phoneController.clear();
      dropdownValue = '';
    } catch (e) {
      emit(AddSuppliersError(e.toString()));
    }
  }

  void deleteSupplierCubit({required String suppliersId}) async {
    emit(DeleteSuppliersLoading());
    try {
      _suppliersRepo.deleteSupplierRepo(
        token: await SharedPreferencesHelper.getValueForKey('token'),
        suppliersId: suppliersId,
      );
      emit(DeleteSuppliersLoaded());
    } catch (e) {
      emit(DeleteSuppliersError(e.toString()));
    }
  }

 void editeSupplierCubit(
      {required String suppliersId, required String adminId}) async {
    emit(EditSuppliersLoading());
    try {
      await _suppliersRepo.editSupplierRepo(
          token: await SharedPreferencesHelper.getValueForKey('token'),
          suppliersId: suppliersId,
          modifySuppliersModel: ModifySuppliersModel(
              editNameController.text, editPhoneController.text, adminId));

      emit(EditSuppliersLoaded());
    } catch (error) {
      emit(EditSuppliersError(error.toString()));
    }
  }
}
