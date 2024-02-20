import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../core/helper/extensions.dart';
import '../../../core/widgets/app_coustom_loading_indecator.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppCustomAppbar(
              profileStyle:
                  TextStyles.font11BlackSemiBold.copyWith(fontSize: 0),
            ),
            buildAddNewCategoriesAndTextButton(),
            buildAddNewCategoriesLisenerBloc(),
            buildEditCategorieListenersBloc(),
            buildTableBloc(data: data),
          ],
        ),
      ),
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

  Widget buildTableBloc({required DataTableSource data}) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const AppCustomLoadingIndecator();
        } else if (state is CategoriesLoaded) {
          return buildUsersTable(source: data);
        } else if (state is CategoriesError) {
          return Text(state.message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget buildEditCategorieListenersBloc() {
    return BlocListener<CategoriesCubit, CategoriesState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is EditCategoryLoading) {
          showProgressIndecator(context);
        } else if (state is EditCategoryLoaded) {
          Navigator.of(context).pop();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "edit category successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          BlocProvider.of<CategoriesCubit>(context).getAllCategoriesCubit();
          Navigator.of(context).pop();
        } else if (state is EditCategoryError) {
          Navigator.of(context).pop();

          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error updating category".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          BlocProvider.of<CategoriesCubit>(context).getAllCategoriesCubit();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget buildAddNewCategoriesLisenerBloc() {
    return BlocListener<CategoriesCubit, CategoriesState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AddCategoryLoading) {
          showProgressIndecator(context);
        } else if (state is AddCategoryLoaded) {
          context.pop();
          BlocProvider.of<CategoriesCubit>(context).getAllCategoriesCubit();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "add category successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          context.pop();
        } else if (state is AddCategoryError) {
          context.pop();

          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error adding category".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget showProgressIndecator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: AppCustomLoadingIndecator());
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) => alertDialog);
    return alertDialog;
  }

  saveCategories() {
    if (BlocProvider.of<CategoriesCubit>(context)
        .addCategriesFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<CategoriesCubit>(context).addNewCategoriesCubit();
    }
  }
}
