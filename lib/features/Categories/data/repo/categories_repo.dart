import 'package:shabacy_market/core/networking/api_service.dart';
import 'package:shabacy_market/features/Categories/data/model/categories_model.dart';

class CategoriesRepo {
  final ApiService apiService;
  CategoriesRepo({
    required this.apiService,
  });

  Future<List<CategoriesModel>> getAllCategoriesRepo(
      {required String token}) async {
    List<CategoriesModel> categoriesList =
        await apiService.getAllCategories(token: token);
    return categoriesList;
  }

  Future<void> addNewCategoriesCubit(
      {required String token,
      required AddCategoriesModel addCategoriesModel}) async {
    await apiService.addNewCategories(
        token: token, addCategoriesModel: addCategoriesModel);
  }
}
