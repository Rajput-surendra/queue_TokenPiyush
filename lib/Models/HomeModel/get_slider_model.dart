class GetSliderModel {
  List<Sliderdata>? sliderdata;
  String? msg;
  bool? status;

  GetSliderModel({this.sliderdata, this.msg, this.status});

  GetSliderModel.fromJson(Map<String, dynamic> json) {
    if (json['sliderdata'] != null) {
      sliderdata = <Sliderdata>[];
      json['sliderdata'].forEach((v) {
        sliderdata!.add(new Sliderdata.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliderdata != null) {
      data['sliderdata'] = this.sliderdata!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class Sliderdata {
  String? imageId;
  String? sliderImage;

  Sliderdata({this.imageId, this.sliderImage});

  Sliderdata.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    sliderImage = json['slider_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['slider_image'] = this.sliderImage;
    return data;
  }
}
