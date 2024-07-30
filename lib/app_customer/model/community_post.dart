
import 'package:sahashop_customer/app_customer/model/review.dart';

class CommunityPost {
  CommunityPost({
    this.id,
    this.storeId,
    this.userId,
    this.staffId,
    this.customerId,
    this.name,
    this.nameStrFilter,
    this.likes,
    this.content,
    this.timeRepost,
    this.positionPin,
    this.status,
    this.imagesJson,
    this.isPin,
    this.feeling,
    this.checkinLocation,
    this.backgroundColor = '',
    this.createdAt,
    this.updatedAt,
    this.isLike,
    this.totalLike,
    this.totalComment,
    this.staff,
    this.user,
    this.customer,
    this.images,
  });

  int? id;
  int? storeId;
  int? userId;
  int? staffId;
  int? customerId;
  String? name;
  String? nameStrFilter;
  int? likes;
  String? content;
  int? timeRepost;
  int? positionPin;
  int? status;
  String? imagesJson;
  bool? isPin;
  String? feeling;
  String? checkinLocation;
  String? backgroundColor = '';
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isLike;
  int? totalLike;
  int? totalComment;
  Customer? staff;
  Customer? user;
  Customer? customer;
  List<String>? images;

  factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        staffId: json["staff_id"],
        customerId: json["customer_id"],
        name: json["name"] == null ? null : json["name"],
        nameStrFilter:
            json["name_str_filter"] == null ? null : json["name_str_filter"],
        likes: json["likes"] == null ? null : json["likes"],
        content: json["content"] == null ? null : json["content"],
        timeRepost: json["time_repost"] == null ? null : json["time_repost"],
        positionPin: json["position_pin"] == null ? null : json["position_pin"],
        status: json["status"] == null ? null : json["status"],
        isPin: json["is_pin"] == null ? null : json["is_pin"],
        feeling: json["feeling"],
        checkinLocation: json["checkin_location"],
        backgroundColor: json["background_color"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isLike: json["is_like"] == null ? null : json["is_like"],
        totalLike: json["total_like"] == null ? null : json["total_like"],
        totalComment:
            json["total_comment"] == null ? null : json["total_comment"],
        staff: json["staff"] == null ? null : Customer.fromJson(json["staff"]),
        user: json["user"] == null ? null : Customer.fromJson(json["user"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "position_pin": positionPin == null ? null : positionPin,
        "is_pin": isPin == null ? null : isPin,
        "feeling": feeling,
        "status": status,
        "checkin_location": checkinLocation,
        "background_color": backgroundColor,
        "is_like": isLike == null ? null : isLike,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };
}
