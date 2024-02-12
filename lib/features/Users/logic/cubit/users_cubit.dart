// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shabacy_market/features/Users/data/repo/users_repo.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../data/model/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo _usersRepo;
  UsersCubit(this._usersRepo) : super(UsersInitial());

  List<UserModel> users = [];

  var dropdownValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var editDropdownValue;
  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editPhoneController = TextEditingController();
   GlobalKey<FormState> addNewUserFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editUserFormKey = GlobalKey<FormState>();

  void getAllUsersCubit() async {
    emit(UsersLoading());

    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');

      List<UserModel> response = await _usersRepo.getAllUsersRepo(token: token);

      users = response;

      emit(UsersLoaded());
    } catch (error) {
      emit(UsersError(error.toString()));
    }
  }

  void addUsersRegisterCubit() async {
    emit(UsersLoading());
    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');
      await _usersRepo.addUserRegisterRepo(
          token: token,
          addUsermodel: AddUserModel(nameController.text, emailController.text,
              dropdownValue, passwordController.text, phoneController.text));

      emit(UsersLoaded());
    } catch (error) {
      emit(UsersError(error.toString()));
    }
  }

  void deleteUserCubit({required String userId}) async {
    emit(UsersLoading());
    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');
      await _usersRepo.deleteUserRepo(token: token, userId: userId);
    } catch (error) {
      emit(UsersError(error.toString()));
    }
  }

  void editUserCubit({required String userId}) async {
    emit(UsersLoading());
    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');
      await _usersRepo.editUserRepo(
          token: token,
          userId: userId,
          editUserModel: EditUserModel(
              editNameController.text,
              editEmailController.text,
              editDropdownValue,
              editPhoneController.text));

     
    } catch (error) {
      
      emit(UsersError(error.toString()));
    }
  }
}
