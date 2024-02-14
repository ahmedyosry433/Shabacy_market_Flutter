part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {}

final class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError({
    required this.message,
  });
}

final class AddCategoryLoading extends CategoriesState {}

final class AddCategoryLoaded extends CategoriesState {}

final class AddCategoryError extends CategoriesState {
  final String message;
  AddCategoryError(this.message);
}

final class EditCategoryLoading extends CategoriesState {}

final class EditCategoryLoaded extends CategoriesState {}

final class EditCategoryError extends CategoriesState {
  final String message;
  EditCategoryError(this.message);
}
