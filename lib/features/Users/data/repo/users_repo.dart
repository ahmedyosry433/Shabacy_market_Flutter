import '../../../../core/networking/api_service.dart';
import '../model/user_model.dart';

class UsersRepo {
  ApiService apiService;
  UsersRepo({
    required this.apiService,
  });

  Future<List<UserModel>> getAllUsersRepo({required String token}) async {
    final response = await apiService.getAllUsers(token: token);

    return response;
  }

  Future<void> addUserRegisterRepo(
      {required String token, required AddUserModel addUsermodel}) async {
    await apiService.addUserRegister(token: token, addUsermodel: addUsermodel);
  }

  Future<void> deleteUserRepo(
      {required String token, required String userId}) async {
    await apiService.deleteUser(token: token, suppliersId: userId);
  }
  
  Future<void> editUserRepo(
      {required String token, required String userId, required EditUserModel editUserModel}) async {
    await apiService.editUser(
        token: token, userId: userId, editUserModel: editUserModel
    );
      }
  
}
