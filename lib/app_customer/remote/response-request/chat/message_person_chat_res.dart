import '../../../model/message_person_chat.dart';

class MessagePersonChatRes {
  MessagePersonChatRes({
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
  MessagePersonChat? data;

  factory MessagePersonChatRes.fromJson(Map<String, dynamic> json) => MessagePersonChatRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : MessagePersonChat.fromJson(json["data"]),
  );

}

