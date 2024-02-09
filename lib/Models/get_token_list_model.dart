/// error : false
/// message : "Data Get Sucessfully !"
/// data : [{"id":"109","user_id":"2","token_id":"90","counter_id":"29","name":"yushu","age":"56","mobile":"2838683838","city":"Mumbai ","token_number":"4","time":"10:06 AM","status":"0","date":"18-Jan-2024","created_at":"2024-01-17 19:48:29","counter_name":"Dr Pooja ","current_token":315},{"id":"108","user_id":"2","token_id":"90","counter_id":"29","name":"raghu","age":"23","mobile":"8683868686","city":"Mumbai ","token_number":"3","time":"10:04 AM","status":"0","date":"18-Jan-2024","created_at":"2024-01-17 19:48:08","counter_name":"Dr Pooja ","current_token":315},{"id":"107","user_id":"2","token_id":"90","counter_id":"29","name":"atul","age":"19","mobile":"3068658556","city":"indore","token_number":"2","time":"10:02 AM","status":"0","date":"18-Jan-2024","created_at":"2024-01-17 19:47:41","counter_name":"Dr Pooja ","current_token":315},{"id":"106","user_id":"2","token_id":"90","counter_id":"29","name":"Pooja ","age":"28","mobile":"9855555666","city":"indore","token_number":"1","time":"10:00 AM","status":"0","date":"18-Jan-2024","created_at":"2024-01-17 19:46:56","counter_name":"Dr Pooja ","current_token":315},{"id":"105","user_id":"2","token_id":"89","counter_id":"29","name":"rohit","age":"21","mobile":"7878787878","city":"Indore ","token_number":"4","time":"07:52 PM","status":"1","date":"17-Jan-2024","created_at":"2024-01-17 19:52:12","counter_name":"Dr Nilesh","current_token":25},{"id":"104","user_id":"2","token_id":"89","counter_id":"29","name":"Indore ","age":"25","mobile":"8585858585","city":"Indore ","token_number":"3","time":"07:52 PM","status":"1","date":"17-Jan-2024","created_at":"2024-01-17 19:52:09","counter_name":"Dr Nilesh","current_token":25},{"id":"103","user_id":"2","token_id":"89","counter_id":"29","name":"sawan ","age":"28","mobile":"8080808080","city":"ujjain ","token_number":"2","time":"07:51 PM","status":"1","date":"17-Jan-2024","created_at":"2024-01-17 19:52:06","counter_name":"Dr Nilesh","current_token":25},{"id":"102","user_id":"2","token_id":"89","counter_id":"29","name":"aman","age":"15","mobile":"9898989898","city":"ujjain ","token_number":"1","time":"07:40 PM","status":"1","date":"17-Jan-2024","created_at":"2024-01-17 19:51:16","counter_name":"Dr Nilesh","current_token":25},{"id":"100","user_id":"2","token_id":"86","counter_id":"38","name":"ppppp","age":"25","mobile":"8878774855","city":"ujjain ","token_number":"1","time":"10:00 AM","status":"0","date":"18-Jan-2024","created_at":"2024-01-17 17:44:19","counter_name":"Retina","current_token":1}]

class GetTokenListModel {
  GetTokenListModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetTokenListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetTokenListModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetTokenListModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "109"
/// user_id : "2"
/// token_id : "90"
/// counter_id : "29"
/// name : "yushu"
/// age : "56"
/// mobile : "2838683838"
/// city : "Mumbai "
/// token_number : "4"
/// time : "10:06 AM"
/// status : "0"
/// date : "18-Jan-2024"
/// created_at : "2024-01-17 19:48:29"
/// counter_name : "Dr Pooja "
/// current_token : 315

class Data {
  Data({
      String? id, 
      String? userId, 
      String? tokenId, 
      String? counterId, 
      String? name, 
      String? age, 
      String? mobile, 
      String? city, 
      String? tokenNumber, 
      String? time, 
      String? status, 
      String? date, 
      String? createdAt, 
      String? counterName, 
      num? currentToken,}){
    _id = id;
    _userId = userId;
    _tokenId = tokenId;
    _counterId = counterId;
    _name = name;
    _age = age;
    _mobile = mobile;
    _city = city;
    _tokenNumber = tokenNumber;
    _time = time;
    _status = status;
    _date = date;
    _createdAt = createdAt;
    _counterName = counterName;
    _currentToken = currentToken;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _tokenId = json['token_id'];
    _counterId = json['counter_id'];
    _name = json['name'];
    _age = json['age'];
    _mobile = json['mobile'];
    _city = json['city'];
    _tokenNumber = json['token_number'];
    _time = json['time'];
    _status = json['status'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _counterName = json['counter_name'];
    _currentToken = json['current_token'];
  }
  String? _id;
  String? _userId;
  String? _tokenId;
  String? _counterId;
  String? _name;
  String? _age;
  String? _mobile;
  String? _city;
  String? _tokenNumber;
  String? _time;
  String? _status;
  String? _date;
  String? _createdAt;
  String? _counterName;
  dynamic _currentToken;
Data copyWith({  String? id,
  String? userId,
  String? tokenId,
  String? counterId,
  String? name,
  String? age,
  String? mobile,
  String? city,
  String? tokenNumber,
  String? time,
  String? status,
  String? date,
  String? createdAt,
  String? counterName,
  num? currentToken,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  tokenId: tokenId ?? _tokenId,
  counterId: counterId ?? _counterId,
  name: name ?? _name,
  age: age ?? _age,
  mobile: mobile ?? _mobile,
  city: city ?? _city,
  tokenNumber: tokenNumber ?? _tokenNumber,
  time: time ?? _time,
  status: status ?? _status,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  counterName: counterName ?? _counterName,
  currentToken: currentToken ?? _currentToken,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get tokenId => _tokenId;
  String? get counterId => _counterId;
  String? get name => _name;
  String? get age => _age;
  String? get mobile => _mobile;
  String? get city => _city;
  String? get tokenNumber => _tokenNumber;
  String? get time => _time;
  String? get status => _status;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get counterName => _counterName;
  dynamic get currentToken => _currentToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['token_id'] = _tokenId;
    map['counter_id'] = _counterId;
    map['name'] = _name;
    map['age'] = _age;
    map['mobile'] = _mobile;
    map['city'] = _city;
    map['token_number'] = _tokenNumber;
    map['time'] = _time;
    map['status'] = _status;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['counter_name'] = _counterName;
    map['current_token'] = _currentToken;
    return map;
  }

}