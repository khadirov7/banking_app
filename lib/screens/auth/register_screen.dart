import 'package:banking_app/screens/auth/widget/my_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../data/models/forms_status_model.dart';
import '../../data/models/user_mode.dart';
import '../../utils/constants/app_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isValidLoginCredential() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
          AppConstants.textRegExp.hasMatch(usernameController.text) &&
          AppConstants.phoneRegExp.hasMatch(phoneController.text) &&
          AppConstants.textRegExp.hasMatch(lastnameController.text);

  @override
  void dispose() {
    lastnameController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                      child: Image.asset("assets/images/banking1.png",width: 200,),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    const Padding(
                      padding:  EdgeInsets.only(bottom: 38.0),
                      child:  Text(
                        "REGISTER",
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
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.done,
                        controller: usernameController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 1),
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter username'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.textRegExp.hasMatch(v)) {
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
                        controller: lastnameController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 1),
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter Full name'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.textRegExp.hasMatch(v)) {
                            return null;
                          }
                          return "Full name error";
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
                        controller: phoneController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 1),
                            ),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter Phone number'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.phoneRegExp.hasMatch(v)) {
                            return null;
                          }
                          return "Phone number error";
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
                              borderSide:
                              BorderSide(color: Colors.red, width: 1),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                      child: MyCustomButton(
                        onTap: () {
                          context.read<AuthBloc>().add(RegisterUserEvent(
                            userModel: UserModel(
                                password: passwordController.text,
                                lastName: lastnameController.text,
                                imageUrl: "",
                                fcm: "",
                                authUid: "",
                                phoneNumber: phoneController.text,
                                email: "${usernameController.text.toLowerCase()}@gmail.com",
                                userId: "",
                                userName: usernameController.text),
                          ));
                        },
                        title: "REGISTER",
                        readyToSumbit: isValidLoginCredential(),
                        isLoading: state.status == FormsStatus.loading,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Already have an account? Login",
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
        },
        listener: (context, state) {
          if (state.status == FormsStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
      ),
    );
  }
}
