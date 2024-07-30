class AllHistoryGiftRes {
  AllHistoryGiftRes({
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

  factory AllHistoryGiftRes.fromJson(Map<String, dynamic> json) =>
      AllHistoryGiftRes(
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
  List<HistoryGift>? data;

  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<HistoryGift>.from(
                json["data"]!.map((x) => HistoryGift.fromJson(x))),
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

class HistoryGift {
  HistoryGift(
      {this.id,
      this.storeId,
      this.playerSpinWheelId,
      this.amountCoinCurrent,
      this.amountGift,
      this.typeGift,
      this.amountCoinChange,
      this.amountCoinChanged,
      this.valueGift,
      this.text,
      this.createdAt,
      this.updatedAt,
      this.nameGift});

  int? id;
  int? storeId;
  int? playerSpinWheelId;
  int? amountCoinCurrent;
  int? amountGift;
  int? typeGift;
  int? amountCoinChange;
  int? amountCoinChanged;
  dynamic valueGift;
  dynamic text;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? nameGift;

  factory HistoryGift.fromJson(Map<String, dynamic> json) => HistoryGift(
      id: json["id"],
      storeId: json["store_id"],
      playerSpinWheelId: json["player_spin_wheel_id"],
      amountCoinCurrent: json["amount_coin_current"],
      amountGift: json["amount_gift"],
      typeGift: json["type_gift"],
      amountCoinChange: json["amount_coin_change"],
      amountCoinChanged: json["amount_coin_changed"],
      valueGift: json["value_gift"],
      text: json["text"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      nameGift: json['name_gift']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "player_spin_wheel_id": playerSpinWheelId,
        "amount_coin_current": amountCoinCurrent,
        "amount_gift": amountGift,
        "type_gift": typeGift,
        "amount_coin_change": amountCoinChange,
        "amount_coin_changed": amountCoinChanged,
        "value_gift": valueGift,
        "text": text,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
