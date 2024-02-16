import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shabacy_market/core/theme/colors.dart';

class AppCustomLoadingIndecator extends StatelessWidget {
  const AppCustomLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 150.w),
      child: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: ColorsManager.primryColor,
          size: 80,
        ),
      ),
    );
  }
}
