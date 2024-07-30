import 'package:sahashop_customer/app_customer/model/general_info_payment_agency.dart';

class GeneralInfoPaymentAgencyResponse {
  GeneralInfoPaymentAgencyResponse({
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
  GeneralInfoPaymentAgency? data;

  factory GeneralInfoPaymentAgencyResponse.fromJson(Map<String, dynamic> json) =>
      GeneralInfoPaymentAgencyResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : GeneralInfoPaymentAgency.fromJson(json["data"]),
      );
}


