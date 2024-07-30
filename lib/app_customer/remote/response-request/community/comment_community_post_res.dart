// To parse this JSON data, do
//
//     final commentCommunityPost = commentCommunityPostFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/comment_community.dart';

CommentCommunityPost commentCommunityPostFromJson(String str) =>
    CommentCommunityPost.fromJson(json.decode(str));

String commentCommunityPostToJson(CommentCommunityPost data) =>
    json.encode(data.toJson());

class CommentCommunityPost {
  CommentCommunityPost({
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
  CommentPost? data;

  factory CommentCommunityPost.fromJson(Map<String, dynamic> json) =>
      CommentCommunityPost(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : CommentPost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
