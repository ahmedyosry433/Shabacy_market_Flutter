part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersLoaded extends UsersState {}

final class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}

final class AddUsersLoading extends UsersState {}

final class AddUsersLoaded extends UsersState {}

final class AddUsersError extends UsersState {
  final String message;
  AddUsersError(this.message);
}

final class DeleteUsersLoading extends UsersState {}

final class DeleteUsersLoaded extends UsersState {}

final class DeleteUsersError extends UsersState {
  final String message;
  DeleteUsersError(this.message);
}

final class EditUsersLoading extends UsersState {}

final class EditUsersLoaded extends UsersState {}

final class EditUsersError extends UsersState {
  final String message;
  EditUsersError(this.message);
}
