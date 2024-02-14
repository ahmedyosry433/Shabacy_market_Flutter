// ignore_for_file: avoid_print

import 'package:shabacy_market/features/Login/data/models/login_request.dart';
import 'package:shabacy_market/features/Login/data/models/login_response.dart';

import '../../../../core/networking/api_service.dart';


class LoginRepo {
  final ApiService apiService;

  LoginRepo({required this.apiService});

  Future<LoginResponse> loginUser(LoginRequest loginRequest) async {
   
    var response = await apiService.login(loginRequest);
   
    return response;
  }
}
