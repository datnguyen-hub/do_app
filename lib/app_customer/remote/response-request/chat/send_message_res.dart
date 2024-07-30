import '../../../model/message_to_user.dart';

class SendMessageRes {
  SendMessageRes({
    this.code,
    this.msgCode,
    this.msg,
    this.success,
    this.data,
  });

  int? code;
  String? msgCode;
  String? msg;
  bool? success;
  MessageToUser? data;

  factory SendMessageRes.fromJson(Map<String, dynamic> json) => SendMessageRes(
    code: json["code"] == null ? null : json["code"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : MessageToUser.fromJson(json["data"]),
  );
}


