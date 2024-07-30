class PlayGuessGameRes {
  PlayGuessGameRes({
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

  factory PlayGuessGameRes.fromJson(Map<String, dynamic> json) =>
      PlayGuessGameRes(
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
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.storeId,
    this.guessNumberId,
    this.playerGuessNumberId,
    this.guessNumberResultId,
    this.valuePredict,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.guessNumberResult,
  });

  int? storeId;
  String? guessNumberId;
  int? playerGuessNumberId;
  dynamic guessNumberResultId;
  String? valuePredict;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  dynamic guessNumberResult;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        storeId: json["store_id"],
        guessNumberId: json["guess_number_id"],
        playerGuessNumberId: json["player_guess_number_id"],
        guessNumberResultId: json["guess_number_result_id"],
        valuePredict: json["value_predict"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        guessNumberResult: json["guess_number_result"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "guess_number_id": guessNumberId,
        "player_guess_number_id": playerGuessNumberId,
        "guess_number_result_id": guessNumberResultId,
        "value_predict": valuePredict,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "guess_number_result": guessNumberResult,
      };
}
