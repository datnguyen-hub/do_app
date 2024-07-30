import '../../../model/gift_winning.dart';

class GiftWinningRes {
  GiftWinningRes({
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

  factory GiftWinningRes.fromJson(Map<String, dynamic> json) => GiftWinningRes(
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
    this.giftWinning,
  });

  GiftWinning? giftWinning;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        giftWinning: json["gift_winning"] == null
            ? null
            : GiftWinning.fromJson(json["gift_winning"]),
      );

  Map<String, dynamic> toJson() => {
        "gift_winning": giftWinning!.toJson(),
      };
}
