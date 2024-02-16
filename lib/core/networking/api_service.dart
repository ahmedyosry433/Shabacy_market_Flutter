// ignore_for_file: avoid_print, prefer_final_fields, unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shabacy_market/core/networking/api_constants.dart';
import 'package:shabacy_market/features/Login/data/models/login_request.dart';
import 'package:shabacy_market/features/Login/data/models/login_response.dart';

import '../../features/Categories/data/model/categories_model.dart';
import '../../features/Users/data/model/user_model.dart';
import '../../features/Suppliers/data/models/suppliers_model.dart';
import '../../features/WeeklyReport/data/model/weekly_report_model.dart';
import '../helper/shared_preferences_helper.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var headers = {
      'Content-Type': 'application/json',
    };

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

  Future<void> addNewSupplier(
      {required ModifySuppliersModel addSuppliersModel,
      required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(ApiConstants.apiBaseUrl + ApiConstants.allSuppliersUrl,
        data: addSuppliersModel,
        options: Options(
          method: 'POST',
          headers: headers,
        ));
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

  Future<void> editSupplier(
      {required String token,
      required String suppliersId,
      required ModifySuppliersModel modifySuppliersModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allSuppliersUrl}/$suppliersId',
        data: modifySuppliersModel,
        options: Options(
          method: 'PATCH',
          headers: headers,
        ));
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

  Future<void> addUserRegister(
      {required String token, required AddUserModel addUsermodel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        ApiConstants.apiBaseUrl +
            ApiConstants.allUsersUrl +
            ApiConstants.addUsersRegisterUrl,
        data: addUsermodel,
        options: Options(
          method: 'POST',
          headers: headers,
        ));
  }

  Future<void> deleteUser(
      {required String token, required String suppliersId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allUsersUrl}/$suppliersId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ));
  }

  Future<void> editUser(
      {required String token,
      required String userId,
      required EditUserModel editUserModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allUsersUrl}/$userId',
        data: editUserModel,
        options: Options(
          method: 'PATCH',
          headers: headers,
        ));
  }

  Future<List<CategoriesModel>> getAllCategories(
      {required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Response res = await _dio.request(
        ApiConstants.apiBaseUrl + ApiConstants.allCategoriesUrl,
        options: Options(
          method: 'GET',
          headers: headers,
        ));
    var data = res.data;
    List<CategoriesModel> categoriesList = [];

    for (var a in data) {
      CategoriesModel allCategoriesObject = CategoriesModel.fromJson(a);
      categoriesList.add(allCategoriesObject);
    }
    return categoriesList;
  }

  Future<void> addNewCategories(
      {required String token,
      required AddCategoriesModel addCategoriesModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(ApiConstants.apiBaseUrl + ApiConstants.allCategoriesUrl,
        data: addCategoriesModel,
        options: Options(
          method: 'POST',
          headers: headers,
        ));
  }

  Future<void> editCategories(
      {required String token,
      required String categoryId,
      required AddCategoriesModel editCategoriesName}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allCategoriesUrl}/$categoryId',
        data: editCategoriesName,
        options: Options(
          method: 'PATCH',
          headers: headers,
        ));
  }

  Future<AllReportData> getAllWeeklyReports(
      {required String token,
      required StartAndEndDateModel startAndEndDateModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await _dio.request(
        ApiConstants.apiBaseUrl +
            ApiConstants.startDateReportUrl +
            startAndEndDateModel.startDate +
            ApiConstants.endDateReportUrl +
            startAndEndDateModel.endDate,
        data: startAndEndDateModel,
        options: Options(
          method: 'GET',
          headers: headers,
        ));

    var data = response.data;

    return AllReportData.fromJson(data);
  }

  Future<void> exportExcelWeeklyReports(
      {required String token,
      required StartAndEndDateModel startAndEndDateModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        ApiConstants.apiBaseUrl +
            ApiConstants.startDateExportExcelReportUrl +
            startAndEndDateModel.startDate +
            ApiConstants.endDateReportUrl +
            startAndEndDateModel.endDate,
        data: startAndEndDateModel,
        options: Options(
          method: 'GET',
          headers: headers,
        ));

    
  }
}
