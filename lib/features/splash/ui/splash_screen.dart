// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/features/Login/ui/login_screen.dart';

import '../../../core/helper/shared_preferences_helper.dart';
import '../../../core/router/routes.dart';
import '../../Home/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  String token = '';
  @override
  void initState() {
    super.initState();
    gettoken();
    splashAnimation();
  }

  void gettoken() async {
    token = await SharedPreferencesHelper.getValueForKey('token');
  }

  void splashAnimation() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward()
          ..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final token = SharedPreferencesHelper.getValueForKey('token');
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3), () async {
        context.pushNamedAndRemoveUntil(Routes.homeScreen,
            predicate: (context) => false);
      }),
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              height: 250.h,
              width: 250.w,
              child: Lottie.asset('assets/image/splash.json',
                  //   fit: BoxFit.contain,color: Colors.white,
                  animate: true,
                  controller: controller,
                  ),
            ),
          ),
        );
      },
    );
  }
}
