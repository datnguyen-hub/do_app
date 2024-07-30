// To parse this JSON data, do
//
//     final listAttributeSearchRes = listAttributeSearchResFromJson(jsonString);

import 'dart:convert';

import '../../../model/attribute_search.dart';

ListAttributeSearchRes listAttributeSearchResFromJson(String str) => ListAttributeSearchRes.fromJson(json.decode(str));

String listAttributeSearchResToJson(ListAttributeSearchRes data) => json.encode(data.toJson());

class ListAttributeSearchRes {
  ListAttributeSearchRes({
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
  List<AttributeSearch>? data;

  factory ListAttributeSearchRes.fromJson(Map<String, dynamic> json) => ListAttributeSearchRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<AttributeSearch>.from(json["data"]!.map((x) => AttributeSearch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}