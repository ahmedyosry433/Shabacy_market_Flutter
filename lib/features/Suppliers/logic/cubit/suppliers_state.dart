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

final class AddSuppliersLoading extends SuppliersState {}

final class AddSuppliersLoaded extends SuppliersState {}

final class AddSuppliersError extends SuppliersState {
  final String message;
  AddSuppliersError(this.message);
}

final class DeleteSuppliersLoading extends SuppliersState {}

final class DeleteSuppliersLoaded extends SuppliersState {}

final class DeleteSuppliersError extends SuppliersState {
  final String message;
  DeleteSuppliersError(this.message);
}

final class EditSuppliersLoading extends SuppliersState {}

final class EditSuppliersLoaded extends SuppliersState {}

final class EditSuppliersError extends SuppliersState {
  final String message;
  EditSuppliersError(this.message);
}
