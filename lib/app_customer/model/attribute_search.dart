class AttributeSearch {
  AttributeSearch({
    this.id,
    this.name,
    this.imageUrl,
    this.storeId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.productAttributeSearchChildren,
    this.attributeSearchId,
    this.attributeSearchChildId,
    this.slug,
  });

  int? id;
  String? name;
  String? imageUrl;
  int? storeId;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AttributeSearch>? productAttributeSearchChildren;
  int? attributeSearchId;
  int? attributeSearchChildId;
  String? slug;

  factory AttributeSearch.fromJson(Map<String, dynamic> json) =>
      AttributeSearch(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        storeId: json["store_id"],
        position: json["position"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productAttributeSearchChildren:
            json["product_attribute_search_children"] == null
                ? []
                : List<AttributeSearch>.from(
                    json["product_attribute_search_children"]!
                        .map((x) => AttributeSearch.fromJson(x))),
        attributeSearchId: json["attribute_search_id"],
        attributeSearchChildId: json["attribute_search_child_id"] == null
            ? null
            : json["attribute_search_child_id"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "store_id": storeId,
        "position": position,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_attribute_search_children":
            productAttributeSearchChildren == null
                ? []
                : List<dynamic>.from(
                    productAttributeSearchChildren!.map((x) => x.toJson())),
        "attribute_search_id": attributeSearchId,
        "slug": slug,
      };
}
