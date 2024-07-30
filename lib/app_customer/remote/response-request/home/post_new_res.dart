// To parse this JSON data, do
//
//     final postNewRes = postNewResFromJson(jsonString);

import 'dart:convert';
import 'package:sahashop_customer/app_customer/model/post.dart';

PostNewRes postNewResFromJson(String str) => PostNewRes.fromJson(json.decode(str));

String postNewResToJson(PostNewRes data) => json.encode(data.toJson());

class PostNewRes {
  PostNewRes({
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
  List<Post>? data;

  factory PostNewRes.fromJson(Map<String, dynamic> json) => PostNewRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}