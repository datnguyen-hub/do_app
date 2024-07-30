class JoinGuessNumberRes {
  JoinGuessNumberRes({
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
  JoinGuessNumber? data;

  factory JoinGuessNumberRes.fromJson(Map<String, dynamic> json) =>
      JoinGuessNumberRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : JoinGuessNumber.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class JoinGuessNumber {
  JoinGuessNumber({
    this.storeId,
    this.guessNumberId,
    this.customerId,
    this.totalTurnPlay,
    this.totalWin,
    this.totalMissed,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? storeId;
  String? guessNumberId;
  int? customerId;
  int? totalTurnPlay;
  int? totalWin;
  int? totalMissed;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory JoinGuessNumber.fromJson(Map<String, dynamic> json) =>
      JoinGuessNumber(
        storeId: json["store_id"],
        guessNumberId: json["guess_number_id"],
        customerId: json["customer_id"],
        totalTurnPlay: json["total_turn_play"],
        totalWin: json["total_win"],
        totalMissed: json["total_missed"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "guess_number_id": guessNumberId,
        "customer_id": customerId,
        "total_turn_play": totalTurnPlay,
        "total_win": totalWin,
        "total_missed": totalMissed,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
