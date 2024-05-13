import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/user_profile/user_profile_bloc.dart';
import '../../../blocs/user_profile/user_profile_event.dart';
import '../../../blocs/user_profile/user_profile_state.dart';
import '../../../data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
        ),
        body:
            BlocBuilder<UserProfileBloc, UserProfileState>(builder: (context, state) {
              phoneController.text = state.userModel.phoneNumber;
              nameController.text = state.userModel.fullName;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                              'assets/images/banking1.png'), // Add your image asset
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Location',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your location',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Address',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your address',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Phone Number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your phone number',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 50,),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          UserModel user=state.userModel;
                          user=user.copyWith(
                              lastname: nameController.text,
                              phoneNumber: phoneController.text
                          );
                          context.read<UserProfileBloc>().add(UpdateUserEvent(user));
                          Navigator.pop(context);
                        },
                        child: Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
