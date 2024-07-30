// To parse this JSON data, do
//
//     final historySubmitRes = historySubmitResFromJson(jsonString);

import 'dart:convert';

import '../../../model/history_submit.dart';

HistorySubmitRes historySubmitResFromJson(String str) => HistorySubmitRes.fromJson(json.decode(str));

String historySubmitResToJson(HistorySubmitRes data) => json.encode(data.toJson());

class HistorySubmitRes {
  HistorySubmitRes({
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
  HistorySubmit? data;

  factory HistorySubmitRes.fromJson(Map<String, dynamic> json) => HistorySubmitRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : HistorySubmit.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}


