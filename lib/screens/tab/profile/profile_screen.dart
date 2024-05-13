import 'package:banking_app/blocs/auth/auth_bloc.dart';
import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:banking_app/blocs/user_profile/user_profile_state.dart';
import 'package:banking_app/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/forms_status.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserProfileBloc,UserProfileState>(builder: (context,state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
               const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/banking1.png'),
                ),
              ),
              const SizedBox(height: 16),
               Text(
              state.userModel.fullName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
               Text(
                state.userModel.email,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Location: San Francisco, CA',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
               Text(
              state.userModel.phoneNumber,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()),
                  );
                },
              ),
              BlocListener<AuthBloc,AuthState>(listener: (context,state) {
                if(state.status == FormsStatus.unauthenticated) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
                }
              },child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('LogOut'),
                onPressed: () {
                 context.read<AuthBloc>().add(LogOutUserEvent());
                },
              )
                ,)
            ],
          ),
        );
      })
    );
  }
}
