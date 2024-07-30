import 'package:sahashop_customer/app_customer/model/mini_game.dart';

class GetTurnRes {
  GetTurnRes({
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

  factory GetTurnRes.fromJson(Map<String, dynamic> json) => GetTurnRes(
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
    this.id,
    this.storeId,
    this.spinWheelId,
    this.customerId,
    this.totalTurnPlay,
    this.totalCoinReceived,
    this.totalGiftReceived,
    this.createdAt,
    this.updatedAt,
    this.spinWheel,
  });

  int? id;
  int? storeId;
  int? spinWheelId;
  int? customerId;
  int? totalTurnPlay;
  int? totalCoinReceived;
  int? totalGiftReceived;
  DateTime? createdAt;
  DateTime? updatedAt;
  MiniGame? spinWheel;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        storeId: json["store_id"],
        spinWheelId: json["spin_wheel_id"],
        customerId: json["customer_id"],
        totalTurnPlay: json["total_turn_play"],
        totalCoinReceived: json["total_coin_received"],
        totalGiftReceived: json["total_gift_received"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        spinWheel: json["spin_wheel"] == null
            ? null
            : MiniGame.fromJson(json["spin_wheel"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "spin_wheel_id": spinWheelId,
        "customer_id": customerId,
        "total_turn_play": totalTurnPlay,
        "total_coin_received": totalCoinReceived,
        "total_gift_received": totalGiftReceived,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "spin_wheel": spinWheel!.toJson(),
      };
}
