import 'info_customer.dart';

class CommentPost {
  CommentPost({
    this.id,
    this.storeId,
    this.communityPostId,
    this.userId,
    this.staffId,
    this.customerId,
    this.imagesJson,
    this.status,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.staff,
    this.user,
    this.customer,
    this.images,
  });

  int? id;
  int? storeId;
  int? communityPostId;
  int? userId;
  int? staffId;
  int? customerId;
  String? imagesJson;
  int? status;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  InfoCustomer? staff;
  InfoCustomer? user;
  InfoCustomer? customer;
  List<String>? images;

  factory CommentPost.fromJson(Map<String, dynamic> json) => CommentPost(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        communityPostId: json["community_post_id"] == null
            ? null
            : json["community_post_id"],
        userId: json["user_id"],
        staffId: json["staff_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        imagesJson: json["images_json"] == null ? null : json["images_json"],
        status: json["status"] == null ? null : json["status"],
        content: json["content"] == null ? null : json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        staff:
            json["staff"] == null ? null : InfoCustomer.fromJson(json["staff"]),
        user: json["user"] == null ? null : InfoCustomer.fromJson(json["user"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "community_post_id": communityPostId == null ? null : communityPostId,
        "user_id": userId == null ? null : userId,
        "staff_id": staffId == null ? null : staffId,
        "customer_id": customerId == null ? null : customerId,
        "images_json": imagesJson == null ? null : imagesJson,
        "status": status == null ? null : status,
        "content": content == null ? null : content,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "staff": staff == null ? null : staff,
        "user": user == null ? null : user,
        "customer": customer == null ? null : customer?.toJson(),
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };
}
