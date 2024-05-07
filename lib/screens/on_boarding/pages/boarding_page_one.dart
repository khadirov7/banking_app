import 'package:flutter/material.dart';


class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/banking1.png', height: 200), // Ilova haqida surat
            const SizedBox(height: 20),
            const Text(
              'Welcome to Bank app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Experience the best banking solutions with our app. Manage your finances, make payments, and more.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}