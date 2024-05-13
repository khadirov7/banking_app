import 'package:banking_app/blocs/auth/auth_bloc.dart';
import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:banking_app/screens/auth/register_screen.dart';
import 'package:banking_app/screens/auth/widget/auth_item.dart';
import 'package:banking_app/screens/auth/widget/my_custom_button.dart';
import 'package:banking_app/screens/auth/widget/textfield_container.dart';
import 'package:banking_app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_utils/my_utils.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/user_profile/user_profile_event.dart';
import '../../data/models/forms_status.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isValidLoginCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
          AppConstants.textRegExp.hasMatch(usernameController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF1317DD),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 56.h),
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
                                style: AppTextStyle.interSemiBold.copyWith(
                                    fontSize: 22, color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        TextFieldContainer(
                          onChanged: (v) {
                            setState(() {});
                          },
                          regExp: AppConstants.textRegExp,
                          errorText: "Username not supported",
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: const Icon(Icons.person)
                          ),
                          hintText: "Username",
                          keyBoardType: TextInputType.text,
                          controller: usernameController,
                        ),
                        TextFieldContainer(
                          onChanged: (v) {
                            setState(() {});
                          },
                          isObscureText: true,
                          regExp: AppConstants.passwordRegExp,
                          errorText:
                          "Parolda 8 belgidan va 1 katta harfdan iborat bo'lishi kerak !",
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Icon(Icons.lock_open_outlined),
                          ),
                          hintText: "Password",
                          keyBoardType: TextInputType.text,
                          controller: passwordController,
                        ),
                        SizedBox(height: 55.h),
                        MyCustomButton(
                          onTap: () {
                            context.read<AuthBloc>().add(
                              LoginUserEvent(
                                username: usernameController.text,
                                password: passwordController.text,
                              ),
                            );
                          },
                          readyToSumbit: isValidLoginCredentials(),
                          isLoading: state.status == FormsStatus.loading,
                          title: "Login",
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Or",
                                style: AppTextStyle.interRegular.copyWith(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "Log in with",
                                style: AppTextStyle.interRegular.copyWith(
                                    fontSize: 14, color: Colors.white),
                              ),
                              SizedBox(height: 20.h),
                              IconButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.white)),
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(SignInWithGoogleEvent());
                                },
                                icon: SvgPicture.asset("assets/icons/google.svg"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                AuthItem(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  title: "Don’t have an account?",
                  subtitle: "Register now",
                  color: Colors.grey,
                  subColor: AppColors.white,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormsStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state.status == FormsStatus.authenticated) {
            if (state.statusMessage == "registered") {
              BlocProvider.of<UserProfileBloc>(context).add(
                AddUserEvent(state.userModel),
              );
            } else {
              BlocProvider.of<UserProfileBloc>(context)
                  .add(GetCurrentUserEvent(state.userModel.authUid));
            }

            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.setPinRoute,
                  (route) => false,
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}