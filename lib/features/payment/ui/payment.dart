import 'package:flutter/material.dart';
import 'package:shabacy_market/core/helper/extensions.dart';
import 'package:shabacy_market/core/router/routes.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Row(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.paymentScreen);
                },
                child: const Text('Card')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.paymentScreen);
                },
                child: const Text('ValU')),
          ),
        ],
      ),
    );
  }
}
