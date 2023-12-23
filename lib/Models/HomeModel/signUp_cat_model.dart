class GetCatModel {
  bool? error;
  String? message;
  List<SignUpCat>? data;

  GetCatModel({this.error, this.message, this.data});

  GetCatModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SignUpCat>[];
      json['data'].forEach((v) {
        data!.add(new SignUpCat.fromJson(v));
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

class SignUpCat {
  String? id;
  String? name;
  String? status;

  SignUpCat({this.id, this.name, this.status});

  SignUpCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
