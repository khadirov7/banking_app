import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/data/models/forms_status_model.dart';
import 'package:banking_app/data/models/network_response.dart';
import 'package:banking_app/data/models/user_mode.dart';
import 'package:banking_app/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : super(AuthState(
      errorMessage: '',
      statusMessage: '',
      status: FormsStatus.pure,
      userModel: UserModel.initial()
  )) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<LogOutUserEvent>(_logOutUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
  }

  final AuthRepository authRepository;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(state.copyWith(status: FormsStatus.unauthenticated));
    }
    else {
      emit(state.copyWith(status: FormsStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
    await authRepository.logInWithEmailAndPassword(
      email: "${event.username}@gmail.com",
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel=state.userModel.copyWith(
          authUid:userCredential.user!.uid
      );
      emit(state.copyWith(
          status: FormsStatus.authenticated,
          userModel:userModel
      ));
    } else {
      emit(state.copyWith(
          statusMessage: networkResponse.errorText, status: FormsStatus.error));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
    await authRepository.registerWithEmailAndPassword(
      email:event.userModel.email,
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel=event.userModel.copyWith(
          authUid:userCredential.user!.uid
      );
      emit(state.copyWith(
          status: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel
      ));
    } else {
      emit(state.copyWith(
          statusMessage: networkResponse.errorText, status: FormsStatus.error));
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
    await authRepository.logOut();
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        status: FormsStatus.unauthenticated,
      ));
    } else {
      emit(state.copyWith(
          statusMessage: networkResponse.errorText, status: FormsStatus.error));
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
    await authRepository.googleSingIn();
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(state.copyWith(
          statusMessage: "registered",
          status: FormsStatus.authenticated,
          userModel: UserModel(
            authUid: userCredential.user!.uid,
            fcm: "",
            userName:"",
            password: "",
            imageUrl: userCredential.user!.photoURL!,
            userId: '',
            email: userCredential.user!.email!,
            phoneNumber:'',
            lastName: userCredential.user!.displayName!,)
      ));
    } else {
      emit(state.copyWith(
          statusMessage: networkResponse.errorText, status: FormsStatus.error));
    }
  }
}