import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {super.key,
        required this.onTap,
        this.readyToSumbit = true,
        this.isLoading = false,
        required this.title});

  final VoidCallback onTap;
  final bool readyToSumbit;
  final bool isLoading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 15),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
          ),
          onPressed: readyToSumbit ? onTap : null,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18.15,
                fontFamily: "SF Pro Rounded",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
