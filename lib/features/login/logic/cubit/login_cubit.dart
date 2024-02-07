// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shabacy_market/core/helper/shared_preferences_helper.dart';

import '../../data/models/login_request.dart';
import '../../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginInitial());

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emailLoginState() async {
    emit(LoginLoading());
    try {
      var res = await _loginRepo.loginUser(
        LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      await SharedPreferencesHelper.setValueForKey('token', res.token);
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(errorMsg: error.toString()));
    }
  }
}
