import 'package:shabacy_market/core/networking/api_service.dart';

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
}
