import 'package:banking_app/screens/tab/card/widget/expriy_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/card/user_cards_bloc.dart';
import '../../../blocs/card/user_cards_event.dart';
import '../../../blocs/card/user_cards_state.dart';
import '../../../data/models/card_model.dart';
import '../../../data/models/forms_status.dart';
import '../../auth/widget/my_custom_button.dart';
import '../transfer/widget/card_number_input.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expireDate = TextEditingController();
  final FocusNode cardFocusNode = FocusNode();
  final FocusNode expireDateFocusNode = FocusNode();
  CardModel cardModel = CardModel.initial();

  @override
  void initState() {
    cardNumber.addListener(() {
      setState(() {});
      cardModel = cardModel.copyWith(cardNumber: cardNumber.text.replaceAll(" ", ""));
    });

    expireDate.addListener(() {
      setState(() {});
      cardModel = cardModel.copyWith(expireDate: expireDate.text.replaceAll(" ", ""));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add Card",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return Column(
            children: [
              CardNumberInput(controller: cardNumber, focusNode: cardFocusNode),
              ExpireDateInput(controller: expireDate, focusNode: expireDateFocusNode),
              const Spacer(),
              MyCustomButton(
                onTap: () {
                  if (cardModel.cardNumber.length != 16 || cardModel.expireDate.length != 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Xato")),
                    );
                    return;
                  }

                  List<CardModel> db = state.cardsDB;
                  List<CardModel> myCards = state.userCards;

                  bool isExist = false;

                  for (var element in myCards) {
                    if (element.cardNumber == cardModel.cardNumber) {
                      isExist = true;
                      break;
                    }
                  }

                  bool hasInDB = false;
                  for (var element in db) {
                    if (element.cardNumber == cardModel.cardNumber) {
                      hasInDB = true;
                      cardModel = element;
                      break;
                    }
                  }

                  if ((!isExist) && hasInDB) {
                    context.read<UserCardsBloc>().add(AddCardEvent(cardModel));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Card already exists or not in database")),
                    );
                  }
                },
                title: "Add",
                isLoading: state.status == FormsStatus.loading,
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.statusMessage == "added") {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}