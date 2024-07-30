import 'package:sahashop_customer/app_customer/model/chapter.dart';

class ListChapterAndLessonRes {
  ListChapterAndLessonRes({
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
  List<Chapter>? data;

  factory ListChapterAndLessonRes.fromJson(Map<String, dynamic> json) =>
      ListChapterAndLessonRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<Chapter>.from(json["data"].map((x) => Chapter.fromJson(x))),
      );
}
