// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/features/Categories/data/repo/categories_repo.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../data/model/categories_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesRepo categoriesRepo;
  CategoriesCubit(
    this.categoriesRepo,
  ) : super(CategoriesInitial());

  List<CategoriesModel> categoriesList = [];
  TextEditingController addCategriesNameController = TextEditingController();
  TextEditingController editCategriesNameController = TextEditingController();
  GlobalKey<FormState> addCategriesFormKey = GlobalKey<FormState>();
  void getAllCategoriesCubit() async {
    emit(CategoriesLoading());
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');
      List<CategoriesModel> categoryList =
          await categoriesRepo.getAllCategoriesRepo(token: token);
      categoriesList = categoryList;

      emit(CategoriesLoaded());
    } catch (error) {
      emit(CategoriesError(message: error.toString()));
    }
  }

  void addNewCategoriesCubit() async {
    emit(AddCategoryLoading());
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');
      await categoriesRepo.addNewCategoriesCubit(
          token: token,
          addCategoriesModel:
              AddCategoriesModel(name: addCategriesNameController.text));
      emit(AddCategoryLoaded());
      addCategriesNameController.clear();
    } catch (e) {
      emit(AddCategoryError(e.toString()));
    }
  }

  void editCategoriesCubit({required String categoryId}) async {
    emit(EditCategoryLoading());
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');
      await categoriesRepo.editCategoriesCubit(
          token: token,
          editCategoriesName:
              AddCategoriesModel(name: editCategriesNameController.text),
          categoryId: categoryId);
      emit(EditCategoryLoaded());
      addCategriesNameController.clear();
    } catch (e) {
      emit(EditCategoryError(e.toString()));
    }
  }

  void deleteCategoriesCubit({required String categoryId}) async {
    emit(DeleteCategoryLoading());
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');
      await categoriesRepo.deleteCategoriesCubit(
          token: token, categoryId: categoryId);
      emit(DeleteCategoryLoaded());
    } catch (e) {
      emit(DeleteCategoryError(e.toString()));
    }
  }
}
