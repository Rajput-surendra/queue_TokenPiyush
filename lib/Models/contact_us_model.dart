class ContactUsModel {
  String? mobile1;
  String? mobile2;
  String? whatsappNo;
  String? email1;
  String? email2;
  String? facebook;
  String? twitter;
  String? youtube;
  String? googlePlus;
  String? instagram;
  String? msg;
  bool? status;

  ContactUsModel(
      {this.mobile1,
        this.mobile2,
        this.whatsappNo,
        this.email1,
        this.email2,
        this.facebook,
        this.twitter,
        this.youtube,
        this.googlePlus,
        this.instagram,
        this.msg,
        this.status});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    mobile1 = json['mobile_1'];
    mobile2 = json['mobile_2'];
    whatsappNo = json['whatsapp_no'];
    email1 = json['email_1'];
    email2 = json['email_2'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    youtube = json['youtube'];
    googlePlus = json['google_plus'];
    instagram = json['instagram'];
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_1'] = this.mobile1;
    data['mobile_2'] = this.mobile2;
    data['whatsapp_no'] = this.whatsappNo;
    data['email_1'] = this.email1;
    data['email_2'] = this.email2;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['youtube'] = this.youtube;
    data['google_plus'] = this.googlePlus;
    data['instagram'] = this.instagram;
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}
