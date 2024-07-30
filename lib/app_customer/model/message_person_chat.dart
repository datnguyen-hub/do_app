class MessagePersonChat {
  MessagePersonChat({
    this.id,
    this.storeId,
    this.customerId,
    this.vsCustomerId,
    this.isSender,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  int? id;
  int? storeId;
  int? customerId;
  int? vsCustomerId;
  bool? isSender;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? images;

  factory MessagePersonChat.fromJson(Map<String, dynamic> json) =>
      MessagePersonChat(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        vsCustomerId:
            json["vs_customer_id"] == null ? null : json["vs_customer_id"],
        isSender: json["is_sender"] == null ? null : json["is_sender"],
        content: json["content"] == null ? null : json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );
  Map<String, dynamic> toJson() => {
    "content": content == null ? null : content,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
  };
}

