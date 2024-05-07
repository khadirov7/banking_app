import 'package:banking_app/screens/pin/widgets/custom_keyboard_view.dart';
import 'package:banking_app/screens/pin/widgets/pin_put_text_view.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:pinput/pinput.dart';

import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          SizedBox(
            height: height / 6,
          ),
          Text(
            "Pin Kodni o'rnating!",
            style: AppTextStyle.interSemiBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: width / 2,
            child: PinPutTextView(
              isError: isError,
              pinPutFocusNode: focusNode,
              pinPutController: pinPutController,
            ),
          ),
          SizedBox(height: 32.h),
          CustomKeyboardView(
            onFingerButton: () {},
            number: (number) {
              if (pinPutController.length < 4) {
                pinPutController.text = "${pinPutController.text}$number";
              }

              if (pinPutController.length == 4) {
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.confirmPinRoute,
                  arguments: pinPutController.text,
                );

                pinPutController.text = "";
              }
            },
            isBiometric: false,
            onClearButton: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text.substring(
                  0,
                  pinPutController.text.length - 1,
                );
              }
            },
          )
        ]));
  }
}
