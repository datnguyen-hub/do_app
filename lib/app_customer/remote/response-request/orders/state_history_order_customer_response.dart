
import 'package:sahashop_customer/app_customer/model/state_order.dart';

class StateHistoryOrderCustomerResponse {
  StateHistoryOrderCustomerResponse({
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
  List<StateOrder>? data;

  factory StateHistoryOrderCustomerResponse.fromJson(
          Map<String, dynamic> json) =>
      StateHistoryOrderCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: List<StateOrder>.from(
            json["data"].map((x) => StateOrder.fromJson(x))),
      );

}
