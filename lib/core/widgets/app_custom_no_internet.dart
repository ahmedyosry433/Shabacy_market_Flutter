import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/style.dart';

class AppCustomNoInternet extends StatelessWidget {
  const AppCustomNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/image/no_connection.png'),
          const SizedBox(height: 40),
          Text(
            'no internet connection'.tr(),
            style: TextStyles.font20BlackRegular,
          )
        ],
      ),
    );
  }
}