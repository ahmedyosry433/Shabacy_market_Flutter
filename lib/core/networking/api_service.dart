// ignore_for_file: avoid_print, prefer_final_fields, unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shabacy_market/core/networking/api_constants.dart';
import 'package:shabacy_market/features/login/data/models/login_request.dart';
import 'package:shabacy_market/features/login/data/models/login_response.dart';

import '../../features/profile/data/models/profile_model.dart';
import '../../features/suppliers/data/models/suppliers_model.dart';
import '../helper/shared_preferences_helper.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var headers = {
      'Content-Type': 'application/json',
    };
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

  Future<UserModel> getUserProfile({required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response =
        await _dio.request(ApiConstants.apiBaseUrl + ApiConstants.profileUrl,
            options: Options(
              method: 'GET',
              headers: headers,
            ));

    return UserModel.fromJson(response.data);
  }

  Future<List<SuppliersModel>> getAllSuppliers({required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await _dio.request(
        ApiConstants.apiBaseUrl + ApiConstants.allSuppliersUrl,
        options: Options(
          method: 'GET',
          headers: headers,
        ));

    var data = response.data;

    List<SuppliersModel> suppliersList = [];

    for (var a in data) {
      SuppliersModel allSuppliersObject = SuppliersModel.fromJson(a);
      suppliersList.add(allSuppliersObject);
    }
    return suppliersList;
  }

  Future<List<UserModel>> getAllUsers({required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response =
        await _dio.request(ApiConstants.apiBaseUrl + ApiConstants.allUsersUrl,
            options: Options(
              method: 'GET',
              headers: headers,
            ));

    var data = response.data;

    List<UserModel> allUsersList = [];

    for (var a in data) {
      UserModel allUsersOject = UserModel.fromJson(a);
      allUsersList.add(allUsersOject);
    }
    return allUsersList;
  }

   Future<SuppliersModel> addNewSupplier(
      {required AddSuppliersModel addSuppliersModel,
      required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await _dio.request(
        ApiConstants.apiBaseUrl + ApiConstants.allSuppliersUrl,
        data: addSuppliersModel,
        options: Options(
          method: 'POST',
          headers: headers,
        ));

    return SuppliersModel.fromJson(response.data);
  }

  Future<void> deleteSupplier(
      {required String token, required String suppliersId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allSuppliersUrl}/$suppliersId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ));
  }
}
