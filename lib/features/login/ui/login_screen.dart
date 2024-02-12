import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/helper/spacing.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field.dart';
import 'package:shabacy_market/core/widgets/app_text_form_field_with_hint.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_text_button.dart';
import '../logic/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: InkWell(
            onTap: () => FocusScope.of(context).unfocus(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 25.h),
              child: Form(
                key: context.read<LoginCubit>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('login'.tr(), style: TextStyles.font25BlackSemiBold),
                    verticalSpace(40),
                    AppTextFormFieldWithTopHint(
                      topHintText: 'email'.tr(),
                      appTextFormField: AppTextFormField(
                        controller: context.read<LoginCubit>().emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'enterEmail'.tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enterValidEmail'.tr();
                          }
                        },
                      ),
                    ),
                    verticalSpace(20),
                    AppTextFormFieldWithTopHint(
                      topHintText: 'password'.tr(),
                      appTextFormField: AppTextFormField(
                        controller:
                            context.read<LoginCubit>().passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        isObscureText: true,
                        hintText: 'enterPassword'.tr(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'enterVaildPassword'.tr();
                          }
                        },
                      ),
                    ),
                    verticalSpace(40),
                    AppTextButton(
                      buttonText: 'login'.tr(),
                      onPressed: () => login(context),
                      textStyle: TextStyles.font14WhiteMedium,
                    ),
                    buildLoginBloc(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginBloc() {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is LoginLoading) {
          showProgressIndecator(context);
        } else if (state is LoginSuccess) {
          context.pop();
          context.pushReplacementNamed(Routes.homeScreen);
        } else if (state is LoginError) {
          context.pop();
          String errorMsg = (state).errorMsg.toString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: ColorsManager.black,
              duration: const Duration(seconds: 3),
            ),
          );
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
        child: CircularProgressIndicator(
          color: ColorsManager.black,
          valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) => alertDialog);
    return alertDialog;
  }

  void login(BuildContext context) {
    if (BlocProvider.of<LoginCubit>(context).formKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).formKey.currentState!.save();
      BlocProvider.of<LoginCubit>(context).emailLoginState();
    }
  }
}
