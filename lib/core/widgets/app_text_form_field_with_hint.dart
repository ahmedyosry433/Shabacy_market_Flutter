// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../helper/spacing.dart';
import '../theme/style.dart';
import 'app_text_form_field.dart';

class AppTextFormFieldWithTopHint extends StatelessWidget {
  AppTextFormFieldWithTopHint({
    super.key,
    required this.topHintText,
    required this.appTextFormField,
  });
  String topHintText;
  AppTextFormField appTextFormField;

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
        appTextFormField,
      ],
    );
  }
}
