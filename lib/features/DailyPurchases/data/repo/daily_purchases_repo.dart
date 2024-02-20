import 'package:shabacy_market/core/networking/api_service.dart';

import '../../../Categories/data/model/categories_model.dart';
import '../../../Suppliers/data/models/suppliers_model.dart';
import '../../../Users/data/model/user_model.dart';
import '../model/daily_purchases_model.dart';

class DailyPurchasesRepo {
  ApiService apiService;
  DailyPurchasesRepo({
    required this.apiService,
  });

  Future<List<CategoriesModel>> getAllCategoriesRepo(
      {required String token}) async {
    List<CategoriesModel> categoriesList =
        await apiService.getAllCategories(token: token);
    return categoriesList;
  }

  Future<List<SuppliersModel>> getAllSuppliersRepo(
      {required String token}) async {
    final response = await apiService.getAllSuppliers(token: token);

    return response;
  }

  Future<void> addNewOrderRepo(
      {required String token,
      required DailyPurchasesRequestModel dailyRequestModel}) async {
    await apiService.addNewOrder(
        token: token, dailyRequestModel: dailyRequestModel);
  }

  Future<UserModel> getCurrentUserRepo({required String token}) async {
    UserModel res = await apiService.getUserProfile(
      token: token,
    );
    return res;
  }

  Future<List<GetDailyPurchasesModel>> getAllOrdersRepo(
      {required String token,
      required String period,
      required String categoryId,
      required String gtDate,
      required String ltDate}) async {
    final response = await apiService.getAllOrders(
      token: token,
      period: period,
      categoryId: categoryId,
      gtDate: gtDate,
      ltDate: ltDate,
    );

    return response;
  }
}
