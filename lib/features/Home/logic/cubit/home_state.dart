part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserModel currentUser;
  HomeLoaded(this.currentUser);
}

final class HomeError extends HomeState {
  final String errorMsg;
  HomeError(this.errorMsg);
}
