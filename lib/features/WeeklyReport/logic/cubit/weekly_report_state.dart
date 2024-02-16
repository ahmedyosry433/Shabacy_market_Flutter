// ignore_for_file: must_be_immutable

part of 'weekly_report_cubit.dart';

@immutable
sealed class WeeklyReportState {}

final class WeeklyReportInitial extends WeeklyReportState {}

final class WeeklyReportLoading extends WeeklyReportState {}

final class WeeklyReportLoaded extends WeeklyReportState {
  AllReportData allReportData;
  WeeklyReportLoaded({required this.allReportData});
}

final class WeeklyReportError extends WeeklyReportState {
  final String message;
  WeeklyReportError(this.message);
}

final class WeeklyExportExcelReportLoading extends WeeklyReportState {}

final class WeeklyExportExcelReportLoaded extends WeeklyReportState {}

final class WeeklyExportExcelReportError extends WeeklyReportState {
  final String message;
  WeeklyExportExcelReportError(this.message);
}
final class DateTimeLoading extends WeeklyReportState {}

final class DateTimeLoaded extends WeeklyReportState {}

final class DateTimeError extends WeeklyReportState {
  final String message;
  DateTimeError(this.message);
}
