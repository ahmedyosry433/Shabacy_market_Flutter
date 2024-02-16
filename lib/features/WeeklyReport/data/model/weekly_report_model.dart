class WeeklyReportTableModel {
  String name;
  int total;
  int totalPaid;
  int totalRemains;
  int totalQuantity;
  int sat;
  int sun;
  int mon;
  int tue;
  int wed;
  int thu;
  int fri;

  WeeklyReportTableModel({
    required this.name,
    required this.total,
    required this.totalPaid,
    required this.totalRemains,
    required this.totalQuantity,
    required this.sat,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
  });
  factory WeeklyReportTableModel.fromJson(Map<String, dynamic> json) {
    return WeeklyReportTableModel(
      name: json['name'],
      total: json['total'],
      totalPaid: json['totalPaid'],
      totalRemains: json['totalRemains'],
      totalQuantity: json['totalQuantity'],
      sat: json['sat'],
      sun: json['sun'],
      mon: json['mon'],
      tue: json['tue'],
      wed: json['wed'],
      thu: json['thu'],
      fri: json['fri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'total': total,
      'totalPaid': totalPaid,
      'totalRemains': totalRemains,
      'totalQuantity': totalQuantity,
      'sat': sat,
      'sun': sun,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
    };
  }
}

class ReportModel {
  int totalReport;
  int totalPaidReport;
  int totalRemainsReport;
  int totalQuantityReport;
  List<WeeklyReportTableModel> weeklyReportTableModelList;
  ReportModel(
      {required this.totalReport,
      required this.totalPaidReport,
      required this.totalRemainsReport,
      required this.totalQuantityReport,
      required this.weeklyReportTableModelList});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      totalReport: json['report']['total'],
      totalPaidReport: json['report']['totalPaid'],
      totalRemainsReport: json['report']['totalRemains'],
      totalQuantityReport: json['report']['totalQuantity'],
      weeklyReportTableModelList: List<WeeklyReportTableModel>.from(
          json['usersReport'].map((x) => WeeklyReportTableModel.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'total': totalReport,
      'totalPaid': totalPaidReport,
      'totalRemains': totalRemainsReport,
      'totalQuantity': totalQuantityReport,
      'usersReport': weeklyReportTableModelList,
    };
  }
}

class StartAndEndDateModel {
  String startDate;
  String endDate;
  StartAndEndDateModel({
    required this.startDate,
    required this.endDate,
  });

  factory StartAndEndDateModel.fromJson(Map<String, dynamic> json) {
    return StartAndEndDateModel(
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class AllReportData {
  List<WeeklyReportTableModel> weeklyReportTableModel;
  ReportModel reportModel;
  AllReportData({
    required this.weeklyReportTableModel,
    required this.reportModel,
  });

  factory AllReportData.fromJson(Map<String, dynamic> json) {
    return AllReportData(
      weeklyReportTableModel: List<WeeklyReportTableModel>.from(
          json['usersReport'].map((x) => WeeklyReportTableModel.fromJson(x))),
      reportModel: ReportModel.fromJson(json),
    );
  }
}
