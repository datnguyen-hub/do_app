import '../../../model/mini_game.dart';

class AllMiniGameRes {
  AllMiniGameRes({
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

  factory AllMiniGameRes.fromJson(Map<String, dynamic> json) => AllMiniGameRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<MiniGame>? data;

  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<MiniGame>.from(
                json["data"]!.map((x) => MiniGame.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}
