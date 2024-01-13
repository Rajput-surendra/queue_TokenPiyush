/// error : false
/// message : "Data Get Sucessfully\n!"
/// data : [{"id":"57","user_id":"2","token_id":"37","counter_id":"18","name":"ttttyt","mobile":"3636363636","city":"indoooo","token_number":"2","time":"06:53\nPM","status":"0","date":"2024-01-13","created_at":"2024-01-13\n18:53:30","is_first":1},{"id":"58","user_id":"2","token_id":"37","counter_id":"18","name":"vhhhj","mobile":"5566999999","city":"fghhjj","token_number":"3","time":"06:54\nPM","status":"0","date":"2024-01-13","created_at":"2024-01-13\n18:53:30","is_first":0},{"id":"59","user_id":"2","token_id":"37","counter_id":"18","name":"vhhhjjhctc","mobile":"2858285883","city":"xyftctctfy","token_number":"4","time":"06:55\nPM","status":"0","date":"2024-01-13","created_at":"2024-01-13\n18:53:30","is_first":0}]
/// complete_bookings : [{"id":"56","user_id":"22","token_id":"37","counter_id":"18","name":"gghgghh","mobile":"5556666666","city":"ibhhh","token_number":"1","time":"12:06\nPM","status":"1","date":"2024-01-13","created_at":"2024-01-13 18:53:30"}]

class GetTokenDetailsModel {
  GetTokenDetailsModel({
      bool? error, 
      String? message, 
      List<Data>? data, 
      List<CompleteBookings>? completeBookings,}){
    _error = error;
    _message = message;
    _data = data;
    _completeBookings = completeBookings;
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
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
  List<CompleteBookings>? _completeBookings;
GetTokenDetailsModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
  List<CompleteBookings>? completeBookings,
}) => GetTokenDetailsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  completeBookings: completeBookings ?? _completeBookings,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;
  List<CompleteBookings>? get completeBookings => _completeBookings;

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
    return map;
  }

}

/// id : "56"
/// user_id : "22"
/// token_id : "37"
/// counter_id : "18"
/// name : "gghgghh"
/// mobile : "5556666666"
/// city : "ibhhh"
/// token_number : "1"
/// time : "12:06\nPM"
/// status : "1"
/// date : "2024-01-13"
/// created_at : "2024-01-13 18:53:30"

class CompleteBookings {
  CompleteBookings({
      String? id, 
      String? userId, 
      String? tokenId, 
      String? counterId, 
      String? name, 
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

/// id : "57"
/// user_id : "2"
/// token_id : "37"
/// counter_id : "18"
/// name : "ttttyt"
/// mobile : "3636363636"
/// city : "indoooo"
/// token_number : "2"
/// time : "06:53\nPM"
/// status : "0"
/// date : "2024-01-13"
/// created_at : "2024-01-13\n18:53:30"
/// is_first : 1

class Data {
  Data({
      String? id, 
      String? userId, 
      String? tokenId, 
      String? counterId, 
      String? name, 
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