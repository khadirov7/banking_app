import 'package:banking_app/screens/pin/widgets/custom_keyboard_view.dart';
import 'package:banking_app/screens/pin/widgets/pin_put_text_view.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:pinput/pinput.dart';

import '../../data/local/storage_repository.dart';
import '../../services/biometric_services.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.pin});

  final String pin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;
  bool biometric=false;
  @override
  void initState() {
    BiometricAuthService.canAuthenticated().then((value){
      if(value){
        biometric=true;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50.h,),
          Text(
            "Pin Kodni qaytadan kiriting",
            style: AppTextStyle.interSemiBold
                .copyWith(color: AppColors.black, fontSize: 18.w),
          ),
          SizedBox(height: 30.h,),
          SizedBox(
            width: width / 2,
            child: PinPutTextView(
              pinPutFocusNode: focusNode,
              pinPutController: pinController,
              isError: isError,
            ),
          ),
          SizedBox(height: 10.h,),
          Text((!isError) ? "" : "Pin oldingisi bilan mos emas",
            style: AppTextStyle.interBold.copyWith(
                color: Colors.red, fontSize: 16.w
            ),),
          SizedBox(height: 20.h,),
          CustomKeyboardView(
            number: (number) {
              if (pinController.length < 4) {
                isError=false;
                pinController.text += number;
              }
              if (pinController.length == 4) {
                if (widget.pin == pinController.text) {
                  _setPin(pinController.text);
                }
                else {
                  isError = true;
                  pinController.clear();
                }
              }
              setState(() {});
            },
            isBiometric: false,
            onClearButton: () {
              if (pinController.length > 0) {
                pinController.text = pinController.text.substring(
                    0, pinController.text.length - 1);
              }
            },
            onFingerButton: () {

            },
          )
        ],
      ),
    );
  }

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(key: 'pin', value: pin);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, (biometric)?RouteNames.touchIdRoute:RouteNames.tabRoute,(route)=>false);

  }

}