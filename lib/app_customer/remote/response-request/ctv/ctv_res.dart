import '../../../model/ctv.dart';

class CtvRes {
  CtvRes({
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
  Ctv? data;

  factory CtvRes.fromJson(Map<String, dynamic> json) => CtvRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Ctv.fromJson(json["data"]),
  );
}