import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field_with_hint.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_text_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('login'.tr(), style: TextStyles.font25BlackSemiBold),
                verticalSpace(40),
                AppTextFormFieldWithTopHint(
                  topHintText: 'email'.tr(),
                  appTextFormField: AppTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'john.doe@example.com',
                    validator: (value) {},
                  ),
                ),
                verticalSpace(20),
                AppTextFormFieldWithTopHint(
                  topHintText: 'password'.tr(),
                  appTextFormField: AppTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    isObscureText: true,
                    hintText: '************',
                    validator: (value) {},
                  ),
                ),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (onChanged) {}),
                    Text('remember_me'.tr(),
                        style: TextStyles.font14BlackSemiBold),
                  ],
                ),
                verticalSpace(40),
                AppTextButton(
                  buttonText: 'login'.tr(),
                  onPressed: () =>
                      context.pushReplacementNamed(Routes.homeScreen),
                  textStyle: TextStyles.font14WhiteMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
