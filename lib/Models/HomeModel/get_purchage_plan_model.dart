class GetPlanListModel {
  bool? error;
  String? message;
  List<Data>? data;

  GetPlanListModel({this.error, this.message, this.data});

  GetPlanListModel.fromJson(Map<String, dynamic> json) {
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
  String? planId;
  String? startDate;
  String? endDate;
  String? price;
  String? title;
  String? status;

  Data(
      {this.id,
        this.userId,
        this.planId,
        this.startDate,
        this.endDate,
        this.price,
        this.title,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plan_id'] = this.planId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
