import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shabacy_market/features/Suppliers/ui/widget/set_table_suppliers.dart';

import '../../../core/helper/extensions.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/app_coustom_loading_indecator.dart';
import '../../../core/widgets/app_custom_appbar.dart';
import '../../../core/widgets/app_custom_dropdwo_with_hint.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/app_text_form_field_with_hint.dart';
import '../../Suppliers/logic/cubit/suppliers_cubit.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_custom_dropdown.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
    BlocProvider.of<SuppliersCubit>(context).getAllUsersCubit();
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<SuppliersCubit>(context).nameController.dispose();
    BlocProvider.of<SuppliersCubit>(context).phoneController.dispose();
    BlocProvider.of<SuppliersCubit>(context).editNameController.dispose();
    BlocProvider.of<SuppliersCubit>(context).editPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DataTableSource data = MyData(
      context.watch<SuppliersCubit>().suppliers,
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
        buildAddNewAndTextButton(),
        buildAddNewSupplierListenerBloc(),
        buildTableBloc(data: data),
        buildEditSuppliersListenerBloc(),
        buildDeleteSuppliersListenerBloc(),
      ],
    ),
      ),
    );
  }

  Widget buildTableBloc({required DataTableSource data}) {
    return BlocBuilder<SuppliersCubit, SuppliersState>(
      builder: (context, state) {
        if (state is SuppliersLoading) {
          return const AppCustomLoadingIndecator();
        }
        if (state is SuppliersLoaded) {
          return Column(
            children: [
              PaginatedDataTable(
                arrowHeadColor: ColorsManager.primryColor,
                columns: [
                  DataColumn(
                      label: Text('id'.tr(),
                          style: TextStyles.font14BlackSemiBold)),
                  DataColumn(
                      label: Text('name'.tr(),
                          style: TextStyles.font14BlackSemiBold)),
                  DataColumn(
                      label: Text('phone'.tr(),
                          style: TextStyles.font14BlackSemiBold)),
                  DataColumn(
                      label: Text('balance'.tr(),
                          style: TextStyles.font14BlackSemiBold)),
                  DataColumn(
                      label: Text('delegate'.tr(),
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
          );
        } else if (state is SuppliersError) {
          return Text(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget buildAddNewSupplierBloc() {
    return BlocBuilder<SuppliersCubit, SuppliersState>(
      builder: (context, state) {
        if (state is SuppliersLoading) {
          return const AppCustomLoadingIndecator();
        }
        if (state is SuppliersLoaded) {
          return buildAddNewSupplierForm();
        } else if (state is SuppliersError) {
          return Text(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget buildAddNewAndTextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('suppliersList'.tr(), style: TextStyles.font16BlackSemiBold),
          AppTextButton(
              buttonHeight: 40.h,
              buttonWidth: 100.w,
              backgroundColor: ColorsManager.primryColor,
              buttonText: 'addNewSupplier'.tr(),
              textStyle: TextStyles.font13WhiteSemiBold,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => SizedBox(
                          height: 800.h,
                          child: buildAddNewSupplierForm(),
                        ));
              })
        ],
      ),
    );
  }

  Widget buildAddNewSupplierForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Form(
          key: BlocProvider.of<SuppliersCubit>(context).addNewSupplierFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('addNewSupplier'.tr(), style: TextStyles.font20BlackRegular),
              verticalSpace(10.h),
              AppTextFormFieldWithTopHint(
                topHintText: 'name'.tr(),
                appTextFormField: AppTextFormField(
                  controller: context.read<SuppliersCubit>().nameController,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  hintText: 'enterName'.tr(),
                  validator: (validator) {
                    if (validator!.isEmpty || validator.length < 3) {
                      return 'enterValidName'.tr();
                    }
                  },
                  keyboardType: TextInputType.name,
                ),
              ),
              verticalSpace(10.h),
              AppTextFormFieldWithTopHint(
                topHintText: 'phone'.tr(),
                appTextFormField: AppTextFormField(
                  controller: context.read<SuppliersCubit>().phoneController,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  hintText: 'enterPhone'.tr(),
                  validator: (validator) {
                    if (validator!.isEmpty || validator.length < 10) {
                      return 'enterValidPhone'.tr();
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
              verticalSpace(10.h),
              AppCustomDropdownWithTopHint(
                topHintText: 'delegate'.tr(),
                appCustomDropdown: AppCustomDropDownFormButton(
                  validator: (validator) {
                    if (validator == null) {
                      return 'selectDelegate'.tr();
                    }
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  onChanged: (value) {
                    setState(() {
                      context.read<SuppliersCubit>().dropdownValue = value;
                    });
                  },
                  items: BlocProvider.of<SuppliersCubit>(context)
                      .users
                      .map((value) {
                    return DropdownMenuItem<String>(
                      value: value.id.toString(),
                      child: Text(value.name),
                    );
                  }).toList(),
                  value: BlocProvider.of<SuppliersCubit>(context).dropdownValue,
                ),
              ),
              Row(
                children: [
                  AppTextButton(
                      backgroundColor: ColorsManager.red,
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      buttonHeight: 30.h,
                      buttonWidth: 60.w,
                      buttonText: 'cancel'.tr(),
                      textStyle: TextStyles.font13WhiteSemiBold,
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
                      textStyle: TextStyles.font13WhiteSemiBold,
                      onPressed: () => saveNewSuppliers()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddNewSupplierListenerBloc() {
    return BlocListener<SuppliersCubit, SuppliersState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AddSuppliersLoading) {
          showProgressIndecator(context);
        } else if (state is AddSuppliersLoaded) {
          context.pop();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "add supplier successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          context.pop();
        } else if (state is AddSuppliersError) {
          context.pop();

          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error adding supplier ".tr(),
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
      content: Center(
        child: AppCustomLoadingIndecator(),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) => alertDialog);
    return alertDialog;
  }

  saveNewSuppliers() {
    if (BlocProvider.of<SuppliersCubit>(context)
        .addNewSupplierFormKey
        .currentState!
        .validate()) {
      BlocProvider.of<SuppliersCubit>(context)
          .addNewSupplierFormKey
          .currentState!
          .save();
      BlocProvider.of<SuppliersCubit>(context).addNewSupplierCubit();
      BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
    }
  }

  Widget buildEditSuppliersListenerBloc() {
    return BlocListener<SuppliersCubit, SuppliersState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is EditSuppliersLoading) {
          showProgressIndecator(context);
        } else if (state is EditSuppliersLoaded) {
          Navigator.of(context).pop();
          BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
          MotionToast.success(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "edit supplier successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
          Navigator.of(context).pop();
        } else if (state is EditSuppliersError) {
          Navigator.of(context).pop();

          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error updating supplier ".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget buildDeleteSuppliersListenerBloc() {
    return BlocListener<SuppliersCubit, SuppliersState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is DeleteSuppliersLoading) {
          showProgressIndecator(context);
        } else if (state is DeleteSuppliersLoaded) {
          context.pop();
          BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
          MotionToast.success(
            position: MotionToastPosition.top,
            iconSize: 30.w,
            width: 500.w,
            height: 80.h,
            description: Row(
              children: [
                Text(
                  "delete supplier successfully".tr(),
                  style: TextStyles.font14BlackSemiBold,
                ),
                Text(
                  '',
                  style: TextStyles.font14RedMedium,
                ),
              ],
            ),
          ).show(context);
          context.pop();
        } else if (state is DeleteSuppliersError) {
          context.pop();
          MotionToast.error(
            width: 390.w,
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            description: Text(
              "error deleting supplier ".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}