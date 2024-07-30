
import '../../../model/community_customer_profile.dart';

class CommunityCustomerProfileRes {
  CommunityCustomerProfileRes({
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
  CommunityCustomerProfile? data;

  factory CommunityCustomerProfileRes.fromJson(Map<String, dynamic> json) =>
      CommunityCustomerProfileRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : CommunityCustomerProfile.fromJson(json["data"]),
      );
}
