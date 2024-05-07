import 'package:banking_app/blocs/card/card_bloc.dart';
import 'package:banking_app/blocs/card/card_event.dart';
import 'package:banking_app/data/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                labelText: "Card Number",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cardHolderController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                labelText: "Card Holder Name",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expiryDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                labelText: "Expiry Date",
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final card = CardModel(
                      cardNumber: cardNumberController.text,
                      cardHolder: cardHolderController.text,
                      expireDate: expiryDateController.text,
                      bank: '',
                      balance: 100,
                      type: 1,
                      icon: '',
                      cvc: '',
                      isMain: false,
                      color: '000000',
                      userId: '',
                      cardId: '');

                  BlocProvider.of<UserCardsBloc>(context).add(
                    AddCardEvent(cardModel: card),
                  );

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Karta qo'shildi")));
                },
                child: const Text("Add Card"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
