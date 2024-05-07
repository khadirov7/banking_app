import 'package:flutter/material.dart';

import '../../../utils/images/app_images.dart';

class BoardingPageTwo extends StatelessWidget {
  const BoardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/card.png', height: 200),
            const SizedBox(height: 20),
            const Text(
              'Track Your Expenses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Keep track of your daily expenses and manage your budget with ease.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}