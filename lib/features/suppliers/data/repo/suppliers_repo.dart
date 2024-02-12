import 'package:shabacy_market/core/networking/api_service.dart';
import 'package:shabacy_market/features/Users/data/model/profile_model.dart';

import '../models/suppliers_model.dart';

class SuppliersRepo {
  final ApiService apiService;
  SuppliersRepo({
    required this.apiService,
  });

  Future<List<SuppliersModel>> getAllSuppliersRepo(
      {required String token}) async {
    final response = await apiService.getAllSuppliers(token: token);

    return response;
  }

  Future<List<UserModel>> getAllUsersRepo({required String token}) async {
    final response = await apiService.getAllUsers(token: token);

    return response;
  }

  Future<SuppliersModel> addNewSupplierRepo(
      {required ModifySuppliersModel addSuppliersModel,
      required String token}) async {
    final response = await apiService.addNewSupplier(
        addSuppliersModel: addSuppliersModel, token: token);
    return response;
  }

  Future<void> deleteSupplierRepo(
      {required String token, required String suppliersId}) async {
    await apiService.deleteSupplier(token: token, suppliersId: suppliersId);
  }

  Future<void> editSupplierRepo(
      {required String token,
      required String suppliersId,
      required ModifySuppliersModel modifySuppliersModel}) async {
    await apiService.editSupplier(
        token: token,
        suppliersId: suppliersId,
        modifySuppliersModel: modifySuppliersModel);
  }
}
