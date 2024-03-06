// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/features/Categories/data/model/categories_model.dart';
import 'package:shabacy_market/features/Categories/logic/cubit/categories_cubit.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/app_text_form_field_with_hint.dart';

class EditCategoriesButton extends StatefulWidget {
  final CategoriesModel categories;
  const EditCategoriesButton({required this.categories, super.key});

  @override
  State<EditCategoriesButton> createState() => _EditCategoriesButtonState();
}

class _EditCategoriesButtonState extends State<EditCategoriesButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                BlocProvider.of<CategoriesCubit>(context)
                    .editCategriesNameController
                    .text = widget.categories.name;
              });
              showDialog(
                  context: context,
                  builder: (_) => Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 400.h,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 30.h, right: 10.w, left: 10.w),
                              child: Material(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.h, vertical: 10.w),
                                  child: Form(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('editCategory'.tr(),
                                            style:
                                                TextStyles.font20BlackRegular),
                                        verticalSpace(10.h),
                                        AppTextFormFieldWithTopHint(
                                          topHintText: 'categoryName'.tr(),
                                          appTextFormField: AppTextFormField(
                                            controller: BlocProvider.of<
                                                    CategoriesCubit>(context)
                                                .editCategriesNameController,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 9.h,
                                                    horizontal: 10.w),
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
                                                backgroundColor:
                                                    ColorsManager.red,
                                                verticalPadding: 0,
                                                horizontalPadding: 0,
                                                buttonHeight: 30.h,
                                                buttonWidth: 60.w,
                                                buttonText: 'cancel'.tr(),
                                                textStyle: TextStyles
                                                    .font13WhiteSemiBold,
                                                onPressed: () {
                                                  context.pop();
                                                }),
                                            horizontalSpace(10),
                                            AppTextButton(
                                                verticalPadding: 0,
                                                horizontalPadding: 0,
                                                buttonHeight: 30.h,
                                                buttonWidth: 60.w,
                                                buttonText: 'edit'.tr(),
                                                textStyle: TextStyles
                                                    .font13WhiteSemiBold,
                                                onPressed: () {
                                                  editCategoryubmit();
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
            },
            child: const Icon(Icons.edit, color: ColorsManager.primryColor)),
        horizontalSpace(10),
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'sureDelete'.tr(),
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      content: Row(
                        children: [
                          Text(
                            '${'you sure delete item'.tr()} ',
                            style: TextStyles.font14BlackMedium,
                          ),
                          Text(
                            widget.categories.name.length <= 7
                                ? widget.categories.name
                                : widget.categories.name.substring(0, 7),
                            style: TextStyles.font14RedMedium,
                          ),
                          Text(
                            '?'.tr(),
                            style: TextStyles.font14BlackMedium,
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            'cancel'.tr(),
                            style: TextStyles.font14BlackMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteCategorySubmited();
                          },
                          child: Text(
                            'yes'.tr(),
                            style: TextStyles.font14RedMedium,
                          ),
                        )
                      ],
                    );
                  });
            },
            child: const Icon(Icons.delete, color: ColorsManager.red)),
      ],
    );
  }

  editCategoryubmit() {
    BlocProvider.of<CategoriesCubit>(context)
        .editCategoriesCubit(categoryId: widget.categories.id);
  }

  deleteCategorySubmited() {
    BlocProvider.of<CategoriesCubit>(context)
        .deleteCategoriesCubit(categoryId: widget.categories.id);
  }
}
