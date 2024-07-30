// To parse this JSON data, do
//
//     final likePost = likePostFromJson(jsonString);



import '../../../model/community_post.dart';

class CommunityLikePostRes {
  CommunityLikePostRes({
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

  factory CommunityLikePostRes.fromJson(Map<String, dynamic> json) =>
      CommunityLikePostRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data:
            json["data"] == null ? null : CommunityPost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
