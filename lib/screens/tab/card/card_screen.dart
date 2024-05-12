import 'package:banking_app/blocs/card/card_bloc.dart';
import 'package:banking_app/blocs/card/card_event.dart';
import 'package:banking_app/blocs/card/card_state.dart';
import 'package:banking_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:banking_app/screens/tab/card/add_card_screen.dart';
import 'package:banking_app/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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
      appBar: AppBar(
        title: const Text("Cards"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCardScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          if (state.userCards.isEmpty) {
            return  Center(
              child: Lottie.asset("assets/lottie/empty.json"),
            );
          }

          return ListView.builder(
            itemCount: state.userCards.length,
            itemBuilder: (context, index) {
              final card = state.userCards[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'update') {
                                } else if (value == 'delete') {
                                  context.read<UserCardsBloc>().add(DeleteCardEvent(card.cardId));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Karta ochirildi")),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text("Delete"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 40),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/chip.svg",
                                width: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                "assets/icons/net.svg",
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, top: 15, bottom: 5),
                          child: Text(
                            card.cardNumber,
                            style: AppTextStyle.interSemiBold.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3),
                          ),
                        ),
                        Center(
                          child: Text(
                            card.expireDate,
                            style: AppTextStyle.interSemiBold.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                card.cardHolder,
                                style: AppTextStyle.interSemiBold.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 3),
                              ),
                              SvgPicture.asset(
                                "assets/icons/visa.svg",
                                width: 40,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
