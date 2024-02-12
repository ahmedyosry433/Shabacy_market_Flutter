import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/widgets/app_custom_appbar.dart';
import 'package:shabacy_market/features/Users/logic/cubit/users_cubit.dart';
import 'package:shabacy_market/features/Users/ui/widgets/set_users_table.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_text_button.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    BlocProvider.of<UsersCubit>(context).getAllUsersCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataTableSource data = MyData(
      context.watch<UsersCubit>().users,
    );
    return Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SafeArea(
          child: Column(
        children: [
          AppCustomAppbar(),
          buildAddNewUserAndTextButton(),
          PaginatedDataTable(
            arrowHeadColor: ColorsManager.primryColor,
            columns: [
              DataColumn(
                  label:
                      Text('id'.tr(), style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label:
                      Text('name'.tr(), style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('email'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('typeOfUser'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
              DataColumn(
                  label: Text('control'.tr(),
                      style: TextStyles.font14BlackSemiBold)),
            ],
            source: data,
            columnSpacing: 45.w,
            horizontalMargin: 20.w,
            rowsPerPage: 6,
          ),
        ],
      )),
    );
  }

  Widget buildAddNewUserAndTextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('usersList'.tr(), style: TextStyles.font16BlackSemiBold),
          AppTextButton(
              buttonHeight: 40.h,
              buttonWidth: 100.w,
              backgroundColor: ColorsManager.primryColor,
              buttonText: 'addUser'.tr(),
              textStyle: TextStyles.font13WhiteSemiBold,
              onPressed: () {})
        ],
      ),
    );
  }
}
