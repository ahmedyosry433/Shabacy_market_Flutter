import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/theme/style.dart';
import 'package:shabacy_market/core/widgets/app_coustom_loading_indecator.dart';
import 'package:shabacy_market/core/widgets/app_custom_appbar.dart';
import 'package:shabacy_market/core/widgets/app_text_button.dart';
import 'package:shabacy_market/features/WeeklyReport/logic/cubit/weekly_report_cubit.dart';
import 'package:shabacy_market/features/WeeklyReport/ui/widgets/set_table_weekly_report.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/app_custom_no_internet.dart';

class WeeklyReportScreen extends StatefulWidget {
  const WeeklyReportScreen({super.key});

  @override
  State<WeeklyReportScreen> createState() => _WeeklyReportScreen();
}

class _WeeklyReportScreen extends State<WeeklyReportScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeeklyReportCubit>().getSaturdayOfCurrentWeek();
    context.read<WeeklyReportCubit>().getWeeklyReportTableModelCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppCustomAppbar(
              isHome: false,
            ),
            OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return Column(children: [
                    buildDateSlid(),
                    BlocBuilder<WeeklyReportCubit, WeeklyReportState>(
                      builder: (context, state) {
                        if (state is WeeklyReportLoading) {
                          return const AppCustomLoadingIndecator();
                        } else if (state is WeeklyReportLoaded) {
                          return context
                                  .watch<WeeklyReportCubit>()
                                  .weeklyReportTableModel
                                  .isNotEmpty
                              ? Column(
                                  children: [
                                    // buildPDFButtonAndExcelButton(),
                                    verticalSpace(20),
                                    buildCardsWithBlocBuilder(),
                                    buildWeeklyReportTableAndBloc(),
                                  ],
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Text(
                                    'Not Found Orders This Week'.tr(),
                                    style: TextStyles.font20BlackRegular,
                                  ),
                                );
                        } else if (state is WeeklyReportError) {
                          return Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              'Not Found Orders This Week'.tr(),
                              style: TextStyles.font14BlueSemiBold,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ]);
                } else {
                  return const AppCustomNoInternet();
                }
              },
              child: const AppCustomLoadingIndecator(),
            ),
            changeDateAndBloc(),
            buildExportExcelBlocListener(),
          ],
        ),
      ),
    );
  }

  Widget buildDateSlid() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<WeeklyReportCubit>(context).backWeek();
            },
            icon: const Icon(Icons.chevron_left)),
        Text(
            '${context.watch<WeeklyReportCubit>().formatDate(dateFormating: context.watch<WeeklyReportCubit>().startDate!).toString()} - ${context.watch<WeeklyReportCubit>().formatDate(dateFormating: context.watch<WeeklyReportCubit>().endDate!).toString()}',
            style: TextStyles.font16BlackRegular),
        IconButton(
            onPressed: () {
              BlocProvider.of<WeeklyReportCubit>(context).nextWeek();
            },
            icon: const Icon(Icons.chevron_right)),
      ]),
    );
  }

  Widget buildPDFButtonAndExcelButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppTextButton(
            backgroundColor: ColorsManager.gray.withOpacity(0.1),
            buttonHeight: 40.h,
            buttonWidth: 100.w,
            horizontalPadding: 0,
            verticalPadding: 0,
            buttonText: '${'file export'.tr()}PDF',
            textStyle: TextStyles.font13BlackSemiBold,
            onPressed: () {}),
        horizontalSpace(10),
        AppTextButton(
            backgroundColor: ColorsManager.primryColor.withOpacity(0.7),
            buttonHeight: 40.h,
            buttonWidth: 100.w,
            horizontalPadding: 0,
            verticalPadding: 0,
            buttonText: '${'file export'.tr()}Excel',
            textStyle: TextStyles.font13WhiteSemiBold,
            onPressed: () {
              context.read<WeeklyReportCubit>().exportExcelWeeklyReportsCubit();
            }),
      ]),
    );
  }

  Widget buildWeeklyReportTableAndBloc() {
    return BlocBuilder<WeeklyReportCubit, WeeklyReportState>(
      builder: (context, state) {
        if (state is WeeklyReportLoading) {
          return const AppCustomLoadingIndecator();
        } else if (state is WeeklyReportLoaded) {
          return PaginatedDataTable(
            columns: [
              DataColumn(
                  label: Text('id'.tr(), style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('supplier name'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('total price'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label:
                      Text('paid'.tr(), style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('quantity'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('remaining'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('saturday'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label:
                      Text('sunday'.tr(), style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label:
                      Text('monday'.tr(), style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('tuesday'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('wednesday'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label: Text('thursday'.tr(),
                      style: TextStyles.font14BlackMeduim)),
              DataColumn(
                  label:
                      Text('friday'.tr(), style: TextStyles.font14BlackMeduim)),
            ],
            source: WeeklyReportTableData(
                state.allReportData.weeklyReportTableModel),
            columnSpacing: 25.w,
            horizontalMargin: 15.w,
            rowsPerPage: 4,
          );
        } else if (state is WeeklyReportError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildCardsWithBlocBuilder() {
    return BlocBuilder<WeeklyReportCubit, WeeklyReportState>(
      builder: (context, state) {
        if (state is WeeklyReportLoading) {
          return const SizedBox.shrink();
        } else if (state is WeeklyReportLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCustomCard(
                  title: 'total purchases',
                  price: state.allReportData.reportModel.totalReport),
              buildCustomCard(
                  title: 'paid',
                  price: state.allReportData.reportModel.totalPaidReport),
              buildCustomCard(
                  title: 'remaining',
                  price: state.allReportData.reportModel.totalRemainsReport),
            ],
          );
        } else if (state is WeeklyReportError) {
          return Text(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildCustomCard({required String title, required int price}) {
    return Card(
        color: ColorsManager.white,
        child: SizedBox(
          width: 100.w,
          height: 80.h,
          child: Column(
            children: [
              Text(title.tr(), style: TextStyles.font14BlackMedium),
              Text(price.toString(), style: TextStyles.font14BlueSemiBold),
              Text('EG'.tr(), style: TextStyles.font14BlackMedium),
            ],
          ),
        ));
  }

  Widget buildExportExcelBlocListener() {
    return BlocListener<WeeklyReportCubit, WeeklyReportState>(
      listener: (context, state) {
        if (state is WeeklyExportExcelReportLoading) {
          showProgressIndecator(context);
        } else if (state is WeeklyExportExcelReportLoaded) {
          context.pop();
          context.read<WeeklyReportCubit>().getWeeklyReportTableModelCubit();
          MotionToast.success(
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            animationCurve: Curves.easeOutExpo,
            width: 390.w,
            description: Text(
              "Download Succussfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        } else if (state is WeeklyExportExcelReportError) {
          context.pop();

          MotionToast.error(
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            animationCurve: Curves.easeOutExpo,
            description: Text(
              "Error Download".tr(),
              style: TextStyles.font11BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget changeDateAndBloc() {
    return BlocListener<WeeklyReportCubit, WeeklyReportState>(
        listener: (context, state) {
          if (state is DateTimeLoading) {
            showProgressIndecator(context);
          } else if (state is DateTimeLoaded) {
            context.pop();
            context.read<WeeklyReportCubit>().getWeeklyReportTableModelCubit();
          } else if (state is DateTimeError) {
            context.pop();
            MotionToast.error(
              position: MotionToastPosition.top,
              iconSize: 30.w,
              height: 70.h,
              animationCurve: Curves.easeOutExpo,
              description: Text(
                state.message,
                style: TextStyles.font11BlackSemiBold,
              ),
            ).show(context);
          }
        },
        child: const SizedBox.shrink());
  }
}

Widget showProgressIndecator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(child: AppCustomLoadingIndecator()),
  );
  showDialog(
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) => alertDialog);
  return alertDialog;
}
