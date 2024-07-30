import 'dart:convert';


import '../../../model/home_data.dart';

ProductByCategoryRes productByCategoryResFromJson(String str) => ProductByCategoryRes.fromJson(json.decode(str));

String productByCategoryResToJson(ProductByCategoryRes data) => json.encode(data.toJson());

class ProductByCategoryRes {
  ProductByCategoryRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<LayoutHome>? data;

  factory ProductByCategoryRes.fromJson(Map<String, dynamic> json) => ProductByCategoryRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<LayoutHome>.from(json["data"].map((x) => LayoutHome.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
