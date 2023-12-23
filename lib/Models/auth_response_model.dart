class AuthApiResponse {
  bool? status;
  String? message;
  User? user;
  Access? access;

  AuthApiResponse({this.message, this.user, this.access});

  AuthApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];

    user = json['user'] != null ? User.fromJson(json['user']) : null;
    access =
    json['access'] != null ? Access.fromJson(json['access']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;

    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (access != null) {
      data['access'] = access!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  List<Null>? services;
  String? serviceP;
  String? address;
  String? mobileVerifiedAt;
  bool? isActive;
  String? alternativePhone;
  String? profilePhotoPath;
  String? drivingLience;
  String? dateOfBirth;
  String? joinDate;
  String? wallet;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.name,
        this.email,
        this.mobile,
        this.gender,
        this.services,
        this.serviceP,
        this.address,
        this.mobileVerifiedAt,
        this.isActive,
        this.alternativePhone,
        this.profilePhotoPath,
        this.drivingLience,
        this.dateOfBirth,
        this.wallet,
        this.joinDate});

  factory User.fromJson(Map<String, dynamic> json) =>User(
    id: json['id'],
    wallet: json['wallet'].toString(),
    firstName: json['first_name'],
    lastName: json['last_name'],
    name: json['name'],
    email: json['email'],
    mobile: json['mobile'],
    gender: json['gender'],
    // if (json['services'] != null) {
    //   services = <Null>[];
    //   json['services'].forEach((v) {
    //     services!.add(new Null.fromJson(v));
    //   });
    // }
    serviceP: json['service_p'],
    address: json['address'],
    mobileVerifiedAt: json['mobile_verified_at'],
    isActive: json['is_active'],
    alternativePhone: json['alternative_phone'],
    profilePhotoPath: json['profile_photo_path'],
    drivingLience: json['driving_lience'],
    dateOfBirth: json['date_of_birth'],
    joinDate: json['join_date']
  );

  Map<String, dynamic> toJson() => {
   // final Map<String, dynamic> data =  Map<String, dynamic>();
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "email": email,
    "mobile": mobile,
    'gender': gender,
    'wallet': wallet,
    // if (services != null) {
    //   data['services'] = services!.map((v) => v.toJson()).toList();
    // }
    "service_p": serviceP,
    "address": address,
    "mobile_verified_at": mobileVerifiedAt,
    "is_active": isActive,
    "alternative_phone": alternativePhone,
    "profile_photo_path": profilePhotoPath,
    "driving_lience": drivingLience,
    "date_of_birth": dateOfBirth,
    "join_date": joinDate,

  };
}

class Access {
  String? authType;
  String? token;
  String? expiresAt;

  Access({this.authType, this.token, this.expiresAt});

  Access.fromJson(Map<String, dynamic> json) {
    authType = json['auth_type'];
    token = json['token'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['auth_type'] = authType;
    data['token'] = token;
    data['expires_at'] = expiresAt;
    return data;
  }
}
