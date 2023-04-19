class GetUserDetailModel {
  String? status;
  String? message;
  List<Data>? data;

  GetUserDetailModel({this.status, this.message, this.data});

  GetUserDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? fullname;
  String? username;
  String? mobileNumber;
  String? email;
  String? country;
  String? flag;
  String? dob;
  String? category;

  Data(
      {this.fullname,
      this.username,
      this.mobileNumber,
      this.email,
      this.country,
      this.flag,
      this.dob,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    country = json['country'];
    flag = json['flag'];
    dob = json['dob'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['country'] = this.country;
    data['flag'] = this.flag;
    data['dob'] = this.dob;
    data['category'] = this.category;
    return data;
  }
}
