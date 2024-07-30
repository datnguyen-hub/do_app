import 'package:sahashop_customer/app_customer/model/product.dart';

class AllProductResponse {
  int? code;
  bool? success;
  String? msgCode;
  List<Product>? data;

  AllProductResponse({this.code, this.success, this.msgCode, this.data});

  AllProductResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    if (json['data'] != null) {

      data = json['data'] != null
          ? List<Product>.from(
          json["data"].map((x) => Product.fromJson(x)))
          : [];

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
