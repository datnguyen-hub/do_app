// To parse this JSON data, do
//
//     final attributeSearchRes = attributeSearchResFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/attribute_search.dart';

AttributeSearchRes attributeSearchResFromJson(String str) => AttributeSearchRes.fromJson(json.decode(str));

String attributeSearchResToJson(AttributeSearchRes data) => json.encode(data.toJson());

class AttributeSearchRes {
  AttributeSearchRes({
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
  AttributeSearch? data;

  factory AttributeSearchRes.fromJson(Map<String, dynamic> json) => AttributeSearchRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : AttributeSearch.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data?.toJson(),
  };
}
