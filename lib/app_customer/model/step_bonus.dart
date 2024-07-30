class StepsBonus {
  StepsBonus({
    this.id,
    this.storeId,
    this.limit,
    this.bonus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  double? limit;
  double? bonus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StepsBonus.fromJson(Map<String, dynamic> json) => StepsBonus(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    limit: json["limit"] == null ? null : json["limit"].toDouble(),
    bonus: json["bonus"] == null ? null : json["bonus"].toDouble(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}