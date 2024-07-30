// To parse this JSON data, do
//
//     final communityPostRes = communityPostResFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/community_post.dart';

CommunityPostRes communityPostResFromJson(String str) => CommunityPostRes.fromJson(json.decode(str));

String communityPostResToJson(CommunityPostRes data) => json.encode(data.toJson());

class CommunityPostRes {
  CommunityPostRes({
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
  CommunityPost? data;

  factory CommunityPostRes.fromJson(Map<String, dynamic> json) => CommunityPostRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : CommunityPost.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}
