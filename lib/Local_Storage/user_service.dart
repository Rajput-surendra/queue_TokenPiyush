class UserData {
  UserData({
    this.id,
    this.ipAddress,
    this.username,
    this.email,
    this.mobile,
    this.image,
    this.balance,
    this.activationSelector,
    this.activationCode,

    this.createdOn,
    this.lastLogin,
    this.active,
    this.cashReceived,
    this.countryCode,

  });

  String? id;
  String? ipAddress;
  String? username;
  String? email;
  String? mobile;
  String? image;
  String? balance;
  String? activationSelector;
  String? activationCode;

  String?createdOn;
  String?lastLogin;
  String?active;

  String? cashReceived;
  String? countryCode;

  DateTime? createdAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    ipAddress: json["ip_address"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    image: json["image"],
    balance: json["balance"],
    activationSelector: json["activation_selector"],
    activationCode: json["activation_code"],

    createdOn: json["created_on"],
    lastLogin: json["last_login"],
    active: json["active"],

    cashReceived: json["cash_received"],

    countryCode: json["country_code"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ip_address": ipAddress,
    "username": username,
    "email": email,
    "mobile": mobile,
    "image": image,
    "balance": balance,
    "activation_selector": activationSelector,
    "activation_code": activationCode,

    "created_on": createdOn,
    "last_login": lastLogin,
    "active": active,

    "cash_received": cashReceived,
    "country_code": countryCode,
    "created_at": createdAt!.toIso8601String(),
  };
}