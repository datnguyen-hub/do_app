import '../../../model/history_submit.dart';

class AllHistorySubmitRes {
  AllHistorySubmitRes({
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
  Data? data;

  factory AllHistorySubmitRes.fromJson(Map<String, dynamic> json) =>
      AllHistorySubmitRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<HistorySubmit>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<HistorySubmit>.from(
                json["data"].map((x) => HistorySubmit.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}
