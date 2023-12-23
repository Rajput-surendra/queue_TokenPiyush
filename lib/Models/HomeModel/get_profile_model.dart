/// profile : {"user_id":"169","user_name":"Surendra ","email":"","mobile":"8080808080","password":"","api_key":"","referral_code":"6392d912776d","referred_by":null,"security_pin":"1600","image":"https://developmentalphawizz.com/queue_token/uploads/img/user/2553010329833709927.jpg","wallet_balance":"0","hold_amount":"0","last_update":"2023-12-14 17:15:58","insert_date":"14-Dec-2023","status":"1","verified":"1","betting_status":"0","notification_status":"1","transfer_point_status":"0","role":"user","address":null,"city":"indore ","category":null,"time_per_client":null,"shift":null,"shift_hrs":null}
/// msg : "User Profile Data."
/// status : true

class GetProfileModel {
  GetProfileModel({
      Profile? profile, 
      String? msg, 
      bool? status,}){
    _profile = profile;
    _msg = msg;
    _status = status;
}

  GetProfileModel.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    _msg = json['msg'];
    _status = json['status'];
  }
  Profile? _profile;
  String? _msg;
  bool? _status;
GetProfileModel copyWith({  Profile? profile,
  String? msg,
  bool? status,
}) => GetProfileModel(  profile: profile ?? _profile,
  msg: msg ?? _msg,
  status: status ?? _status,
);
  Profile? get profile => _profile;
  String? get msg => _msg;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    map['msg'] = _msg;
    map['status'] = _status;
    return map;
  }

}

/// user_id : "169"
/// user_name : "Surendra "
/// email : ""
/// mobile : "8080808080"
/// password : ""
/// api_key : ""
/// referral_code : "6392d912776d"
/// referred_by : null
/// security_pin : "1600"
/// image : "https://developmentalphawizz.com/queue_token/uploads/img/user/2553010329833709927.jpg"
/// wallet_balance : "0"
/// hold_amount : "0"
/// last_update : "2023-12-14 17:15:58"
/// insert_date : "14-Dec-2023"
/// status : "1"
/// verified : "1"
/// betting_status : "0"
/// notification_status : "1"
/// transfer_point_status : "0"
/// role : "user"
/// address : null
/// city : "indore "
/// category : null
/// time_per_client : null
/// shift : null
/// shift_hrs : null

class Profile {
  Profile({
      String? userId, 
      String? userName, 
      String? email, 
      String? mobile, 
      String? password, 
      String? apiKey, 
      String? referralCode, 
      dynamic referredBy, 
      String? securityPin, 
      String? image, 
      String? walletBalance, 
      String? holdAmount, 
      String? lastUpdate, 
      String? insertDate, 
      String? status, 
      String? verified, 
      String? bettingStatus, 
      String? notificationStatus, 
      String? transferPointStatus, 
      String? role, 
      dynamic address, 
      String? city, 
      dynamic category, 
      dynamic timePerClient, 
      dynamic shift, 
      dynamic shiftHrs,}){
    _userId = userId;
    _userName = userName;
    _email = email;
    _mobile = mobile;
    _password = password;
    _apiKey = apiKey;
    _referralCode = referralCode;
    _referredBy = referredBy;
    _securityPin = securityPin;
    _image = image;
    _walletBalance = walletBalance;
    _holdAmount = holdAmount;
    _lastUpdate = lastUpdate;
    _insertDate = insertDate;
    _status = status;
    _verified = verified;
    _bettingStatus = bettingStatus;
    _notificationStatus = notificationStatus;
    _transferPointStatus = transferPointStatus;
    _role = role;
    _address = address;
    _city = city;
    _category = category;
    _timePerClient = timePerClient;
    _shift = shift;
    _shiftHrs = shiftHrs;
}

