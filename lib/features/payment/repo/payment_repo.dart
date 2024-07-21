import 'package:shabacy_market/core/networking/api_service.dart';

class PaymentRepo {
  final ApiService _apiService;
  PaymentRepo(
    this._apiService,
  );

  Future<String> getTokenRepo() async {
    return await _apiService.getToken();
  }

  Future<int> getOrderIdRepo(
      {required String token, required String amount}) async {
    return await _apiService.getOrderId(token: token, amount: amount);
  }

  Future<String> getPaymentKeyRepo(
      {required String token,
      required int orderId,
      required String amount}) async {
    return await _apiService.getPaymentKey(
        token: token, amount: amount, orderId: orderId);
  }

  Future<String> getValuTokenRepo(
      {required int amount,
      required String category,
      required String supplierId,
      required int paid,
      required int price,
      required int quantity,
      required String currentUserId}) async {
    return await _apiService.getClinetSecretKeyToPayment(
        amount: amount,
        supplierId: supplierId,
        paid: paid,
        price: price,
        quantity: quantity,
        category: category,
        currentUserId: currentUserId);
  }
}
