//  Future<SuppliersModel> addNewSupplier(
//       {required AddSuppliersModel addSuppliersModel,
//       required String token}) async {
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };

//     Response response = await _dio.request(
//         ApiConstants.apiBaseUrl + ApiConstants.allSuppliersUrl,
//         data: addSuppliersModel,
//         options: Options(
//           method: 'POST',
//           headers: headers,
//         ));

//     return SuppliersModel.fromJson(response.data);
//   }

//   Future<void> deleteSupplier(
//       {required String token, required String suppliersId}) async {
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };

//     await _dio.request(
//         '${ApiConstants.apiBaseUrl}${ApiConstants.allSuppliersUrl}/$suppliersId',
//         options: Options(
//           method: 'DELETE',
//           headers: headers,
//         ));
//   }
///APISERVICE
//  var dropdownValue;

//   final AddNewSupplierFormKey = GlobalKey<FormState>();
//    TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();

//   void addNewSupplierCubit() async {
//     emit(SuppliersLoading());

//     try {
//       _suppliersRepo.addNewSupplierRepo(
//         addSuppliersModel: AddSuppliersModel(
//           nameController.text,
//           phoneController.text,
//           dropdownValue,
//         ),
//         token: await SharedPreferencesHelper.getValueForKey('token'),
//       );

//       emit(SuppliersLoaded());
//       nameController.clear();
//       phoneController.clear();
//       dropdownValue = '';
//     } catch (e) {
//       emit(SuppliersError(e.toString()));
//     }
//   }

//   void deleteSupplierCubit({required String suppliersId}) async {
//     emit(SuppliersLoading());
//     try {
//       _suppliersRepo.deleteSupplier(
//         token: await SharedPreferencesHelper.getValueForKey('token'),
//         suppliersId: suppliersId,
//       );
//       emit(SuppliersLoaded());
//     } catch (e) {
//       emit(SuppliersError(e.toString()));
//     }
//   }

///SUppliersCubit
///
//  Future<SuppliersModel> addNewSupplierRepo(
//       {required AddSuppliersModel addSuppliersModel,
//       required String token}) async {
//     final response = await apiService.addNewSupplier(
//         addSuppliersModel: addSuppliersModel, token: token);
//     return response;
//   }

//   Future<void> deleteSupplier(
//       {required String token, required String suppliersId}) async {
//     await apiService.deleteSupplier(token: token, suppliersId: suppliersId);
//   }

//SupplierREpo

// Widget buildAddNewSupplierBloc() {
//     return BlocBuilder<SuppliersCubit, SuppliersState>(
//       builder: (context, state) {
//         if (state is SuppliersLoading) {
//           return Padding(
//             padding: EdgeInsets.only(top: 250.h),
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         if (state is SuppliersLoaded) {
//           return buildAddNewSupplierBloc();
//         } else if (state is SuppliersError) {
//           return Text(state.message);
//         }
//         return const SizedBox();
//       },
//     );
//   }

////////////////////////////////////////////////////////
//  Widget buildAddNewSupplier() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//         child: Form(
//           key: context.read<SuppliersCubit>().AddNewSupplierFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('addNewSupplier'.tr(), style: TextStyles.font20BlackRegular),
//               verticalSpace(10.h),
//               AppTextFormFieldWithTopHint(
//                 topHintText: 'name'.tr(),
//                 appTextFormField: AppTextFormField(
//                   controller: context.read<SuppliersCubit>().nameController,
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
//                   hintText: 'enterName'.tr(),
//                   validator: (validator) {
//                     if (validator!.isEmpty || validator.length < 3) {
//                       return 'enterValidName'.tr();
//                     }
//                   },
//                   keyboardType: TextInputType.name,
//                 ),
//               ),
//               verticalSpace(10.h),
//               AppTextFormFieldWithTopHint(
//                 topHintText: 'phone'.tr(),
//                 appTextFormField: AppTextFormField(
//                   controller: context.read<SuppliersCubit>().phoneController,
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
//                   hintText: 'enterPhone'.tr(),
//                   validator: (validator) {
//                     if (validator!.isEmpty || validator.length < 10) {
//                       return 'enterValidPhone'.tr();
//                     }
//                   },
//                   keyboardType: TextInputType.phone,
//                 ),
//               ),
//               verticalSpace(10.h),
//               AppCustomDropdownWithTopHint(
//                 topHintText: 'delegate'.tr(),
//                 appCustomDropdown: AppCustomDropDownFormButton(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
//                   onChanged: (value) {
//                     setState(() {
//                       context.read<SuppliersCubit>().dropdownValue = value;
//                     });
//                   },
//                   items: BlocProvider.of<SuppliersCubit>(context)
//                       .users
//                       .map((value) {
//                     return DropdownMenuItem<String>(
//                       value: value.id.toString(),
//                       child: Text(value.name),
//                     );
//                   }).toList(),
//                   value: BlocProvider.of<SuppliersCubit>(context).dropdownValue,
//                 ),
//               ),
//               Row(
//                 children: [
//                   AppTextButton(
//                       backgroundColor: ColorsManager.red,
//                       verticalPadding: 0,
//                       horizontalPadding: 0,
//                       buttonHeight: 30.h,
//                       buttonWidth: 60.w,
//                       buttonText: 'cancel'.tr(),
//                       textStyle: TextStyles.font13WhiteSemiBold,
//                       onPressed: () {
//                         context.pop();
//                       }),
//                   horizontalSpace(10),
//                   AppTextButton(
//                       verticalPadding: 0,
//                       horizontalPadding: 0,
//                       buttonHeight: 30.h,
//                       buttonWidth: 60.w,
//                       buttonText: 'save'.tr(),
//                       textStyle: TextStyles.font13WhiteSemiBold,
//                       onPressed: () => saveNewSuppliers()),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   saveNewSuppliers() {
//     if (BlocProvider.of<SuppliersCubit>(context)
//         .AddNewSupplierFormKey
//         .currentState!
//         .validate()) {
//       BlocProvider.of<SuppliersCubit>(context)
//           .AddNewSupplierFormKey
//           .currentState!
//           .save();
//       BlocProvider.of<SuppliersCubit>(context).addNewSupplierCubit();
//       BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
//     }
//     context.pop();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     BlocProvider.of<SuppliersCubit>(context).nameController.dispose();
//     BlocProvider.of<SuppliersCubit>(context).phoneController.dispose();
//   }
// }

// class EditiAndDeleteButton extends StatelessWidget {
//   EditiAndDeleteButton({required this.supplierModel, super.key});
//   SuppliersModel supplierModel;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//             onTap: () {},
//             child: const Icon(Icons.edit, color: ColorsManager.primryColor)),
//         horizontalSpace(10),
//         GestureDetector(
//             onTap: () {
//               context
//                   .read<SuppliersCubit>()
//                   .deleteSupplierCubit(suppliersId: supplierModel.id);
//               BlocProvider.of<SuppliersCubit>(context).getAllSuppliersCubit();
//             },
//             child: const Icon(Icons.delete, color: ColorsManager.red)),
//       ],
//     );
//   }
/// UI
// class AddSuppliersModel {
//   final String name;
//   final String mobile;
//   final String admin;

//   AddSuppliersModel(this.name, this.mobile, this.admin);

//   factory AddSuppliersModel.fromJson(Map<String, dynamic> json) {
//     return AddSuppliersModel(
//       json['name'],
//       json['mobile'],
//       json['admin'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'mobile': mobile,
//       'admin': admin,
//     };
//   }
// }