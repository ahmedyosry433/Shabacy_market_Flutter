import 'package:shabacy_market/core/networking/api_service.dart';

class HomeRepo {
  ApiService apiService;
  HomeRepo({
    required this.apiService,
  });
  Future<dynamic> getCurrentUserRepo({required String token}) async {
    return await apiService.getUserProfile(token: token);
  }
}
