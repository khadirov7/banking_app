import 'package:banking_app/data/models/card_model.dart';
import 'package:banking_app/data/models/forms_status_model.dart';
import 'package:equatable/equatable.dart';

class TransactionState extends Equatable {
  const TransactionState({
    required this.receiverCard,
    required this.senderCard,
    required this.amount,
    required this.formStatus,
    required this.errorMessage,
    required this.statusMessage,
  });

  final CardModel receiverCard;
  final CardModel senderCard;
  final double amount;
  final FormsStatus formStatus;
  final String errorMessage;
  final String statusMessage;

  TransactionState copyWith({
    CardModel? receiverCard,
    CardModel? senderCard,
    double? amount,
    FormsStatus? formStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return TransactionState(
      receiverCard: receiverCard ?? this.receiverCard,
      senderCard: senderCard ?? this.senderCard,
      amount: amount ?? this.amount,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
    receiverCard,
    senderCard,
    amount,
    formStatus,
    errorMessage,
    statusMessage,
  ];
}