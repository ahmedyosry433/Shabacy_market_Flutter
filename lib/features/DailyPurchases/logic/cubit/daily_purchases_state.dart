part of 'daily_purchases_cubit.dart';

@immutable
sealed class DailyPurchasesState {}

final class DailyPurchasesInitial extends DailyPurchasesState {}

final class DailyPurchasesLoading extends DailyPurchasesState {}

final class DailyPurchasesLoaded extends DailyPurchasesState {}

final class DailyPurchasesError extends DailyPurchasesState {
  final String error;
  DailyPurchasesError(this.error);
}

final class Loading extends DailyPurchasesState {}

final class Loaded extends DailyPurchasesState {}

final class Error extends DailyPurchasesState {
  final String error;
  Error(this.error);
}
final class AddedOrderLoading extends DailyPurchasesState {}

final class AddedOrderLoaded extends DailyPurchasesState {}

final class AddedOrderError extends DailyPurchasesState {
  final String error;
  AddedOrderError(this.error);
}
