import 'package:banking_app/data/models/forms_status_model.dart';
import 'package:banking_app/data/models/user_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormsStatus status;
  final UserModel userModel;

  const AuthState({
    required this.userModel,
    required this.status,
    required this.errorMessage,
    required this.statusMessage,
  });

  AuthState copyWith({
    UserModel? userModel,
    String? errorMessage,
    String? statusMessage,
    FormsStatus? status,
  }) {
    return AuthState(
      userModel: userModel ?? this.userModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, statusMessage,userModel];
}
