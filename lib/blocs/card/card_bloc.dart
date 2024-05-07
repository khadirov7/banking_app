import 'package:banking_app/blocs/card/card_event.dart';
import 'package:banking_app/blocs/card/card_state.dart';
import 'package:banking_app/data/models/forms_status_model.dart';
import 'package:banking_app/data/models/network_response.dart';
import 'package:banking_app/data/repositories/cards_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/card_model.dart';

class UserCardsBloc extends Bloc<UserCardsEvent, CardsState> {
  UserCardsBloc({required this.cardsRepository})
      : super(const CardsState(
            cardsDB: [],
            formsStatus: FormsStatus.pure,
            userCards: [],
            statusMessage: "",
            errorMessage: ",")) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<GetCardsByUserId>(_listenCard);
    on<GetCardsDatabaseEvent>(_listenCardDatabase);

  }

  final CardsRepository cardsRepository;

  _addCard(AddCardEvent event, emit) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse response = await cardsRepository.addCard(event.cardModel);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.success));
    } else {
      emit(state.copyWith(
          formsStatus: FormsStatus.error, errorMessage: response.errorText));
    }
  }

  _updateCard(UpdateCardEvent event, emit) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse response =
        await cardsRepository.updateCard(event.cardModel);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.success));
    } else {
      emit(state.copyWith(
          formsStatus: FormsStatus.error, errorMessage: response.errorText));
    }
  }

  _deleteCard(DeleteCardEvent event, emit) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse response =
        await cardsRepository.deleteCard(event.cardDocId);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.success));
    } else {
      emit(state.copyWith(
          formsStatus: FormsStatus.error, errorMessage: response.errorText));
    }
  }

  _listenCard(GetCardsByUserId event, Emitter emit) async {
    emit.onEach(
      cardsRepository.getCardsByUserId(event.userId),
      onData: (List<CardModel> userCards) {
        emit(state.copyWith(userCards: userCards));
      },
    );
  }
  _listenCardDatabase(GetCardsDatabaseEvent event, Emitter emit) async {
    emit.onEach(
      cardsRepository.getCardsDatabase(),
      onData: (List<CardModel> userCards) {
        emit(state.copyWith(cardsDB: userCards));
      },
    );
  }
}
