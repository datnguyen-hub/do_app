import 'package:sahashop_customer/app_customer/model/lesson.dart';

class ListLessonRes {
  ListLessonRes({
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
  Lesson? data;

  factory ListLessonRes.fromJson(Map<String, dynamic> json) => ListLessonRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Lesson.fromJson(json["data"]),
      );
}
