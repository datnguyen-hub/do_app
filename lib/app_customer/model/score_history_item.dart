class ScoreHistoryItem {
  ScoreHistoryItem({
    this.id,
    this.content,
    this.type,
    this.referencesValue,
    this.referencesNameCus,
    this.point,
    this.currentPoint,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? content;
  String? type;
  String? referencesValue;
  String? referencesNameCus;
  double? point;
  double? currentPoint;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ScoreHistoryItem.fromJson(Map<String, dynamic> json) =>
      ScoreHistoryItem(
        id: json["id"] == null ? null : json["id"],
        content: json["content"] == null ? null : json["content"],
        type: json["type"] == null ? null : json["type"],
        referencesValue: json["references_value"] == null ? null : json["references_value"],
        referencesNameCus: json["references_name_cus"] == null ? null : json["references_name_cus"],
        point: json["point"] == null ? null : json["point"].toDouble(),
        currentPoint: json["current_point"] == null
            ? null
            : json["current_point"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
