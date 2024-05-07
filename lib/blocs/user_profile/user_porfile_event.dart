
import 'package:equatable/equatable.dart';
import '../../data/models/user_mode.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object?>get props=>[];}



class AddUserEvent extends UserEvent{
  final UserModel userModel;
  AddUserEvent({required this.userModel});
  @override
  List<Object?>get props=>[
    userModel
  ];
}

class UpdateUserEvent extends UserEvent{
  final UserModel userModel;
  UpdateUserEvent({required this.userModel});
  @override
  List<Object?>get props=>[
    userModel
  ];
}


class DeleteUserEvent extends UserEvent{
  final UserModel userModel;
  DeleteUserEvent({required this.userModel});
  @override
  List<Object?>get props=>[
    userModel
  ];
}

class GetUserByDocIdEvent extends UserEvent{
  final String docId;
  GetUserByDocIdEvent({required this.docId});
  @override
  List<Object?>get props=>[
    docId
  ];
}
class GetUserByUIDEvent extends UserEvent{
  final String uid;
  GetUserByUIDEvent(this.uid);
  @override
  List<Object?>get props=>[uid
  ];
}

class GetCurrentUserEvent extends UserEvent {
  final String uid;
  GetCurrentUserEvent(this.uid);
  @override
  List<Object?> get props => [uid];
}




