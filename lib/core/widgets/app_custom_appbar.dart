// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';

import '../helper/shared_preferences_helper.dart';
import '../helper/spacing.dart';
import '../router/routes.dart';
import '../theme/colors.dart';
import '../theme/style.dart';

class AppCustomAppbar extends StatelessWidget {
  AppCustomAppbar({super.key, this.profileStyle, this.homeStyle});
  TextStyle? profileStyle;
  TextStyle? homeStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 70.h,
      color: ColorsManager.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('bussnisName'.tr(), style: TextStyles.font16BlackSemiBold),
        Row(
          children: [
            GestureDetector(
                onTap: () => context.pushNamed(Routes.homeScreen),
                child: Text('home'.tr(),
                    style: homeStyle ?? TextStyles.font14GrayMedium)),
            horizontalSpace(10),
            GestureDetector(
                onTap: () => context.pushNamed(Routes.profileScreen),
                child: Text('profile'.tr(),
                    style: profileStyle ?? TextStyles.font14GrayMedium)),
            horizontalSpace(10),
            GestureDetector(
              onTap: () async {
                context.pushReplacementNamed(Routes.loginScreen);

                SharedPreferencesHelper.removeValueForKey('token');
              },
              child: Text('logout'.tr(),
                  style: TextStyles.font14GrayMedium
                      .copyWith(color: ColorsManager.primryColor.shade300)),
            ),
          ],
        ),
      ]),
    );
  }
}
// Widget buildDropDown(BuildContext context) {
//     String dropdownvalue = 'Item 1';
//     var items = [
//       'Item 1',
//       'Item 2',
//       'Item 3',
//       'Item 4',
//       'Item 5',
//     ];
//     return DropdownButton(
//       elevation: 0,
//       style: TextStyles.font14GrayMedium,
//       underline: const SizedBox(),
//       value: dropdownvalue,
//       icon: const Icon(Icons.keyboard_arrow_down),

//       // items: [
//       //   DropdownMenuItem(
//       //     child: Text('logout'.tr(),
//       //         style: TextStyles.font14GrayMedium
//       //             .copyWith(color: ColorsManager.primryColor.shade300)),
//       //   ),
//       //   DropdownMenuItem(
//       //     child: Text('profile'.tr(),
//       //         style: profileStyle ?? TextStyles.font14GrayMedium),
//       //   )
//       // ],
//       items: items.map(( items) {
//         return DropdownMenuItem(
//           value: items,
//           child: Text(items),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           dropdownvalue = value!;
//         });
//       },
//     );
//   }