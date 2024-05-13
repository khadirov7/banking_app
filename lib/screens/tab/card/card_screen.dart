import 'package:banking_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:banking_app/screens/tab/card/add_card_screen.dart';
import 'package:banking_app/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/card/user_cards_bloc.dart';
import '../../../blocs/card/user_cards_event.dart';
import '../../../blocs/card/user_cards_state.dart';
import '../../../data/models/card_model.dart';
import '../transfer/widget/card_item_view.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    context.read<UserCardsBloc>().add(GetCardsByUserId(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "My Cards",
          style: AppTextStyle.interSemiBold.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return ListView(
            children: List.generate(state.userCards.length, (index) {
              CardModel cardModel = state.userCards[index];
                return CardItemView(cardModel: cardModel);
            }),
          );
        },
      ),
    );
  }
}