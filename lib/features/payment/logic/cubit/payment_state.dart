part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  final String clientSecretKey;

  PaymentSuccess({required this.clientSecretKey});
}

final class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message);
}
