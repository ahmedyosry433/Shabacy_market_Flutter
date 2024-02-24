import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../core/helper/extensions.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/widgets/app_coustom_loading_indecator.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/app_text_form_field_with_hint.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/app_text_button.dart';
import '../logic/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 55.h),
            child: Form(
              key: context.read<LoginCubit>().formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Image.asset(
                            'assets/image/logo_without_background_and_name.png',
                            height: 50.h,
                            width: 50.w),
                        Text('bussnisName'.tr(),
                            style: TextStyles.font12BlackRegular),
                      ],
                    ),
                  ),
                  Text('login'.tr(), style: TextStyles.font19BlackSemiBold),
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
                      controller: context.read<LoginCubit>().passwordController,
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
          MotionToast.success(
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            animationCurve: Curves.easeOutExpo,
            width: 390.w,
            description: Text(
              "login successfully".tr(),
              style: TextStyles.font14BlackSemiBold,
            ),
          ).show(context);
        } else if (state is LoginError) {
          context.pop();

          MotionToast.error(
            position: MotionToastPosition.top,
            iconSize: 30.w,
            height: 70.h,
            animationCurve: Curves.easeOutExpo,
            description: Text(
              "Wrong email or password".tr(),
              style: TextStyles.font11BlackSemiBold,
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
      content: Center(child: AppCustomLoadingIndecator()),
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
