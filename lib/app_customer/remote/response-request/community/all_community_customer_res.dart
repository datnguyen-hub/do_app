import 'package:sahashop_customer/app_customer/model/community_post.dart';

class AllCommunityCustomerRes {
  AllCommunityCustomerRes({
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
  Data? data;

  factory AllCommunityCustomerRes.fromJson(Map<String, dynamic> json) =>
      AllCommunityCustomerRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<CommunityPost>? data;
  dynamic? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<CommunityPost>.from(
                json["data"].map((x) => CommunityPost.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.avatarImage,
  });

  int? id;
  String? name;
  String? avatarImage;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        avatarImage: json["avatar_image"] == null ? null : json["avatar_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "avatar_image": avatarImage == null ? null : avatarImage,
      };
}
