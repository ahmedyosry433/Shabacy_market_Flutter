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
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');
      await categoriesRepo.addNewCategoriesCubit(
          token: token,
          addCategoriesModel:
              AddCategoriesModel(name: addCategriesNameController.text));
      emit(CategoriesLoaded());
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
