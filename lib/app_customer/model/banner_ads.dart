
class BannerAds {
  BannerAds({
    this.id,
    this.position,
    this.title,
    this.typeAction,
    this.value,
    this.imageUrl,
    this.isShow,
  });

  int? id;
  int? position;
  String? title;
  String? typeAction;
  String? value;
  String? imageUrl;
  bool? isShow;

  factory BannerAds.fromJson(Map<String, dynamic> json) => BannerAds(
    id: json["id"] == null ? null : json["id"],
    position: json["position"] == null ? null : json["position"],
    title: json["title"] == null ? null : json["title"],
    typeAction: json["type_action"] == null ? null : json["type_action"],
    value: json["value"] == null ? null : json["value"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    isShow: json["is_show"] == null ? null : json["is_show"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "position": position == null ? null : position,
    "title": title == null ? null : title,
    "type_action": typeAction == null ? null : typeAction,
    "value": value == null ? null : value,
    "image_url": imageUrl == null ? null : imageUrl,
    "is_show": isShow == null ? null : isShow,
  };
}
