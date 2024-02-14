import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/extensions.dart';
import '../../../core/widgets/app_custom_appbar.dart';
import 'widget/set_Categories_table.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/app_text_form_field_with_hint.dart';
import '../logic/cubit/categories_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getAllCategoriesCubit();
  }

  @override
  Widget build(BuildContext context) {
    final DataTableSource data = CategoriesTableData(
      context.watch<CategoriesCubit>().categoriesList,
    );
    return Scaffold(
      backgroundColor: ColorsManager.backGroundColor,
      body: SafeArea(
          child: Column(
        children: [
          AppCustomAppbar(
            profileStyle: TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
          ),
          buildAddNewCategoriesAndTextButton(),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (state is CategoriesLoaded) {
                return buildUsersTable(source: data);
              } else if (state is CategoriesError) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            },
          )
        ],
      )),
    );
  }

  Widget buildAddNewCategoriesAndTextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('categoriesList'.tr(), style: TextStyles.font19BlackSemiBold),
          AppTextButton(
              verticalPadding: 0,
              horizontalPadding: 0,
              buttonHeight: 40.h,
              buttonWidth: 100.w,
              backgroundColor: ColorsManager.primryColor,
              buttonText: 'addNewCategory'.tr(),
              textStyle: TextStyles.font13WhiteSemiBold,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => SizedBox(
                          height: 400.h,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Form(
                                key: context
                                    .read<CategoriesCubit>()
                                    .addCategriesFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('addNewCategory'.tr(),
                                        style: TextStyles.font20BlackRegular),
                                    verticalSpace(10.h),
                                    AppTextFormFieldWithTopHint(
                                      topHintText: 'categoryName'.tr(),
                                      appTextFormField: AppTextFormField(
                                        controller: context
                                            .read<CategoriesCubit>()
                                            .addCategriesNameController,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 9.h, horizontal: 10.w),
                                        hintText: 'enterCategoryName'.tr(),
                                        validator: (validator) {
                                          if (validator!.isEmpty ||
                                              validator.length < 3) {
                                            return 'enterVaildCategoryName'
                                                .tr();
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    verticalSpace(10.h),
                                    Row(
                                      children: [
                                        AppTextButton(
                                            backgroundColor: ColorsManager.red,
                                            verticalPadding: 0,
                                            horizontalPadding: 0,
                                            buttonHeight: 30.h,
                                            buttonWidth: 60.w,
                                            buttonText: 'cancel'.tr(),
                                            textStyle:
                                                TextStyles.font13WhiteSemiBold,
                                            onPressed: () {
                                              context.pop();
                                            }),
                                        horizontalSpace(10),
                                        AppTextButton(
                                            verticalPadding: 0,
                                            horizontalPadding: 0,
                                            buttonHeight: 30.h,
                                            buttonWidth: 60.w,
                                            buttonText: 'save'.tr(),
                                            textStyle:
                                                TextStyles.font13WhiteSemiBold,
                                            onPressed: () {
                                              saveCategories();
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              })
        ],
      ),
    );
  }

  Widget buildUsersTable({required DataTableSource source}) {
    return PaginatedDataTable(
      arrowHeadColor: ColorsManager.primryColor,
      columns: [
        DataColumn(
            label: Text('id'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('name'.tr(), style: TextStyles.font14BlackSemiBold)),
        DataColumn(
            label: Text('control'.tr(), style: TextStyles.font14BlackSemiBold)),
      ],
      source: source,
      columnSpacing: 90.w,
      horizontalMargin: 20.w,
      rowsPerPage: 6,
    );
  }

  saveCategories() {
    if (BlocProvider.of<CategoriesCubit>(context)
        .addCategriesFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<CategoriesCubit>(context).addNewCategoriesCubit();
      BlocProvider.of<CategoriesCubit>(context).getAllCategoriesCubit();
      context.pop();
    }
  }
}
