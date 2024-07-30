// To parse this JSON data, do
//
//     final homeButtonRes = homeButtonResFromJson(jsonString);

import 'dart:convert';

import '../../../model/button_home.dart';

HomeButtonRes homeButtonResFromJson(String str) => HomeButtonRes.fromJson(json.decode(str));

String homeButtonResToJson(HomeButtonRes data) => json.encode(data.toJson());

class HomeButtonRes {
  HomeButtonRes({
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
  List<HomeButton>? data;

  factory HomeButtonRes.fromJson(Map<String, dynamic> json) => HomeButtonRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<HomeButton>.from(json["data"].map((x) => HomeButton.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

