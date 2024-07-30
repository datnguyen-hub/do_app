// To parse this JSON data, do
//
//     final bannerRes = bannerResFromJson(jsonString);

import 'dart:convert';

import '../../../model/banner.dart';

BannerRes bannerResFromJson(String str) => BannerRes.fromJson(json.decode(str));

String bannerResToJson(BannerRes data) => json.encode(data.toJson());

class BannerRes {
  BannerRes({
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
  List<BannerItem>? data;

  factory BannerRes.fromJson(Map<String, dynamic> json) => BannerRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<BannerItem>.from(json["data"].map((x) => BannerItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
