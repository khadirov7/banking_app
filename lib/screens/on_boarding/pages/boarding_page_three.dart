import 'package:flutter/material.dart';
import '../../../utils/images/app_images.dart';


class BoardingPageThree extends StatelessWidget {
  const BoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/metrics.png', height: 200),
            const SizedBox(height: 20),
            const Text(
              'Secure Transactions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Experience secure and encrypted transactions with our advanced security features.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}