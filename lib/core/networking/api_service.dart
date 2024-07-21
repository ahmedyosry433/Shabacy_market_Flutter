// ignore_for_file: avoid_print, prefer_final_fields, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shabacy_market/core/networking/api_constants.dart';
import 'package:shabacy_market/features/Login/data/models/login_request.dart';
import 'package:shabacy_market/features/Login/data/models/login_response.dart';

import '../../features/Categories/data/model/categories_model.dart';
import '../../features/DailyPurchases/data/model/daily_purchases_model.dart';
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

  Future<void> editSupplierBalance(
      {required String token,
      required String userId,
      required BalanceModel balance}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allSuppliersUrl}${ApiConstants.addBalanceUrl}/$userId',
        data: balance,
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

  Future<List<GetDailyPurchasesModel>> getAllOrders(
      {required String token,
      required String period,
      required String categoryId,
      required String gtDate,
      required String ltDate}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.ordersUrl}?filter={"date":{"\$gt":"${gtDate}T22:00:00.000Z","\$lt":"${ltDate}T21:59:59.999Z"},"period":"$period","category":"$categoryId"}',
        options: Options(
          method: 'GET',
          headers: headers,
        ));

    var data = response.data;

    List<GetDailyPurchasesModel> allOrders = [];

    for (var a in data['result']) {
      GetDailyPurchasesModel allOrdersOject =
          GetDailyPurchasesModel.fromJson(a);
      allOrders.add(allOrdersOject);
    }

    return allOrders;
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

  Future<void> deleteCategory(
      {required String token, required String categoryId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.allCategoriesUrl}/$categoryId',
        options: Options(
          method: 'DELETE',
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

  Future<dynamic> exportExcelWeeklyReports(
      {required String token,
      required StartAndEndDateModel startAndEndDateModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await _dio.request(
        ApiConstants.apiBaseUrl +
            ApiConstants.startDateExportExcelReportUrl +
            startAndEndDateModel.startDate +
            ApiConstants.endDateReportUrl +
            startAndEndDateModel.endDate,
        data: startAndEndDateModel,
        options: Options(
          responseType: ResponseType.bytes,
          method: 'GET',
          headers: headers,
        ));

    return response;
  }

  Future<void> addNewOrder(
      {required String token,
      required DailyPurchasesRequestModel dailyRequestModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await _dio.request(ApiConstants.apiBaseUrl + ApiConstants.ordersUrl,
        data: dailyRequestModel,
        options: Options(
          method: 'POST',
          headers: headers,
        ));
  }

  Future<void> editOrder(
      {required String token,
      required String orderId,
      required DailyPurchasesEditModel dailyPurchasesEditModel}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.ordersUrl}/$orderId',
        data: dailyPurchasesEditModel,
        options: Options(
          method: 'PATCH',
          headers: headers,
        ));
  }

  Future<void> deleteOrder(
      {required String token, required String orderId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await _dio.request(
        '${ApiConstants.apiBaseUrl}${ApiConstants.ordersUrl}/$orderId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ));
  }
//-----------Payment Method-----------------------------

  Future<String> getClinetSecretKeyToPayment({
    required int amount,
    required String category,
    required String supplierId,
    required int paid,
    required int price,
    required int quantity,
    required String currentUserId,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ApiConstants.secretKey} ',
    };

    Response res = await _dio.request("https://accept.paymob.com/v1/intention/",
        data: {
          "amount": price * quantity,
          "currency": "EGP",
          "payment_methods": [
            4605699, //valu
            4604351, // card
            4605916, //Kiosk
            4606202, // bank installment
            4604353, // Wallet
            // 4605784, //Paypal
            // 4605665, //cash collection
          ],
          "items": [
            {
              "name": category,
              "amount": price,
              "description": "Dairy Milk",
              "quantity": quantity,
            },
          ],
          "billing_data": {
            "first_name": supplierId,
            "last_name": "aaaa",
            "phone_number": "+0101712351",
            "country": "Egypt",
            "email": "Ahmed@Ahmed.com",
          },
        },
        options: Options(
          method: 'POST',
          headers: headers,
        ));
    return res.data['client_secret'];
  }

//--------------- Get TOken ------------------------
  // Future<String> getToken() async {
  //   try {
  //     Response response = await _dio.post(
  //       ApiConstants.paymentTokenUrl,
  //       data: {"api_key": ApiConstants.apiKey},
  //     );
  //     return response.data["token"];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //--------------- Order Registration -----------------
  // Future<int> getOrderId(
  //     {required String token, required String amount}) async {
  //   try {
  //     Response response = await _dio.post(
  //       ApiConstants.paymentOrderUrl,
  //       data: {
  //         "auth_token": token,
  //         "delivery_needed": "true",
  //         "amount_cents": "18000",
  //         "currency": "EGP",
  //         "items": []
  //       },
  //     );
  //     return response.data["id"];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //---------- Payment Key ---------------------
  // Future<String> getPaymentKey(
  //     {required String token,
  //     required String amount,
  //     required int orderId}) async {
  //   try {
  //     Response response = await _dio.post(
  //       ApiConstants.paymentKeyUrl,
  //       data: {
  //         "auth_token": token,
  //         "amount_cents": "18000",
  //         "expiration": 3000,
  //         "order_id": orderId.toString(),
  //         "currency": "EGP",
  //         // "integration_id": 4604351, //Online Card
  //         "integration_id": 4605699, //Valu Card
  //         // "integration_id": 4605665, //cash collection
  //         // "integration_id": 4604353, //mobile wallet
  //         // "integration_id": 4605784, //PayPal
  //         "lock_order_when_paid": "false",
  //         "billing_data": {
  //           "apartment": "NA",
  //           "email": "a7med.yosry.elesawy@gmail.com",
  //           "floor": "NA",
  //           "first_name": "ahmed",
  //           "street": "NA",
  //           "building": "NA",
  //           "phone_number": "01234567890",
  //           "shipping_method": "NA",
  //           "postal_code": "NA",
  //           "city": "cairo",
  //           "country": "NA",
  //           "last_name": "yosry",
  //           "state": "egypt",
  //         }
  //       },
  //     );
  //     return response.data["token"];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
