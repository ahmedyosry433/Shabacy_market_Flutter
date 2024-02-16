// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/features/WeeklyReport/data/repo/weekly_report_repo.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../data/model/weekly_report_model.dart';

part 'weekly_report_state.dart';

class WeeklyReportCubit extends Cubit<WeeklyReportState> {
  WeeklyReportRepo weeklyReportRepo;
  WeeklyReportCubit(this.weeklyReportRepo) : super(WeeklyReportInitial());
  List<WeeklyReportTableModel> weeklyReportTableModel = [];

  DateTime? startDate;
  DateTime? endDate;
  Future<void> getWeeklyReportTableModelCubit() async {
    emit(WeeklyReportLoading());

    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');

      var data = await weeklyReportRepo.getWeeklyReportTableModelRepo(
        token: token,
        startAndEndDateModel: StartAndEndDateModel(
          startDate: startDate!.toString(),
          endDate: endDate!.toString(),
        ),
      );

      for (var element in data.reportModel.weeklyReportTableModelList) {
        weeklyReportTableModel.add(element);
      }
      formatDate(dateFormating: endDate!);
      emit(WeeklyReportLoaded(allReportData: data));
    } catch (e) {
      emit(WeeklyReportError(e.toString()));
    }
  }

  Future<void> exportExcelWeeklyReportsCubit() async {
    emit(WeeklyExportExcelReportLoading());
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');

      await weeklyReportRepo.exportExcelWeeklyReportsRepo(
          token: token,
          startAndEndDateModel: StartAndEndDateModel(
              startDate: '2024-02-09T22:00:00.000Z',
              endDate: '2024-02-15T22:00:00.000Z'));

      emit(WeeklyExportExcelReportLoaded());
    } catch (e) {
      emit(WeeklyExportExcelReportError(e.toString()));
    }
  }

  void stareAndEndDate() {
    getStartOfWeek();
    getEndOfWeek();
  }

  DateTime getStartOfWeek() {
    DateTime date = DateTime.now();
    int dayOfWeek = date.weekday;
    DateTime startDateVar = date.subtract(Duration(days: dayOfWeek - 1));

    DateTime startDatevarSubTwoDays =
        startDateVar.subtract(const Duration(days: 2));

    startDate = startDatevarSubTwoDays;

    return startDatevarSubTwoDays;
  }

  DateTime getEndOfWeek() {
    DateTime date = DateTime.now();
    int dayOfWeek = date.weekday;
    DateTime endDateVar = date.add(Duration(days: 7 - dayOfWeek));
    DateTime endDateVarSubTwoDays =
        endDateVar.subtract(const Duration(days: 2));
    endDate = endDateVarSubTwoDays;
    
    return endDateVar;
  }

  void backWeek() {
    emit(DateTimeLoading());
    try {
      startDate = startDate!.subtract(const Duration(days: 7));
      endDate = endDate!.subtract(const Duration(days: 7));
      emit(DateTimeLoaded());
    } catch (e) {
      emit(DateTimeError(e.toString()));
    }
  }

  void nextWeek() {
    emit(DateTimeLoading());
    try {
      startDate = startDate!.add(const Duration(days: 7));
      endDate = endDate!.add(const Duration(days: 7));
      emit(DateTimeLoaded());
    } catch (e) {
      emit(DateTimeError(e.toString()));
    }
  }

  String formatDate({required DateTime dateFormating}) {
    var dateFormated =
        DateFormat('E d-MM-yyyy', 'ar').format(dateFormating).toString();
    return dateFormated;
  }
}
