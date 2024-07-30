class RewardPointCtm {
  RewardPointCtm({
    this.id,
    this.storeId,
    this.pointReview,
    this.pointIntroduceCustomer,
    this.percentRefund,
    this.moneyAPoint,
    this.orderMaxPoint,
    this.isSetOrderMaxPoint,
    this.allowUsePointOrder,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  double? pointReview;
  double? pointIntroduceCustomer;
  double? percentRefund;
  double? moneyAPoint;
  double? orderMaxPoint;
  bool? isSetOrderMaxPoint;
  bool? allowUsePointOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory RewardPointCtm.fromJson(Map<String, dynamic> json) => RewardPointCtm(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        pointReview: json["point_review"] == null
            ? null
            : json["point_review"].toDouble(),
        pointIntroduceCustomer: json["point_introduce_customer"] == null
            ? null
            : json["point_introduce_customer"].toDouble(),
        percentRefund: json["percent_refund"] == null
            ? null
            : json["percent_refund"].toDouble(),
        moneyAPoint: json["money_a_point"] == null
            ? null
            : json["money_a_point"].toDouble(),
        orderMaxPoint: json["order_max_point"] == null
            ? null
            : json["order_max_point"].toDouble(),
        isSetOrderMaxPoint: json["is_set_order_max_point"] == null
            ? null
            : json["is_set_order_max_point"],
        allowUsePointOrder: json["allow_use_point_order"] == null
            ? null
            : json["allow_use_point_order"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
