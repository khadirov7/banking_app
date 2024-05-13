import 'package:banking_app/screens/auth/widget/auth_item.dart';
import 'package:banking_app/screens/auth/widget/my_custom_button.dart';
import 'package:banking_app/screens/auth/widget/textfield_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../data/models/forms_status.dart';
import '../../data/models/user_model.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/styles/app_text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36.h),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/banking1.png",
                        height: 180.h,
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        "Sign Up",
                        style:
                        AppTextStyle.interSemiBold.copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                TextFieldContainer(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Icon(Icons.person),
                  ),
                  hintText: "First Name",
                  keyBoardType: TextInputType.text,
                  controller: usernameController,
                ),
                TextFieldContainer(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Icon(Icons.person),
                  ),
                  hintText: "Last Name",
                  keyBoardType: TextInputType.text,
                  controller: lastnameController,
                ),
                TextFieldContainer(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Icon(Icons.person),
                  ),
                  hintText: "Phone",
                  keyBoardType: TextInputType.phone,
                  controller: phoneController,
                ),
                TextFieldContainer(
                  regExp: AppConstants.passwordRegExp,
                  errorText:
                  "Parolda 8 belgidan va 1 katta harfdan iborat bo'lishi kerak !",
                  isObscureText: true,
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                    child: const Icon(Icons.lock_open_outlined),
                  ),
                  hintText: "Password",
                  keyBoardType: TextInputType.text,
                  controller: passwordController1,
                ),
                TextFieldContainer(
                  regExp: AppConstants.passwordRegExp,
                  errorText:
                  "Parolda 8 belgidan va 1 katta harfdan iborat bo'lishi kerak !",
                  isObscureText: true,
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                    child: const Icon(Icons.lock_open_outlined),
                  ),
                  hintText: "Confirm Password",
                  keyBoardType: TextInputType.text,
                  controller: passwordController2,
                ),
                SizedBox(height: 22.h),
                MyCustomButton(
                  onTap: () {
                    if (isValidRegisterCredentials()) {
                      context.read<AuthBloc>().add(
                        RegisterUserEvent(
                          userModel: UserModel(
                            password: passwordController1.text,
                            email: "${usernameController.text.toLowerCase()}@gmail.com",
                            imageUrl: "",
                            fullName: lastnameController.text,
                            phoneNumber: phoneController.text.trim(),
                            userId: "",
                            username: usernameController.text,
                            fcm: "",
                            authUid: "",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Parrolar mos emas")));
                      return;
                    }
                  },
                  readyToSumbit: true,
                  isLoading: state.status == FormsStatus.loading,
                  title: "Register",
                ),
                SizedBox(height: 20.h),
                AuthItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: "",
                  subtitle: "Login now",
                  color: Color(0xFF1317DD),
                  subColor: Color(0xFF1317DD),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool isValidRegisterCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController1.text) &&
          AppConstants.textRegExp.hasMatch(usernameController.text) &&
          AppConstants.textRegExp.hasMatch(lastnameController.text) &&
          AppConstants.phoneRegExp.hasMatch(phoneController.text) &&
          (passwordController1.text == passwordController2.text);

  @override
  void dispose() {
    passwordController1.dispose();
    usernameController.dispose();
    phoneController.dispose();
    lastnameController.dispose();
    super.dispose();
  }
}