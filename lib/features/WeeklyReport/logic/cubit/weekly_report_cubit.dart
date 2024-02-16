// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:shabacy_market/features/WeeklyReport/data/repo/weekly_report_repo.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../data/model/weekly_report_model.dart';

part 'weekly_report_state.dart';

class WeeklyReportCubit extends Cubit<WeeklyReportState> {
  WeeklyReportRepo weeklyReportRepo;
  WeeklyReportCubit(this.weeklyReportRepo) : super(WeeklyReportInitial());

  Future<void> getWeeklyReportTableModelCubit() async {
    emit(WeeklyReportLoading());
    try {
      String token = await SharedPreferencesHelper.getValueForKey('token');

      var data = await weeklyReportRepo.getWeeklyReportTableModelRepo(
          token: token,
          startAndEndDateModel: StartAndEndDateModel(
              startDate: '2024-02-09T22:00:00.000Z',
              endDate: '2024-02-15T22:00:00.000Z'));

      emit(WeeklyReportLoaded(allReportData: data));

      print('______________________________________${getEndDate().toString()}');
    } catch (e) {
      emit(WeeklyReportError(e.toString()));
    }
  }

  getDate() {
    var timeNow = DateTime.now();
    var weekDay = timeNow.weekday;
    var startDateParsed = timeNow.subtract(Duration(days: weekDay + 1)); //+7

    return timeNow;
  }

  String startDate = '';
  String startDateDayWord = '';
  getStartDate() {
    var timeNow = DateTime.now();
    var weekDay = timeNow.weekday;
    var startDateParsed =
        timeNow.subtract(Duration(days: weekDay + 1 - 7)); //+7

    startDate = DateFormat('d-MM-yyyy').format(startDateParsed).toString();
    startDateDayWord = DateFormat('E').format(startDateParsed);
  }

  String endDate = '';
  String endDateDayWord = '';

  getEndDate() {
    var timeNow = DateTime.now();
    var weekDay = timeNow.weekday;
    var endDatePrased = timeNow
        .subtract(Duration(days: weekDay - 5 - 7))
        .toUtc(); //+7  to get last week   %%  -7  to get future week

    endDate = DateFormat('d-MM-yyyy').format(endDatePrased).toString();
    endDateDayWord = DateFormat('E').format(endDatePrased);
    return endDatePrased;
  }
}
