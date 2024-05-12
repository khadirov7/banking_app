import 'package:banking_app/blocs/card/card_state.dart';
import 'package:banking_app/screens/tab/transfer/widget/amount_input.dart';
import 'package:banking_app/screens/tab/transfer/widget/card_item_view.dart';
import 'package:banking_app/screens/tab/transfer/widget/card_number_input.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_utils/my_utils.dart';
import '../../../blocs/card/card_bloc.dart';
import '../../../blocs/card/card_event.dart';
import '../../../blocs/transaction/transaction_bloc.dart';
import '../../../blocs/transaction/transaction_event.dart';
import '../../../blocs/transaction/transaction_state.dart';
import '../../../data/models/card_model.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../auth/widget/my_custom_button.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int selectedCardIndex = 0;

  final TextEditingController cardNumberController = TextEditingController();
  final FocusNode cardFocusNode = FocusNode();

  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  CardModel senderCard = CardModel.initial();
  CardModel receiverCard = CardModel.initial();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    senderCard = context.read<UserCardsBloc>().state.userCards[0];
    List<CardModel> cards = context.read<UserCardsBloc>().state.activeCards;
    cardNumberController.addListener(
      () {
        String receiverCardNumber =
            cardNumberController.text.replaceAll(" ", "");
        if (receiverCardNumber.length == 16) {
          for (var element in cards) {
            if (element.cardNumber == receiverCardNumber &&
                senderCard.cardNumber != receiverCardNumber) {
              receiverCard = element;

              context
                  .read<TransactionBloc>()
                  .add(SetReceiverCardEvent(cardModel: receiverCard));
              context
                  .read<TransactionBloc>()
                  .add(SetSenderCardEvent(cardModel: senderCard));

              setState(() {});
              break;
            } else {
              receiverCard = CardModel.initial();
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CardNumberInput(
                      controller: cardNumberController,
                      focusNode: cardFocusNode,
                    ),
                    Visibility(
                      visible: cardNumberController.text.length == 19,
                      child: Row(
                        children: [
                          SizedBox(width: 24.w),
                          Text(
                            "Qabul qiluvchi: ${receiverCard.cardHolder.isEmpty ? "Topilmadi" : receiverCard.cardHolder}",
                            style: AppTextStyle.interSemiBold.copyWith(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      child: AmountInput(
                        controller: amountController,
                        focusNode: amountFocusNode,
                        amount: (amount) {
                          if (amount >= 1000) {
                            context
                                .read<TransactionBloc>()
                                .add(SetAmountEvent(amount: amount));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: List.generate(
                  state.userCards.length,
                  (index) {
                    CardModel cardModel = state.userCards[index];
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
                                        context.read<UserCardsBloc>().add(
                                            DeleteCardEvent(cardModel.cardId));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text("Karta ochirildi")),
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
                                padding: const EdgeInsets.only(
                                    left: 40.0, top: 15, bottom: 5),
                                child: Text(
                                  cardModel.cardNumber,
                                  style: AppTextStyle.interSemiBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 3),
                                ),
                              ),
                              Center(
                                child: Text(
                                  cardModel.expireDate,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cardModel.cardHolder,
                                      style: AppTextStyle.interSemiBold
                                          .copyWith(
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
                ),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.95,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  onPageChanged: (index, reason) {
                    selectedCardIndex = index;
                    debugPrint("INDEX:$index");
                    senderCard = state.userCards[index];
                  },
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.1,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              BlocListener<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state.statusMessage == "not_validated") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ma'lumotlar xato!"),
                      ),
                    );
                  } else if (state.statusMessage == "validated") {
                    Navigator.pop(context);
                  }
                },
                child: MyCustomButton(
                  onTap: () {
                    context.read<TransactionBloc>().add(CheckValidationEvent());
                  },
                  title: "Yuborish",
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
