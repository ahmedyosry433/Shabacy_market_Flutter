// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shabacy_market/core/theme/colors.dart';

import '../theme/style.dart';

class AppCustomDropDownFormButton extends StatelessWidget {
  List<DropdownMenuItem<String>>? items;
  Function(Object?)? onChanged;
  Object? value;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;

  final TextStyle? hintStyle;
  final String? hintText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  AppCustomDropDownFormButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyle,
    this.hintText,
    this.suffixIcon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: TextStyles.font14BlackMedium,
      elevation: 1,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: focusedBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.primryColor,
                width: 1,
              ),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.gray.withOpacity(0.2),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
        ),
        hintStyle: hintStyle ?? TextStyles.font14GrayMedium,
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: backgroundColor ?? ColorsManager.gray.withOpacity(0.01),
      ),
      items: items,
      onChanged: onChanged,
      value: value,
    );
  }
}
