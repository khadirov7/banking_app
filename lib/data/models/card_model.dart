class CardModel {
  final String cardHolder;
  final String cardNumber;
  final String expireDate;
  final String cvc;
  final int type;
  final String icon;
  final String userId;
  final String cardId;
  final bool isMain;
  final String bank;
  final String color;
  final double balance;

  CardModel({
    required this.expireDate,
    required this.cardNumber,
    required this.bank,
    required this.balance,
    required this.type,
    required this.icon,
    required this.cvc,
    required this.isMain,
    required this.color,
    required this.userId,
    required this.cardId,
    required this.cardHolder,
  });

  CardModel copyWith({
    String? cardHolder,
    String? cardNumber,
    String? expireDate,
    String? cvc,
    String? color,
    bool? isMain,
    int? type,
    String? icon,
    String? bank,
    String? cardId,
    double? balance,
    String? userId,
  }) {
    return CardModel(
        expireDate: expireDate ?? this.expireDate,
        bank: bank ?? this.bank,
        isMain: isMain ?? this.isMain,
        color: color ?? this.color,
        cardId: cardId ?? this.cardId,
        balance: balance ?? this.balance,
        cardNumber: cardNumber ?? this.cardNumber,
        type: type ?? this.type,
        icon: icon ?? this.icon,
        cvc: cvc ?? this.cvc,
        userId: userId ?? this.userId,
        cardHolder: cardHolder ?? this.cardHolder);
  }

  Map<String, dynamic> toJson() => {
    "expireDate": expireDate,
    "bank": bank,
    "color": color,
    "cardId": cardId,
    "isMain" : isMain,
    "cardNumber": cardNumber,
    "balance": balance,
    "type": type,
    "cvc": cvc,
    "userId": userId,
    "cardHolder": cardHolder,
    "icon": icon,
  };

  Map<String, dynamic> toJsonForUpdate() => {
    "balance": balance,
    "color" : color,
    "bank": bank,
    "isMain": isMain,
  };

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        isMain: json["isMain"] as bool? ?? false,
        color: json["color"] as String? ?? "",
        cardId: json["cardId"] as String? ?? "",
        bank: json["bank"] as String? ?? "",
        balance: (json["balance"] as num).toDouble(),
        expireDate: json["expireDate"] as String? ?? "",
        cardNumber: json["cardNumber"] as String? ?? "",
        type: json["type"] as int? ?? 0,
        icon: json["icon"] as String? ?? "",
        cvc: json["cvc"] as String? ?? "",
        userId: json["userId"] as String? ?? "",
        cardHolder: json["cardHolder"] as String? ?? "");
  }

  static CardModel initial() => CardModel(
      expireDate: "",
      bank: "",
      isMain: false,
      color: "",
      cardId: "",
      balance: 0,
      cardNumber: "",
      type: 0,
      icon: "",
      cvc: "",
      userId: "",
      cardHolder: "");
}
