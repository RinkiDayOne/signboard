class UploadProductImageModel {
  String? message;
  Data? data;
  String? status;

  UploadProductImageModel({this.message, this.data, this.status});

  UploadProductImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? fileId;

  Data({this.fileId});

  Data.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_id'] = this.fileId;
    return data;
  }
}


/* class UploadProductImageModel {
  String? message;
  Data? data;
  String? status;

  UploadProductImageModel({this.message, this.data, this.status});

  UploadProductImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? productImage;

  Data({this.productImage});

  Data.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image'] = this.productImage;
    return data;
  }
}
 */