class UpdateTokenModel {
  bool? error;
  String? message;
  List<Data>? data;

  UpdateTokenModel({this.error, this.message, this.data});

  UpdateTokenModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userName;
  String? counterId;
  String? category;
  String? timePerClient;
  String? fromTime;
  String? toTime;
  String? totalToken;
  String? date;
  String? createdAt;
  String? type;

  Data(
      {this.id,
        this.userName,
        this.counterId,
        this.category,
        this.timePerClient,
        this.fromTime,
        this.toTime,
        this.totalToken,
        this.date,
        this.createdAt,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    counterId = json['counter_id'];
    category = json['category'];
    timePerClient = json['time_per_client'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    totalToken = json['total_token'];
    date = json['date'];
    createdAt = json['created_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['counter_id'] = this.counterId;
    data['category'] = this.category;
    data['time_per_client'] = this.timePerClient;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['total_token'] = this.totalToken;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    return data;
  }
}
