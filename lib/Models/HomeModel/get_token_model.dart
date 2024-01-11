/// error : false
/// message : "Tokens Found Sucessfully !"
/// today_tokens : [{"id":"2","user_name":"Dr. rakesh sharma","counter_id":"1","category":"1","time_per_client":"5","from_time":"02:00 PM","to_time":"01:00 PM","total_token":"12","date":"2024-01-11","created_at":"2024-01-11 12:07:28","unique_id":"Ind001"}]
/// tomorrow_tokens : [{"id":"3","user_name":"cash counter ","counter_id":"1","category":"2","time_per_client":"10","from_time":"02:00 PM","to_time":"09:00 AM","total_token":"30","date":"2024-01-12","created_at":"2024-01-11 12:08:32","unique_id":"Ind001"}]

class GetTokenModel {
  GetTokenModel({
      bool? error, 
      String? message, 
      List<TodayTokens>? todayTokens, 
      List<TomorrowTokens>? tomorrowTokens,}){
    _error = error;
    _message = message;
    _todayTokens = todayTokens;
    _tomorrowTokens = tomorrowTokens;
}

  GetTokenModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['today_tokens'] != null) {
      _todayTokens = [];
      json['today_tokens'].forEach((v) {
        _todayTokens?.add(TodayTokens.fromJson(v));
      });
    }
    if (json['tomorrow_tokens'] != null) {
      _tomorrowTokens = [];
      json['tomorrow_tokens'].forEach((v) {
        _tomorrowTokens?.add(TomorrowTokens.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<TodayTokens>? _todayTokens;
  List<TomorrowTokens>? _tomorrowTokens;
GetTokenModel copyWith({  bool? error,
  String? message,
  List<TodayTokens>? todayTokens,
  List<TomorrowTokens>? tomorrowTokens,
}) => GetTokenModel(  error: error ?? _error,
  message: message ?? _message,
  todayTokens: todayTokens ?? _todayTokens,
  tomorrowTokens: tomorrowTokens ?? _tomorrowTokens,
);
  bool? get error => _error;
  String? get message => _message;
  List<TodayTokens>? get todayTokens => _todayTokens;
  List<TomorrowTokens>? get tomorrowTokens => _tomorrowTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_todayTokens != null) {
      map['today_tokens'] = _todayTokens?.map((v) => v.toJson()).toList();
    }
    if (_tomorrowTokens != null) {
      map['tomorrow_tokens'] = _tomorrowTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// user_name : "cash counter "
/// counter_id : "1"
/// category : "2"
/// time_per_client : "10"
/// from_time : "02:00 PM"
/// to_time : "09:00 AM"
/// total_token : "30"
/// date : "2024-01-12"
/// created_at : "2024-01-11 12:08:32"
/// unique_id : "Ind001"

class TomorrowTokens {
  TomorrowTokens({
      String? id, 
      String? userName, 
      String? counterId, 
      String? category, 
      String? timePerClient, 
      String? fromTime, 
      String? toTime, 
      String? totalToken, 
      String? date, 
      String? createdAt, 
      String? uniqueId,}){
    _id = id;
    _userName = userName;
    _counterId = counterId;
    _category = category;
    _timePerClient = timePerClient;
    _fromTime = fromTime;
    _toTime = toTime;
    _totalToken = totalToken;
    _date = date;
    _createdAt = createdAt;
    _uniqueId = uniqueId;
}

  TomorrowTokens.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['user_name'];
    _counterId = json['counter_id'];
    _category = json['category'];
    _timePerClient = json['time_per_client'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _totalToken = json['total_token'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _uniqueId = json['unique_id'];
  }
  String? _id;
  String? _userName;
  String? _counterId;
  String? _category;
  String? _timePerClient;
  String? _fromTime;
  String? _toTime;
  String? _totalToken;
  String? _date;
  String? _createdAt;
  String? _uniqueId;
TomorrowTokens copyWith({  String? id,
  String? userName,
  String? counterId,
  String? category,
  String? timePerClient,
  String? fromTime,
  String? toTime,
  String? totalToken,
  String? date,
  String? createdAt,
  String? uniqueId,
}) => TomorrowTokens(  id: id ?? _id,
  userName: userName ?? _userName,
  counterId: counterId ?? _counterId,
  category: category ?? _category,
  timePerClient: timePerClient ?? _timePerClient,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  totalToken: totalToken ?? _totalToken,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  uniqueId: uniqueId ?? _uniqueId,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get counterId => _counterId;
  String? get category => _category;
  String? get timePerClient => _timePerClient;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get totalToken => _totalToken;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get uniqueId => _uniqueId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_name'] = _userName;
    map['counter_id'] = _counterId;
    map['category'] = _category;
    map['time_per_client'] = _timePerClient;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['total_token'] = _totalToken;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['unique_id'] = _uniqueId;
    return map;
  }

}

/// id : "2"
/// user_name : "Dr. rakesh sharma"
/// counter_id : "1"
/// category : "1"
/// time_per_client : "5"
/// from_time : "02:00 PM"
/// to_time : "01:00 PM"
/// total_token : "12"
/// date : "2024-01-11"
/// created_at : "2024-01-11 12:07:28"
/// unique_id : "Ind001"

class TodayTokens {
  TodayTokens({
      String? id, 
      String? userName, 
      String? counterId, 
      String? category, 
      String? timePerClient, 
      String? fromTime, 
      String? toTime, 
      String? totalToken, 
      String? date, 
      String? createdAt, 
      String? uniqueId,}){
    _id = id;
    _userName = userName;
    _counterId = counterId;
    _category = category;
    _timePerClient = timePerClient;
    _fromTime = fromTime;
    _toTime = toTime;
    _totalToken = totalToken;
    _date = date;
    _createdAt = createdAt;
    _uniqueId = uniqueId;
}

  TodayTokens.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['user_name'];
    _counterId = json['counter_id'];
    _category = json['category'];
    _timePerClient = json['time_per_client'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _totalToken = json['total_token'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _uniqueId = json['unique_id'];
  }
  String? _id;
  String? _userName;
  String? _counterId;
  String? _category;
  String? _timePerClient;
  String? _fromTime;
  String? _toTime;
  String? _totalToken;
  String? _date;
  String? _createdAt;
  String? _uniqueId;
TodayTokens copyWith({  String? id,
  String? userName,
  String? counterId,
  String? category,
  String? timePerClient,
  String? fromTime,
  String? toTime,
  String? totalToken,
  String? date,
  String? createdAt,
  String? uniqueId,
}) => TodayTokens(  id: id ?? _id,
  userName: userName ?? _userName,
  counterId: counterId ?? _counterId,
  category: category ?? _category,
  timePerClient: timePerClient ?? _timePerClient,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  totalToken: totalToken ?? _totalToken,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  uniqueId: uniqueId ?? _uniqueId,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get counterId => _counterId;
  String? get category => _category;
  String? get timePerClient => _timePerClient;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get totalToken => _totalToken;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get uniqueId => _uniqueId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_name'] = _userName;
    map['counter_id'] = _counterId;
    map['category'] = _category;
    map['time_per_client'] = _timePerClient;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['total_token'] = _totalToken;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['unique_id'] = _uniqueId;
    return map;
  }

}