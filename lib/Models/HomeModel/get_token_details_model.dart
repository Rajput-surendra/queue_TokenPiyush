class GetTokenDetailsModel {
  bool? error;
  String? message;
  List<Data>? data;

  GetTokenDetailsModel({this.error, this.message, this.data});

  GetTokenDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? tokenId;
  String? counterId;
  String? name;
  String? mobile;
  String? city;
  String? tokenNumber;
  String? time;
  String? status;
  String? date;
  String? createdAt;

  Data(
      {this.id,
        this.userId,
        this.tokenId,
        this.counterId,
        this.name,
        this.mobile,
        this.city,
        this.tokenNumber,
        this.time,
        this.status,
        this.date,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tokenId = json['token_id'];
    counterId = json['counter_id'];
    name = json['name'];
    mobile = json['mobile'];
    city = json['city'];
    tokenNumber = json['token_number'];
    time = json['time'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['token_id'] = this.tokenId;
    data['counter_id'] = this.counterId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['city'] = this.city;
    data['token_number'] = this.tokenNumber;
    data['time'] = this.time;
    data['status'] = this.status;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    return data;
  }
}
