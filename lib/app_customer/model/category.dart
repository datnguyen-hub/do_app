class Category {
  Category({
    this.id,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.isShowHome,
    this.totalProducts = 0,
    this.listCategoryChild,
    this.categoryId,
  });
  int? id;
  int? categoryId;
  String? name;
  dynamic imageUrl;
  bool? isShowHome;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Category>? listCategoryChild;
  int? totalProducts = 0;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        isShowHome: json["is_show_home"] == null ? null : json['is_show_home'],
        totalProducts:
            json["total_products"] == null ? null : json["total_products"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        listCategoryChild: json["category_children"] == null
            ? null
            : List<Category>.from(
                json["category_children"].map((x) => Category.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
    "is_show_home": isShowHome,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
