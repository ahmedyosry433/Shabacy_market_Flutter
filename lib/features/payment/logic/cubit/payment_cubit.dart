// ignore_for_file: unused_field, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shabacy_market/features/payment/repo/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._paymentRepo) : super(PaymentInitial());
  final PaymentRepo _paymentRepo;
  String clientSecretKey = '';

  Future getClientSecretKeyToPayment(
      {required int amount,
      required String category,
      required String supplierId,
      required int paid,
      required int price,
      required int quantity,
      required String currentUserId}) async {
    emit(PaymentLoading());
    try {
      String clientSecretKey = await _paymentRepo.getValuTokenRepo(
        amount: amount,
        category: category,
        supplierId: supplierId,
        paid: paid,
        price: price,
        quantity: quantity,
        currentUserId: currentUserId,
      );
      this.clientSecretKey = clientSecretKey;
      emit(PaymentSuccess(clientSecretKey: clientSecretKey));
    } catch (e) {
      emit(PaymentFailure(e.toString()));
      rethrow;
    }
  }
  //Future payWithPaymob(int amount) async {
  //   emit(PaymentLoading());
  //   try {
  //     String token = await getTokenCubit();
  //     int orderId = await getOrderIdCubit(
  //         token: token, amount: (100 * amount).toString());
  //     String paymentKey = await getPaymentKeyCubit(
  //         token: token, orderId: orderId, amount: (100 * amount).toString());
  //     this.paymentKey = paymentKey;
  //     emit(PaymentSuccess(key: paymentKey));
  //   } catch (e) {
  //     emit(PaymentFailure(e.toString()));
  //     rethrow;
  //   }
  // }

  // Future<String> getTokenCubit() async {
  //   return await _paymentRepo.getTokenRepo();
  // }

  // Future<int> getOrderIdCubit(
  //     {required String token, required String amount}) async {
  //   return await _paymentRepo.getOrderIdRepo(token: token, amount: amount);
  // }

  // Future<String> getPaymentKeyCubit(
  //     {required String token,
  //     required int orderId,
  //     required String amount}) async {
  //   return await _paymentRepo.getPaymentKeyRepo(
  //       token: token, amount: amount, orderId: orderId);
  // }
}
