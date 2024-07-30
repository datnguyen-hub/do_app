class GiftWinning {
  GiftWinning({
    this.id,
    this.storeId,
    this.spinWheelId,
    this.userId,
    this.name,
    this.imageUrl,
    this.typeGift,
    this.amountCoin,
    this.percentReceived,
    this.amountGift,
    this.valueGift,
    this.text,
    this.applyFor,
    this.isLostTurn,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? spinWheelId;
  int? userId;
  String? name;
  String? imageUrl;
  int? typeGift;
  int? amountCoin;
  int? percentReceived;
  int? amountGift;
  String? valueGift;
  dynamic text;
  dynamic applyFor;
  int? isLostTurn;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GiftWinning.fromJson(Map<String, dynamic> json) => GiftWinning(
        id: json["id"],
        storeId: json["store_id"],
        spinWheelId: json["spin_wheel_id"],
        userId: json["user_id"],
        name: json["name"],
        imageUrl: json["image_url"],
        typeGift: json["type_gift"],
        amountCoin: json["amount_coin"],
        percentReceived: json["percent_received"],
        amountGift: json["amount_gift"],
        valueGift: json["value_gift"],
        text: json["text"],
        applyFor: json["apply_for"],
        isLostTurn: json["is_lost_turn"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "spin_wheel_id": spinWheelId,
        "user_id": userId,
        "name": name,
        "image_url": imageUrl,
        "type_gift": typeGift,
        "amount_coin": amountCoin,
        "percent_received": percentReceived,
        "amount_gift": amountGift,
        "value_gift": valueGift,
        "text": text,
        "apply_for": applyFor,
        "is_lost_turn": isLostTurn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
