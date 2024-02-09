/// error : false
/// message : "Data Get Sucessfully !"
/// data : [{"id":"119","user_id":"2","token_id":"93","counter_id":"18","name":"third","age":"19","mobile":"4885555556","city":"bhopal","token_number":"3","time":"06:18 PM","status":"0","date":"2024-01-19","created_at":"2024-01-19 18:18:14","is_first":1}]
/// complete_bookings : [{"id":"118","user_id":"2","token_id":"93","counter_id":"18","name":"second booking","age":"12","mobile":"7885554555","city":"indore","token_number":"2","time":"06:17 PM","status":"1","date":"2024-01-19","created_at":"2024-01-19 18:18:14"}]
/// skiped_bookings : [{"id":"117","user_id":"2","token_id":"93","counter_id":"18","name":"test user","age":"25","mobile":"7885555555","city":"indore","token_number":"1","time":"06:17 PM","status":"2","date":"2024-01-19","created_at":"2024-01-19 18:17:58"}]

class GetTokenDetailsModel {
  GetTokenDetailsModel({
      bool? error, 
      String? message, 
      List<Data>? data, 
      List<CompleteBookings>? completeBookings, 
      List<SkipedBookings>? skipedBookings,}){
    _error = error;
    _message = message;
    _data = data;
    _completeBookings = completeBookings;
    _skipedBookings = skipedBookings;
}

  GetTokenDetailsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['complete_bookings'] != null) {
      _completeBookings = [];
      json['complete_bookings'].forEach((v) {
        _completeBookings?.add(CompleteBookings.fromJson(v));
      });
    }
    if (json['skiped_bookings'] != null) {
      _skipedBookings = [];
      json['skiped_bookings'].forEach((v) {
        _skipedBookings?.add(SkipedBookings.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
  List<CompleteBookings>? _completeBookings;
  List<SkipedBookings>? _skipedBookings;
GetTokenDetailsModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
  List<CompleteBookings>? completeBookings,
  List<SkipedBookings>? skipedBookings,
}) => GetTokenDetailsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  completeBookings: completeBookings ?? _completeBookings,
  skipedBookings: skipedBookings ?? _skipedBookings,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;
  List<CompleteBookings>? get completeBookings => _completeBookings;
  List<SkipedBookings>? get skipedBookings => _skipedBookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_completeBookings != null) {
      map['complete_bookings'] = _completeBookings?.map((v) => v.toJson()).toList();
    }
    if (_skipedBookings != null) {
      map['skiped_bookings'] = _skipedBookings?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "117"
/// user_id : "2"
/// token_id : "93"
/// counter_id : "18"
/// name : "test user"
/// age : "25"
/// mobile : "7885555555"
/// city : "indore"
/// token_number : "1"
/// time : "06:17 PM"
/// status : "2"
/// date : "2024-01-19"
/// created_at : "2024-01-19 18:17:58"

class SkipedBookings {
  SkipedBookings({
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
      String? createdAt,}){
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
}

  SkipedBookings.fromJson(dynamic json) {
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
SkipedBookings copyWith({  String? id,
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
}) => SkipedBookings(  id: id ?? _id,
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
    return map;
  }

}

/// id : "118"
/// user_id : "2"
/// token_id : "93"
/// counter_id : "18"
/// name : "second booking"
/// age : "12"
/// mobile : "7885554555"
/// city : "indore"
/// token_number : "2"
/// time : "06:17 PM"
/// status : "1"
/// date : "2024-01-19"
/// created_at : "2024-01-19 18:18:14"

class CompleteBookings {
  CompleteBookings({
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
      String? createdAt,}){
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
}

  CompleteBookings.fromJson(dynamic json) {
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
CompleteBookings copyWith({  String? id,
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
}) => CompleteBookings(  id: id ?? _id,
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
    return map;
  }

}

/// id : "119"
/// user_id : "2"
/// token_id : "93"
/// counter_id : "18"
/// name : "third"
/// age : "19"
/// mobile : "4885555556"
/// city : "bhopal"
/// token_number : "3"
/// time : "06:18 PM"
/// status : "0"
/// date : "2024-01-19"
/// created_at : "2024-01-19 18:18:14"
/// is_first : 1

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
      num? isFirst,}){
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
    _isFirst = isFirst;
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
    _isFirst = json['is_first'];
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
  num? _isFirst;
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
  num? isFirst,
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
  isFirst: isFirst ?? _isFirst,
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
  num? get isFirst => _isFirst;

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
    map['is_first'] = _isFirst;
    return map;
  }

}