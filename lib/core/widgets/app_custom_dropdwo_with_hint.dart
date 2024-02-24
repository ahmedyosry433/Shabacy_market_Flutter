// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shabacy_market/core/widgets/app_custom_dropdown.dart';

import '../helper/spacing.dart';
import '../theme/style.dart';

class AppCustomDropdownWithTopHint extends StatelessWidget {
  AppCustomDropdownWithTopHint({
    super.key,
    required this.topHintText,
    required this.appCustomDropdown,
  });
  String topHintText;
  AppCustomDropDownFormButton appCustomDropdown;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(topHintText,
              style: TextStyles.font14BlackSemiBold
                  .copyWith(height: 2, fontWeight: FontWeight.w400)),
        ),
        verticalSpace(10),
        appCustomDropdown,
      ],
    );
  }
}
