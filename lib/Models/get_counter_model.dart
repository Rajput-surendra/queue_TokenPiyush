class GetHomeTokenModel {
  bool? error;
  String? message;
  List<TodaysTokens>? todaysTokens;

  GetHomeTokenModel({this.error, this.message, this.todaysTokens});

  GetHomeTokenModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['todays_tokens'] != null) {
      todaysTokens = <TodaysTokens>[];
      json['todays_tokens'].forEach((v) {
        todaysTokens!.add(new TodaysTokens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.todaysTokens != null) {
      data['todays_tokens'] =
          this.todaysTokens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodaysTokens {
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
  String? availableToken;
  String? currentToken;
  String? nextToken;
  String? companyName;
  String? city;

  TodaysTokens(
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
        this.availableToken,
        this.currentToken,
        this.nextToken,
        this.companyName,
        this.city});

  TodaysTokens.fromJson(Map<String, dynamic> json) {
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
    availableToken = json['available_token'];
    currentToken = json['current_token'];
    nextToken = json['next_token'];
    companyName = json['company_name'];
    city = json['city'];
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
    data['available_token'] = this.availableToken;
    data['current_token'] = this.currentToken;
    data['next_token'] = this.nextToken;
    data['company_name'] = this.companyName;
    data['city'] = this.city;
    return data;
  }
}
