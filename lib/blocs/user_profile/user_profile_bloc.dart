import 'package:banking_app/blocs/user_profile/user_profile_event.dart';
import 'package:banking_app/blocs/user_profile/user_profile_state.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/forms_status.dart';
import '../../data/models/network_response.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_profile_repository.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this.userProfileRepository)
      : super(
          UserProfileState(
            status: FormsStatus.pure,
            userModel: UserModel.initial(),
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddUserEvent>(_addUser);
    on<UpdateUserEvent>(_updateUser);
    on<DeleteUserEvent>(_deleteUser);
    on<GetUserByDocIdEvent>(_getUserByDocId);
    on<GetCurrentUserEvent>(_getUser);
  }

  final UserProfileRepository userProfileRepository;

  _addUser(AddUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepository.addUser(event.userModel);

    if (networkResponse.errorCode.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          userModel: event.userModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          statusMessage: networkResponse.errorCode,
        ),
      );
    }
  }

  _updateUser(UpdateUserEvent event, emit) async {
    emit(
      state.copyWith(
        status: FormsStatus.loading,
        statusMessage: "",
      ),
    );

    NetworkResponse networkResponse =
        await userProfileRepository.updateUser(event.userModel);

    if (networkResponse.errorCode.isEmpty) {
      emit(
        state.copyWith(
            status: FormsStatus.success,
            userModel: event.userModel,
            statusMessage: "profile_updated"),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          statusMessage: networkResponse.errorCode,
        ),
      );
    }
  }

  _deleteUser(DeleteUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await userProfileRepository.deleteUser(event.userModel.userId);

    if (networkResponse.errorCode.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          userModel: UserModel.initial(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          statusMessage: networkResponse.errorCode,
        ),
      );
    }
  }

  _getUserByDocId(GetUserByDocIdEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await userProfileRepository.getUserByDocId(event.docId);

    if (networkResponse.errorCode.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          userModel: networkResponse.data as UserModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          statusMessage: networkResponse.errorCode,
        ),
      );
    }
  }

  _getUser(GetCurrentUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await userProfileRepository.getUserByUid(event.uid);

    if (networkResponse.errorCode.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          userModel: networkResponse.data as UserModel,
        ),
      );

      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        UserModel userModel = state.userModel;
        userModel = userModel.copyWith(fcm: token);
        add(UpdateUserEvent(userModel));
      }
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          statusMessage: networkResponse.errorCode,
        ),
      );
    }
  }
}
