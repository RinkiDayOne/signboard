class GetSignboardModel {
  String? status;
  String? message;
  List<Data>? data;

  GetSignboardModel({this.status, this.message, this.data});

  GetSignboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? signboardId;
  String? namesss;
  String? signboardName;
  String? signboardDesc;
  String? signboardCategory;
  String? signboardBgColor;
  String? signboardFontColor;
  String? priceType;
  String? price;
  String? locationName;
  String? startdatetime;
  String? enddatetime;
  String? duration;
  String? likes;
  String? signboardImageId;
  String? country;
  String? flag;
  String? province;
  String? email;
  String? callnumber;
  String? weburl;
  String? whatsapp;
  String? keywords;

  Data(
      {this.signboardId,
      this.namesss,
      this.signboardName,
      this.signboardDesc,
      this.signboardCategory,
      this.signboardBgColor,
      this.signboardFontColor,
      this.priceType,
      this.price,
      this.locationName,
      this.startdatetime,
      this.enddatetime,
      this.duration,
      this.likes,
      this.signboardImageId,
      this.country,
      this.flag,
      this.province,
      this.email,
      this.callnumber,
      this.weburl,
      this.whatsapp,
      this.keywords});

  Data.fromJson(Map<String, dynamic> json) {
    signboardId = json['signboard_id'];
    namesss = json['namesss'];
    signboardName = json['signboard_name'];
    signboardDesc = json['signboard_desc'];
    signboardCategory = json['signboard_category'];
    signboardBgColor = json['signboard_bg_color'];
    signboardFontColor = json['signboard_font_color'];
    priceType = json['price_type'];
    price = json['price'];
    locationName = json['location_name'];
    startdatetime = json['startdatetime'];
    enddatetime = json['enddatetime'];
    duration = json['duration'];
    likes = json['likes'];
    signboardImageId = json['signboard_image_id'];
    country = json['country'];
    flag = json['flag'];
    province = json['province'];
    email = json['email'];
    callnumber = json['callnumber'];
    weburl = json['weburl'];
    whatsapp = json['whatsapp'];
    keywords = json['keywords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signboard_id'] = this.signboardId;
    data['namesss'] = this.namesss;
    data['signboard_name'] = this.signboardName;
    data['signboard_desc'] = this.signboardDesc;
    data['signboard_category'] = this.signboardCategory;
    data['signboard_bg_color'] = this.signboardBgColor;
    data['signboard_font_color'] = this.signboardFontColor;
    data['price_type'] = this.priceType;
    data['price'] = this.price;
    data['location_name'] = this.locationName;
    data['startdatetime'] = this.startdatetime;
    data['enddatetime'] = this.enddatetime;
    data['duration'] = this.duration;
    data['likes'] = this.likes;
    data['signboard_image_id'] = this.signboardImageId;
    data['country'] = this.country;
    data['flag'] = this.flag;
    data['province'] = this.province;
    data['email'] = this.email;
    data['callnumber'] = this.callnumber;
    data['weburl'] = this.weburl;
    data['whatsapp'] = this.whatsapp;
    data['keywords'] = this.keywords;
    return data;
  }
}
