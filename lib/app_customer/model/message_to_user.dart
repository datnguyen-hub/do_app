
class MessageToUser {
  MessageToUser({
    this.id,
    this.customerId,
    this.content,
    this.linkImages,
    this.isUser,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? customerId;
  String? content;
  String? linkImages;
  bool? isUser;
  DateTime? createdAt;
  DateTime? updatedAt;


  factory MessageToUser.fromJson(Map<String, dynamic> json) => MessageToUser(
    id: json["id"] == null ? null : json["id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    content: json["content"] == null ? null : json["content"],
    linkImages: json["link_images"] == null ? null : json["link_images"],
    isUser: json["is_user"] == null ? null : json["is_user"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}