
import 'package:sahashop_customer/app_customer/model/badge.dart';

class BadgeResponse {
  BadgeResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  BadgeModel? data;
  String? msgCode;
  String? msg;

  factory BadgeResponse.fromJson(Map<String, dynamic> json) => BadgeResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : BadgeModel.fromJson(json["data"]),
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );
}
