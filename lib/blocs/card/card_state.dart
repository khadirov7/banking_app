import 'package:banking_app/data/models/card_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/forms_status_model.dart';

class CardsState extends Equatable {

  final List<CardModel> userCards;
  final List<CardModel> cardsDB;

  final FormsStatus formsStatus;
  final String errorMessage;
  final String statusMessage;


  const CardsState({
    required this.formsStatus,
    required this.cardsDB,
    required this.userCards,
    required this.statusMessage,
    required this.errorMessage
  });

  CardsState copyWith({
    List<CardModel>? userCards,
    List<CardModel>? cardsDB,
    FormsStatus? formsStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return CardsState(
      cardsDB: cardsDB ?? this.cardsDB,
      formsStatus: formsStatus ?? this.formsStatus,
      userCards: userCards ?? this.userCards,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,);
  }

  @override
  List<Object?> get props =>
      [
        cardsDB,
        userCards,
        errorMessage,
        formsStatus,
        statusMessage,
      ];
}