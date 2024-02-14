import '../../../../core/networking/api_service.dart';
import '../model/categories_model.dart';

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

  Future<void> editCategoriesCubit(
      {required String token,
      required AddCategoriesModel editCategoriesName,
      required String categoryId}) async {
    await apiService.editCategories(
        token: token,
        editCategoriesName: editCategoriesName,
        categoryId: categoryId);
  }
}
