class UserModel {
  final String userName;
  final String lastName;
  final String password;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String userId;
  final String fcm;
  final String authUid;

  UserModel({
    required this.password,
    required this.lastName,
    required this.fcm,
    required this.authUid,
    required this.imageUrl,
    required this.phoneNumber,
    required this.email,
    required this.userId,
    required this.userName,
  });

  UserModel copyWith({
    String? userName,
    String? lastName,
    String? password,
    String? email,
    String? fcm,
    String? authUid,
    String? imageUrl,
    String? phoneNumber,
    String? userId,
  }) {
    return UserModel(
        password: password ?? this.password,
        fcm: fcm ?? this.fcm,
        authUid: authUid ?? this.authUid,
        lastName: lastName ?? this.lastName,
        imageUrl: imageUrl ?? this.imageUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName);
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "authUid": authUid,
        "lastName": lastName,
        "imageUrl": imageUrl,
        "phoneNumber": phoneNumber,
        "email": email,
        "password": password,
        "userName": userName,
        "fcm": fcm,
      };

  Map<String, dynamic> toJsonForUpdate() => {
    "authUid": authUid,
    "lastName": lastName,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "userName": userName,
    "fcm": fcm,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fcm: json["fcm"] as String? ?? "",
        authUid: json["authUid"] as String? ?? "",
        password: json["password"] as String? ?? "",
        lastName: json["lastName"] as String? ?? "",
        imageUrl: json["imageUrl"] as String? ?? "",
        phoneNumber: json["phoneNumber"] as String? ?? "",
        email: json["email"] as String? ?? "",
        userId: json["userId"] as String? ?? "",
        userName: json["userName"] as String? ?? "");
  }

  static UserModel initial() => UserModel(
      password: "",
      fcm: "",
      authUid: "",
      lastName: "",
      imageUrl: "",
      phoneNumber: "",
      email: "",
      userId: "",
      userName: "");
}
