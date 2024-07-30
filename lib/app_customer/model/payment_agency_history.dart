class PaymentAgencyHistory {
  PaymentAgencyHistory({
    this.id,
    this.storeId,
    this.collaboratorId,
    this.type,
    this.currentBalance,
    this.money,
    this.referencesId,
    this.referencesValue,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.typeName,
  });

  int? id;
  int? storeId;
  int? collaboratorId;
  int? type;
  double? currentBalance;
  double? money;
  int? referencesId;
  String? referencesValue;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? typeName;

  factory PaymentAgencyHistory.fromJson(Map<String, dynamic> json) => PaymentAgencyHistory(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    collaboratorId: json["collaborator_id"] == null ? null : json["collaborator_id"],
    type: json["type"] == null ? null : json["type"],
    currentBalance: json["current_balance"] == null ? null : json["current_balance"].toDouble(),
    money: json["money"] == null ? null : json["money"].toDouble(),
    referencesId: json["references_id"] == null ? null : json["references_id"],
    referencesValue: json["references_value"] == null ? null : json["references_value"],
    note: json["note"] == null ? null : json["note"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    typeName: json["type_name"] == null ? null : json["type_name"],
  );
}


