import '../../../../core/networking/api_service.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  final ApiService apiService;
  ProfileRepo({required this.apiService});

  Future<UserModel> getUserProfileRepo({required String token}) async {
    final response = await apiService.getUserProfile(token: token);
    return response;
  }
}
