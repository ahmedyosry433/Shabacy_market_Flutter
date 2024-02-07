import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shabacy_market/core/theme/colors.dart';

class AppShowProgressIndecator extends StatelessWidget {
  const AppShowProgressIndecator({super.key});

  @override
  Widget build(BuildContext context) {
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
}
