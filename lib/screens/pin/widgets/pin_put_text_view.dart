import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPutTextView extends StatelessWidget {
  const PinPutTextView({
    super.key,
    required this.pinPutFocusNode,
    required this.pinPutController,
    required this.isError,
    this.anCompleted,
  });

  final FocusNode pinPutFocusNode;
  final TextEditingController pinPutController;
  final bool isError;
  final ValueChanged<String>? anCompleted;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme=PinTheme(
        width:42,
        height:42,
        textStyle:TextStyle(
            fontSize: 36,
            color: Theme.of(context).textTheme.displayLarge?.color
        )
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.38,
      child: Pinput(
        useNativeKeyboard: false,
        showCursor: false,
        length: 4,
        onCompleted:anCompleted,
        defaultPinTheme: defaultPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        errorPinTheme: PinTheme(
          width: 42,
          height: 42,
          textStyle: TextStyle(
              fontSize: 36,color:Color(0xFF2A3256),
          ),
        ),
        preFilledWidget: Container(
          margin:const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey
          ),
        ),
        obscureText: true,
        obscuringWidget: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isError?
              Colors.red:Colors.black

          ),
        ),
        followingPinTheme: defaultPinTheme,
        pinAnimationType: PinAnimationType.scale,
      ),
    );
  }
}