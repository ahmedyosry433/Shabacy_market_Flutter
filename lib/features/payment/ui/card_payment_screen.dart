// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/networking/api_constants.dart';
import 'package:shabacy_market/core/router/routes.dart';
import 'package:shabacy_market/features/WeeklyReport/ui/weekly_report_screen.dart';
import 'package:shabacy_market/features/payment/logic/cubit/payment_cubit.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentCubit>(context).getClientSecretKeyToPayment(
      paid: 100,
      currentUserId: 'ahmed',
      category: 'ahmedddddd',
      amount: 100,
      price: 10 * 100,
      quantity: 10,
      supplierId: '12150',
    );
  }

  void startPayment(String clientSecret) {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
          url: WebUri(
        'https://accept.paymob.com/unifiedcheckout/?publicKey=${ApiConstants.publicKey}&clientSecret=$clientSecret',
      )),
    );
  }

  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }
        if (state is PaymentSuccess) {
          return InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              startPayment(state.clientSecretKey);
            },
            onProgressChanged: (controller, progress) {
              if (progress > 100) {
                showProgressIndecator(context);
                log(progress);
              }
            },
            onLoadStop: (controller, url) {
              if (url != null &&
                  url.queryParameters.containsKey('success') &&
                  url.queryParameters['success'] == 'true') {
                Future.delayed(const Duration(seconds: 10), () {
                  context.pushNamed(Routes.payment);
                });
              } else if (url != null &&
                  url.queryParameters.containsKey('success') &&
                  url.queryParameters['success'] == 'false') {}
            },
          );
        }
        if (state is PaymentFailure) {
          return Center(
            child: Text(state.message),
          );
        }

        return const SizedBox.shrink();
      },
    ));
  }
}
