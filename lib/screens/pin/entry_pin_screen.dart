import 'package:banking_app/data/local/storage_repository.dart';
import 'package:banking_app/screens/pin/widgets/custom_keyboard_view.dart';
import 'package:banking_app/screens/pin/widgets/pin_put_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:pinput/pinput.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../data/models/forms_status.dart';
import '../../services/biometric_services.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class EntryPinScreen extends StatefulWidget {
  const EntryPinScreen({super.key});


  @override
  State<EntryPinScreen> createState() => _EntryPinScreenState();
}

class _EntryPinScreenState extends State<EntryPinScreen> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;
  String currentPin='';
  bool  biometrics=false;
  int count=0;
  @override
  void initState() {
    biometrics=StorageRepository.getBool(key: 'biometrics');
    currentPin=StorageRepository.getString(key: 'pin');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50.h,),
          Text(
            "Pin kodni kiriting",
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
          Text((!isError) ? "" : "Pin kod noto'g'ri!",
            style: AppTextStyle.interBold.copyWith(
                color: Colors.red, fontSize: 16.w
            ),),
          SizedBox(height: 20.h,),
          CustomKeyboardView(
              number: (number) {
                if (pinController.length < 4) {
                  isError = false;
                  pinController.text += number;
                }
                if (pinController.length == 4) {
                  if (currentPin == pinController.text) {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.tabRoute);
                  }
                  else {
                    count+=1;
                    if(count==3){
                      context.read<AuthBloc>().add(LogOutUserEvent());
                    }
                    isError = true;
                    pinController.clear();
                  }
                }
                setState(() {});
              },
              isBiometric: biometrics,
              onClearButton: () {
                if (pinController.length > 0) {
                  pinController.text = pinController.text.substring(
                      0, pinController.text.length - 1);
                }
              },
              onFingerButton:checkBio
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == FormsStatus.unauthenticated) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.authRoute, (route) => false);
              }
            },
            child:const SizedBox(),
          )
        ],
      ),
    );
  }
  Future<void> checkBio()async{
    bool authenticated=await BiometricAuthService.authenticate();
    if(authenticated){
      if(!context.mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

}