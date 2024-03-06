import 'package:dio/dio.dart';
import 'package:shabacy_market/core/networking/api_service.dart';

import '../model/weekly_report_model.dart';

class WeeklyReportRepo {
  ApiService apiService;
  WeeklyReportRepo({
    required this.apiService,
  });

  Future<AllReportData> getWeeklyReportTableModelRepo(
      {required String token,
      required StartAndEndDateModel startAndEndDateModel}) async {
    var res = await apiService.getAllWeeklyReports(
        token: token, startAndEndDateModel: startAndEndDateModel);

    return res;
  }

  Future<dynamic> exportExcelWeeklyReportsRepo(
      {required String token,
      required StartAndEndDateModel startAndEndDateModel}) async {
    Response response = await apiService.exportExcelWeeklyReports(
        token: token, startAndEndDateModel: startAndEndDateModel);
    return response;
  }
}
