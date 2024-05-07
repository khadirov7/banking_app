import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/user_profile/user_porfile_event.dart';
import '../../blocs/user_profile/user_profile_bloc.dart';
import '../../data/local/storage_repository.dart';
import '../../data/models/forms_status_model.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool hasPin=false;
  _init(bool isAuthenticated) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;
    if (!isAuthenticated) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (!isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.authRoute);
      }
    } else {
      if(hasPin){
        Navigator.pushReplacementNamed(context, RouteNames.entryRoute);
      }
      else{
        Navigator.pushReplacementNamed(context, RouteNames.setPinRoute);
      }
    }
  }

  @override
  void initState() {
    hasPin=StorageRepository.getString(key: 'pin').isNotEmpty;
    debugPrint("AAA${StorageRepository.getString(key: 'pin')}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == FormsStatus.authenticated) {
              BlocProvider.of<UserBloc>(context).add(GetUserByUIDEvent(FirebaseAuth.instance.currentUser!.uid),);
              _init(true);
            }
            else {
              _init(false);
            }
          }, child: Center(
            child: Icon(Icons.monetization_on_outlined)
        ),
        )
    );
  }
}