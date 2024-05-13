import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/constants/app_constants.dart';
import '../models/card_model.dart';
import '../models/network_response.dart';

class HistoriesRepository {
  Future<NetworkResponse> addCard(CardModel cardModel) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .add(cardModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(documentReference.id)
          .update({"cardId": documentReference.id});

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      debugPrint("CARD ADD ERROR:$error");
      return NetworkResponse(errorText: error.toString());
    }
  }

  Stream<List<CardModel>> getHistoriesByUserId(String userId) => //getHistories
      FirebaseFirestore.instance
          .collection("transaction_histories")
          .where("senderId", isEqualTo: userId)
          .where("receiverId", isEqualTo: userId)
          .snapshots()
          .map((event) =>
              event.docs.map((doc) => CardModel.fromJson(doc.data())).toList());
}
