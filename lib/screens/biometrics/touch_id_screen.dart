import 'package:banking_app/data/local/storage_repository.dart';
import 'package:banking_app/screens/routes.dart';
import 'package:banking_app/services/biometric_services.dart';
import 'package:flutter/material.dart';

class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enable Biometric Authentication"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: 150,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Text(
              "Barmoq izi olrqali kirishni faollashtiring yoki tashlab keting",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: enabledBio,
              child: const Text(
                "Enable Biometric",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.tabRoute,
                      (route) => false,
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> enabledBio() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(
        key: 'biometrics',
        value: true,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Biometric authentication enabled")),
      );
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Biometric authentication failed")),
      );
    }

    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.tabRoute,
          (route) => false,
    );
  }
}
