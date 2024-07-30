import 'dart:convert';

import '../../../model/home_data.dart';

LayoutRes layoutResFromJson(String str) => LayoutRes.fromJson(json.decode(str));

String layoutResToJson(LayoutRes data) => json.encode(data.toJson());

class LayoutRes {
  LayoutRes({
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

  factory LayoutRes.fromJson(Map<String, dynamic> json) => LayoutRes(
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
