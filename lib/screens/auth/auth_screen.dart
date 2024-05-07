import 'package:banking_app/blocs/auth/auth_bloc.dart';
import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/user_profile/user_porfile_event.dart';
import 'package:banking_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:banking_app/data/models/forms_status_model.dart';
import 'package:banking_app/screens/auth/register_screen.dart';
import 'package:banking_app/screens/auth/widget/my_custom_button.dart';
import 'package:banking_app/screens/pin/set_pin_screen.dart';
import 'package:banking_app/screens/tab/tab_screen.dart';
import 'package:banking_app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../blocs/auth/auth_state.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidLoginCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
      AppConstants.textRegExp.hasMatch(emailController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
        return ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 44.0, vertical: 20),
                    child: Image.asset(
                      "assets/images/banking1.png",
                      width: 220,
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.15,
                        fontFamily: "SF Pro Rounded",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Username'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (v) {
                        setState(() {});
                      },
                      validator: (v) {
                        if (v != null && AppConstants.textRegExp.hasMatch(v)) {
                          return null;
                        }
                        return "Username error";
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_open_outlined,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (v) {
                        setState(() {});
                      },
                      validator: (v) {
                        if (v != null &&
                            AppConstants.passwordRegExp.hasMatch(v)) {
                          return null;
                        }
                        return "Password error";
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: "SF Pro Rounded",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: MyCustomButton(
                      onTap: () {
                        context.read<AuthBloc>().add(LoginUserEvent(
                            password: passwordController.text,
                            username: emailController.text));
                      },
                      title: "LOGIN",
                      readyToSumbit: isValidLoginCredentials(),
                      isLoading: state.status == FormsStatus.loading,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Login With",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SignInWithGoogleEvent());
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/google.svg",
                            width: 45,
                            height: 45,
                          )),
                      const SizedBox(
                        width: 40,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/icloud.svg",
                            width: 45,
                            height: 45,
                          )),
                      const SizedBox(
                        width: 40,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/facebook.svg",
                            width: 45,
                            height: 45,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: const Text(
                        "Don’t have an account? Register now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "SF Pro Rounded",
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            )
          ],
        );
      }, listener: (context, state) {
        if (state.status == FormsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.statusMessage,
              style: AppTextStyle.interBold
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state.status == FormsStatus.authenticated) {
          if (state.statusMessage == 'registered') {
            BlocProvider.of<UserBloc>(context)
                .add(AddUserEvent(userModel: state.userModel));
          } else {
            BlocProvider.of<UserBloc>(context).add(
              GetUserByUIDEvent(state.userModel.authUid),
            );
          }
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.setPinRoute,
            (route) => false,
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