  Profile.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userName = json['user_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _password = json['password'];
    _apiKey = json['api_key'];
    _referralCode = json['referral_code'];
    _referredBy = json['referred_by'];
    _securityPin = json['security_pin'];
    _image = json['image'];
    _walletBalance = json['wallet_balance'];
    _holdAmount = json['hold_amount'];
    _lastUpdate = json['last_update'];
    _insertDate = json['insert_date'];
    _status = json['status'];
    _verified = json['verified'];
    _bettingStatus = json['betting_status'];
    _notificationStatus = json['notification_status'];
    _transferPointStatus = json['transfer_point_status'];
    _role = json['role'];
    _address = json['address'];
    _city = json['city'];
    _category = json['category'];
    _timePerClient = json['time_per_client'];
    _shift = json['shift'];
    _shiftHrs = json['shift_hrs'];
  }
  String? _userId;
  String? _userName;
  String? _email;
  String? _mobile;
  String? _password;
  String? _apiKey;
  String? _referralCode;
  dynamic _referredBy;
  String? _securityPin;
  String? _image;
  String? _walletBalance;
  String? _holdAmount;
  String? _lastUpdate;
  String? _insertDate;
  String? _status;
  String? _verified;
  String? _bettingStatus;
  String? _notificationStatus;
  String? _transferPointStatus;
  String? _role;
  dynamic _address;
  String? _city;
  dynamic _category;
  dynamic _timePerClient;
  dynamic _shift;
  dynamic _shiftHrs;
Profile copyWith({  String? userId,
  String? userName,
  String? email,
  String? mobile,
  String? password,
  String? apiKey,
  String? referralCode,
  dynamic referredBy,
  String? securityPin,
  String? image,
  String? walletBalance,
  String? holdAmount,
  String? lastUpdate,
  String? insertDate,
  String? status,
  String? verified,
  String? bettingStatus,
  String? notificationStatus,
  String? transferPointStatus,
  String? role,
  dynamic address,
  String? city,
  dynamic category,
  dynamic timePerClient,
  dynamic shift,
  dynamic shiftHrs,
}) => Profile(  userId: userId ?? _userId,
  userName: userName ?? _userName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  password: password ?? _password,
  apiKey: apiKey ?? _apiKey,
  referralCode: referralCode ?? _referralCode,
  referredBy: referredBy ?? _referredBy,
  securityPin: securityPin ?? _securityPin,
  image: image ?? _image,
  walletBalance: walletBalance ?? _walletBalance,
  holdAmount: holdAmount ?? _holdAmount,
  lastUpdate: lastUpdate ?? _lastUpdate,
  insertDate: insertDate ?? _insertDate,
  status: status ?? _status,
  verified: verified ?? _verified,
  bettingStatus: bettingStatus ?? _bettingStatus,
  notificationStatus: notificationStatus ?? _notificationStatus,
  transferPointStatus: transferPointStatus ?? _transferPointStatus,
  role: role ?? _role,
  address: address ?? _address,
  city: city ?? _city,
  category: category ?? _category,
  timePerClient: timePerClient ?? _timePerClient,
  shift: shift ?? _shift,
  shiftHrs: shiftHrs ?? _shiftHrs,
);
  String? get userId => _userId;
  String? get userName => _userName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get apiKey => _apiKey;
  String? get referralCode => _referralCode;
  dynamic get referredBy => _referredBy;
  String? get securityPin => _securityPin;
  String? get image => _image;
  String? get walletBalance => _walletBalance;
  String? get holdAmount => _holdAmount;
  String? get lastUpdate => _lastUpdate;
  String? get insertDate => _insertDate;
  String? get status => _status;
  String? get verified => _verified;
  String? get bettingStatus => _bettingStatus;
  String? get notificationStatus => _notificationStatus;
  String? get transferPointStatus => _transferPointStatus;
  String? get role => _role;
  dynamic get address => _address;
  String? get city => _city;
  dynamic get category => _category;
  dynamic get timePerClient => _timePerClient;
  dynamic get shift => _shift;
  dynamic get shiftHrs => _shiftHrs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['api_key'] = _apiKey;
    map['referral_code'] = _referralCode;
    map['referred_by'] = _referredBy;
    map['security_pin'] = _securityPin;
    map['image'] = _image;
    map['wallet_balance'] = _walletBalance;
    map['hold_amount'] = _holdAmount;
    map['last_update'] = _lastUpdate;
    map['insert_date'] = _insertDate;
    map['status'] = _status;
    map['verified'] = _verified;
    map['betting_status'] = _bettingStatus;
    map['notification_status'] = _notificationStatus;
    map['transfer_point_status'] = _transferPointStatus;
    map['role'] = _role;
    map['address'] = _address;
    map['city'] = _city;
    map['category'] = _category;
    map['time_per_client'] = _timePerClient;
    map['shift'] = _shift;
    map['shift_hrs'] = _shiftHrs;
    return map;
  }

}