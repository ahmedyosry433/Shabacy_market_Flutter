import 'package:shabacy_market/features/Suppliers/data/models/suppliers_model.dart';

import '../../../../core/networking/api_service.dart';
import '../../../Users/data/model/user_model.dart';

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

  Future<void> addNewSupplierRepo(
      {required ModifySuppliersModel addSuppliersModel,
      required String token}) async {
    await apiService.addNewSupplier(
        addSuppliersModel: addSuppliersModel, token: token);
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

  Future<void> editSupplierBalanceRepo({
    required String token,
    required String userId,
     required BalanceModel balance
  }) async {
    await apiService.editSupplierBalance(
      
      token: token,
      userId: userId,
      balance: balance
    );
  }

  Future<UserModel> getCurrentUser({required String token}) async {
    final response = await apiService.getUserProfile(token: token);
    return response;
  }
}
