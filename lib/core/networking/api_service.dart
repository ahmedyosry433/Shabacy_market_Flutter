// ignore_for_file: avoid_print, prefer_final_fields, unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shabacy_market/core/networking/api_constants.dart';
import 'package:shabacy_market/features/login/data/models/login_request.dart';
import 'package:shabacy_market/features/login/data/models/login_response.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var headers = {'Content-Type': 'application/json'};
    // var data = json.encode({"email": "admin@admin", "password": "123456"});
    Response response =
        await _dio.request(ApiConstants.apiBaseUrl + ApiConstants.loginUrl,
            data: loginRequest,
            options: Options(
              method: 'POST',
              headers: headers,
            ));

    return LoginResponse.fromJson(response.data);
  }
}
