import 'package:equatable/equatable.dart';
import '../../data/models/forms_status_model.dart';
import '../../data/models/user_mode.dart';

class UserState extends Equatable {

  final UserModel userModel;
  final FormsStatus formsStatus;
  final String errorMessage;
  final String statusMessage;


  const UserState({
    required this.formsStatus,
    required this.userModel,
    required this.statusMessage,
    required this.errorMessage
  });

  UserState copyWith({
    UserModel? userModel,
    FormsStatus? formsStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserState(
      formsStatus: formsStatus ?? this.formsStatus,
      userModel: userModel ?? this.userModel,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,);
  }

  @override
  List<Object?> get props =>
      [
        userModel,
        errorMessage,
        formsStatus,
        statusMessage,
      ];
}
