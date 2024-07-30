class BannerItem {
  BannerItem({
    this.storeId,
    this.imageUrl,
    this.title,
    this.linkTo,
    this.createdAt,
    this.updatedAt,
  });

  int? storeId;
  String? imageUrl;
  String? title;
  String? linkTo;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        storeId: json["store_id"] == null ? null : json["store_id"],
        imageUrl: json["image_url"] == null ? null : json["image_url"] ?? "",
        title: json["title"] == null ? null : json["title"] ?? "",
        linkTo: json["link_to"] == null ? null : json["link_to"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "title": title,
        "link_to": linkTo,
      };
}
