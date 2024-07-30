import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class FriendRequest {
  FriendRequest({
    this.id,
    this.storeId,
    this.customerId,
    this.toCustomerId,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  int? id;
  int? storeId;
  int? customerId;
  int? toCustomerId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  InfoCustomer? customer;

  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        toCustomerId:
            json["to_customer_id"] == null ? null : json["to_customer_id"],
        content: json["content"] == null ? null : json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
      );
}
