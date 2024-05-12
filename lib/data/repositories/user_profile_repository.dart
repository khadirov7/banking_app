
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/constants/app_constants.dart';
import '../models/network_response.dart';
import '../models/user_mode.dart';

class UserProfileRepository {
  Future<NetworkResponse> addUser(UserModel userModel) async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(AppConstants.users).get();

      List<UserModel> users = querySnapshot.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      bool isExist = false;
      for (var user in users) {
        if (user.email == userModel.email) {
          isExist = true;
        }
      }
      if (isExist == false) {
        DocumentReference documentReference = await FirebaseFirestore.instance
            .collection(AppConstants.users)
            .add(userModel.toJson());

        await FirebaseFirestore.instance
            .collection(AppConstants.users)
            .doc(documentReference.id)
            .update({"userId": documentReference.id});
      }

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorCode: error.code);
    }
  }

  Future<NetworkResponse> updateUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(userModel.userId)
          .update(
        userModel.toJsonForUpdate(),
      );
      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorCode: error.code);
    }
  }

  Future<NetworkResponse> deleteUser(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(docId)
          .delete();

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorCode: error.code);
    }
  }

  Future<NetworkResponse> getUserByDocId(String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(docId)
          .get();
      return NetworkResponse(
        data: UserModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        ),
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(errorCode: error.code);
    }
  }

  Future<NetworkResponse> getUserByUid(String uid) async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .where("authUid", isEqualTo: uid)
          .get();

      List<UserModel> users = querySnapshot.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return NetworkResponse(
          data: users.isEmpty ? UserModel.initial() : users.first);
    } on FirebaseException catch (error) {
      return NetworkResponse(errorCode: error.code);
    }
  }
}