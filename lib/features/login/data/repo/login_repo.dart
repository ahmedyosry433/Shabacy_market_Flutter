// ignore_for_file: avoid_print

import 'package:shabacy_market/features/login/data/models/login_request.dart';

import '../../../../core/networking/api_service.dart';
import '../models/login_response.dart';

class LoginRepo {
  final ApiService apiService;

  LoginRepo({required this.apiService});

  Future<LoginResponse> loginUser(LoginRequest loginRequest) async {
   
    final response = await apiService.login(loginRequest);
   
    return response;
  }
}
