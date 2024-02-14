part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserModel userProfile;
  ProfileLoaded({required this.userProfile});
}

final class ProfileError extends ProfileState {
  final String errorMsg;
  ProfileError({required this.errorMsg});
}
