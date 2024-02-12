import '../../../../core/networking/api_service.dart';
import '../model/profile_model.dart';

class UsersRepo {
  ApiService apiService;
  UsersRepo({
    required this.apiService,
  });

  Future<List<UserModel>> getAllUsersRepo({required String token}) async {
    final response = await apiService.getAllUsers(token: token);

    return response;
  }
}
