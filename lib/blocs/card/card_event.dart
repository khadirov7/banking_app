import 'package:banking_app/data/models/card_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserCardsEvent extends Equatable{
  @override
  List<Object?>get props=>[];}



class AddCardEvent extends UserCardsEvent{
  final CardModel cardModel;
  AddCardEvent({required this.cardModel});
  @override
  List<Object?>get props=>[
    cardModel
  ];
}

class UpdateCardEvent extends UserCardsEvent{
  final CardModel cardModel;
  UpdateCardEvent({required this.cardModel});
  @override
  List<Object?>get props=>[
    cardModel
  ];
}


class DeleteCardEvent extends UserCardsEvent{
  final String cardDocId;
  DeleteCardEvent({required this.cardDocId});
  @override
  List<Object?>get props=>[
    cardDocId
  ];
}

class GetCardsByUserId extends UserCardsEvent{
  final String userId;
  GetCardsByUserId({required this.userId});
  @override
  List<Object?>get props=>[
    userId
  ];
}
class GetUserByUIDEvent extends UserCardsEvent{
  final String uid;
  GetUserByUIDEvent(this.uid);
  @override
  List<Object?>get props=>[uid
  ];
}
class GetCardsDatabaseEvent extends UserCardsEvent {
  GetCardsDatabaseEvent();
  @override
  List<Object?>get props=>[];
}





