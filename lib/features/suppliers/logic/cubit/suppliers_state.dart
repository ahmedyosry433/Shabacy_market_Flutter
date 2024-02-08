part of 'suppliers_cubit.dart';

@immutable
sealed class SuppliersState {}

final class SuppliersInitial extends SuppliersState {}

final class SuppliersLoading extends SuppliersState {}

final class SuppliersLoaded extends SuppliersState {}

final class SuppliersError extends SuppliersState {
  final String message;
  SuppliersError(this.message);
}
