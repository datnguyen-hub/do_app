import 'package:sahashop_customer/app_customer/model/agency.dart';

class InfoPaymentAgencyResponse {
  InfoPaymentAgencyResponse({
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
  Agency? data;

  factory InfoPaymentAgencyResponse.fromJson(Map<String, dynamic> json) =>
      InfoPaymentAgencyResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Agency.fromJson(json["data"]),
      );
}


