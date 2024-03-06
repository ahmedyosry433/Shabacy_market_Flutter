// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables, constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/core/helper/shared_preferences_helper.dart';
import 'package:shabacy_market/features/Categories/data/model/categories_model.dart';
import 'package:shabacy_market/features/DailyPurchases/data/repo/daily_purchases_repo.dart';
import 'package:shabacy_market/features/Suppliers/data/models/suppliers_model.dart';
import 'package:shabacy_market/features/Users/data/model/user_model.dart';

import '../../data/model/daily_purchases_model.dart';

part 'daily_purchases_state.dart';

class DailyPurchasesCubit extends Cubit<DailyPurchasesState> {
  DailyPurchasesRepo dailyPurchasesRepo;
  DailyPurchasesCubit(this.dailyPurchasesRepo) : super(DailyPurchasesInitial());

  DateTime? selectDate = DateTime.now();
  DateTime? editselectDate;
  List<CategoriesModel> categories = [];
  List<SuppliersModel> suppliers = [];
  var dropdownCategroyValue;
  var dropdownSupplierValue;
  var editDropdownSupplierValue;
  var dropdownPeriodValue;
  GlobalKey<FormState> newOrderFormKey = GlobalKey();
  GlobalKey<FormState> editOrderFormKey = GlobalKey();
  TextEditingController paidController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController remainsController = TextEditingController(text: '0');
  TextEditingController totalController = TextEditingController(text: '0');
  TextEditingController editTotalController = TextEditingController();
  TextEditingController editPaidController = TextEditingController();
  TextEditingController editPriceController = TextEditingController();
  TextEditingController editQuantityController = TextEditingController();
  TextEditingController editDateController = TextEditingController();
  TextEditingController editRemainsController = TextEditingController();

  String currentUserId = 'ahmed';
  List<GetDailyPurchasesModel> listOfOrders = [];
  getAllCategories() async {
    final token = await SharedPreferencesHelper.getValueForKey('token');
    List<CategoriesModel> res =
        await dailyPurchasesRepo.getAllCategoriesRepo(token: token);

    categories = res;
  }

  getAllSuppliers() async {
    final token = await SharedPreferencesHelper.getValueForKey('token');
    List<SuppliersModel> res =
        await dailyPurchasesRepo.getAllSuppliersRepo(token: token);

    suppliers = res;
  }

  getCurrentUser() async {
    final token = await SharedPreferencesHelper.getValueForKey('token');

    UserModel user = await dailyPurchasesRepo.getCurrentUserRepo(token: token);
    currentUserId = user.id;
  }

  addNewOrderCubit() async {
    emit(AddedOrderLoading());

    try {
      final token = await SharedPreferencesHelper.getValueForKey('token');

      await dailyPurchasesRepo.addNewOrderRepo(
          token: token,
          dailyRequestModel: DailyPurchasesRequestModel(
            date: selectDate.toString(),
            category: dropdownCategroyValue,
            userId: dropdownSupplierValue,
            period: dropdownPeriodValue,
            paid: int.parse(paidController.text),
            price: int.parse(priceController.text),
            quantity: int.parse(quantityController.text),
            adminId: currentUserId,
          ));
      emit(AddedOrderLoaded());
      dropdownSupplierValue = null;
      paidController.clear();
      priceController.clear();
      quantityController.clear();
      remainsController.clear();
      totalController.clear();
    } catch (e) {
      emit(AddedOrderError(e.toString()));
    }
  }

  DateFormat formatting = DateFormat('yyyy-MM-dd');

  getAllOrdersCubit() async {
    final token = await SharedPreferencesHelper.getValueForKey('token');
    DateTime gtDate = selectDate!.subtract(const Duration(days: 1));

    List<GetDailyPurchasesModel> res =
        await dailyPurchasesRepo.getAllOrdersRepo(
      token: token,
      period: dropdownPeriodValue,
      categoryId: dropdownCategroyValue,
      gtDate: formatting.format(gtDate).toString(),
      ltDate: formatting.format(selectDate!).toString(),
    );
    listOfOrders = res;
  }

  Future<void> init() async {
    emit(Loading());
    try {
      await getAllOrdersCubit();

      emit(Loaded());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> initOnce() async {
    emit(Loading());
    try {
      await getAllCategories();
      if (categories.isNotEmpty) {
        dropdownCategroyValue = categories[0].id;
      } else {
        // dropdownCategroyValue = '';
      }
      await getAllSuppliers();

      await getCurrentUser();

      await getAllOrdersCubit();

      emit(Loaded());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  void editOrderCubit({
    required String orderId,
  }) async {
    emit(EditedOrderLoading());

    try {
      final token = await SharedPreferencesHelper.getValueForKey('token');
      await dailyPurchasesRepo.editOrderRepo(
          token: token,
          orderId: orderId,
          dailyPurchasesEditModel: DailyPurchasesEditModel(
            date: editselectDate.toString(),
            paid: int.parse(editPaidController.text),
            price: int.parse(editPriceController.text),
            quantity: int.parse(editQuantityController.text),
            userId: editDropdownSupplierValue,
          ));
      emit(EditedOrderLoaded());
    } catch (e) {
      emit(EditedOrderError(e.toString()));
    }
  }

  void deleteOrderCubit({
    required String orderId,
  }) async {
    emit(DeleteOrderLoading());
    try {
      final token = await SharedPreferencesHelper.getValueForKey('token');
      await dailyPurchasesRepo.deleteOrderRepo(
        token: token,
        orderId: orderId,
      );
      emit(DeleteOrderLoaded());
    } catch (e) {
      emit(DeleteOrderError(e.toString()));
    }
  }
}

enum Period { AM, PM }
