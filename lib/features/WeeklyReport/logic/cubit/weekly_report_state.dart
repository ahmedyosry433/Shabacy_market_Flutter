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
