import 'package:sahashop_customer/app_customer/model/mini_game.dart';

class JoinMiniGameRes {
  JoinMiniGameRes({
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

  factory JoinMiniGameRes.fromJson(Map<String, dynamic> json) =>
      JoinMiniGameRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
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
    this.storeId,
    this.spinWheelId,
    this.customerId,
    this.totalTurnPlay,
    this.totalCoinReceived,
    this.totalGiftReceived,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.spinWheel,
  });

  int? storeId;
  String? spinWheelId;
  int? customerId;
  int? totalTurnPlay;
  int? totalCoinReceived;
  int? totalGiftReceived;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  MiniGame? spinWheel;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        storeId: json["store_id"],
        spinWheelId: json["spin_wheel_id"],
        customerId: json["customer_id"],
        totalTurnPlay: json["total_turn_play"],
        totalCoinReceived: json["total_coin_received"],
        totalGiftReceived: json["total_gift_received"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        spinWheel: json["spin_wheel"] == null
            ? null
            : MiniGame.fromJson(json["spin_wheel"]),
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "spin_wheel_id": spinWheelId,
        "customer_id": customerId,
        "total_turn_play": totalTurnPlay,
        "total_coin_received": totalCoinReceived,
        "total_gift_received": totalGiftReceived,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "spin_wheel": spinWheel!.toJson(),
      };
}
