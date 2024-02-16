import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/theme/style.dart';
import 'package:shabacy_market/core/widgets/app_coustom_loading_indecator.dart';
import 'package:shabacy_market/core/widgets/app_custom_appbar.dart';
import 'package:shabacy_market/core/widgets/app_text_button.dart';
import 'package:shabacy_market/features/WeeklyReport/logic/cubit/weekly_report_cubit.dart';
import 'package:shabacy_market/features/WeeklyReport/ui/widgets/set_table_weekly_report.dart';

import '../../../core/theme/colors.dart';

class WeeklyReportScreen extends StatefulWidget {
  const WeeklyReportScreen({super.key});

  @override
  State<WeeklyReportScreen> createState() => _WeeklyReportScreen();
}

class _WeeklyReportScreen extends State<WeeklyReportScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeeklyReportCubit>().getWeeklyReportTableModelCubit();
    context.read<WeeklyReportCubit>().getStartDate();
    context.read<WeeklyReportCubit>().getEndDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AppCustomAppbar(
              profileStyle:
                  TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
            ),
            buildDateSlid(),
            buildPDFButtonAndExcelButton(),
            buildCardsWithBlocBuilder(),
            buildWeeklyReportTableAndBloc(),
          ],
        ),
      )),
    );
  }

  Widget buildDateSlid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
        Text(
            '${BlocProvider.of<WeeklyReportCubit>(context).startDateDayWord.tr()} ${BlocProvider.of<WeeklyReportCubit>(context).startDate.tr()} - ${BlocProvider.of<WeeklyReportCubit>(context).endDateDayWord.tr()} ${BlocProvider.of<WeeklyReportCubit>(context).endDate.tr()}'
                .tr(),
            style: TextStyles.font16BlackRegular),
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
      ]),
    );
  }

  Widget buildPDFButtonAndExcelButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            onPressed: () {}),
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
                  label:
                      Text('id'.tr(), style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label:
                      Text('name'.tr(), style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('total price'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label:
                      Text('paid'.tr(), style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('quantity'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('remaining'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('saturday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('sunday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('monday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('tuesday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('wednesday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('thursday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('friday'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
            ],
            source: WeeklyReportTableData(
                state.allReportData.weeklyReportTableModel),
            columnSpacing: 15.w,
            horizontalMargin: 10.w,
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
}
