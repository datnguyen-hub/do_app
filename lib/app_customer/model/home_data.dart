import 'banner_ads.dart';
import 'button_home.dart';
import 'product.dart';
import 'banner.dart';
import 'category.dart';
import 'post.dart';

enum HomeLayoutEnum {
  BUTTONS,
  CATEGORY,
  PRODUCTS_DISCOUNT,
  PRODUCTS_TOP_SALES,
  PRODUCTS_NEW,
  POSTS_NEW,
}

Map homeLayoutMap = {
  HomeLayoutEnum.BUTTONS: "HOME_BUTTON",
  HomeLayoutEnum.CATEGORY: "CATEGORY",
  HomeLayoutEnum.PRODUCTS_DISCOUNT: "PRODUCTS_DISCOUNT",
  HomeLayoutEnum.PRODUCTS_TOP_SALES: "PRODUCTS_TOP_SALES",
  HomeLayoutEnum.PRODUCTS_NEW: "PRODUCTS_NEW",
  HomeLayoutEnum.POSTS_NEW: "POSTS_NEW",
};

class HomeData {
  HomeData({
    this.listLayout,
    this.banner,
    this.popups,
    this.bannerAdsApp,
  });

  List<LayoutHome>? listLayout;
  BannerList? banner;
  List<Popup>? popups;
  BannerAdsApp? bannerAdsApp;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
      banner: BannerList.fromJson(json["banner"]),
      popups: json["popups"] == null
          ? null
          : List<Popup>.from(json["popups"].map((x) => Popup.fromJson(x))),
      bannerAdsApp: json["banner_ads_app"] == null
          ? null
          : BannerAdsApp.fromJson(json["banner_ads_app"]),
      listLayout: List<LayoutHome>.from(
          json["layouts"].map((x) => LayoutHome.fromJson(x))));
}

class LayoutHome {
  String? title;
  String? model;
  String? typeLayout;
  String? typeActionMore;
  List<BannerProduct>? bannerProduct;
  bool? hide;
  String? value;
  List<dynamic>? list;

  LayoutHome(
      {this.title,
      this.model,
      this.typeLayout,
      this.typeActionMore,
      this.hide,
      this.value,
      this.bannerProduct,
      this.list});

  factory LayoutHome.fromJson(Map<String, dynamic> json) {
    var list = [];

    if (json["list"] != null && json["list"] is List) {
      if (json["model"] == "HomeButton")
        list = List<HomeButton>.from(
            json["list"].map((x) => HomeButton.fromJson(x)));

      if (json["model"] == "Product")
        list = List<Product>.from(json["list"].map((x) => Product.fromJson(x)));

      if (json["model"] == "Category")
        list =
            List<Category>.from(json["list"].map((x) => Category.fromJson(x)));

      if (json["model"] == "Post")
        list = List<Post>.from(json["list"].map((x) => Post.fromJson(x)));
    }

    return LayoutHome(
      title: json["title"],
      bannerProduct: json["banner_ads"] == null ? [] : List<BannerProduct>.from(json["banner_ads"].map((x) => BannerProduct.fromJson(x))),
      typeLayout: json["type_layout"],
      model: json["model"],
      typeActionMore: json["type_action_more"],
      value:
          json["value_action"] == null ? null : json["value_action"].toString(),
      hide: json["hide"],
      list: list,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "type_layout": typeLayout,
        "type_action_more": typeActionMore,
        "hide": hide
      };
}

class BannerList {
  BannerList({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<BannerItem>? list;

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        name: json["name"],
        type: json["type"],
        list: List<BannerItem>.from(
            json["list"].map((x) => BannerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class Popup {
  Popup({
    this.id,
    this.storeId,
    this.name,
    this.linkImage,
    this.showOnce,
    this.typeAction,
    this.valueAction,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? name;
  String? linkImage;
  bool? showOnce;
  String? typeAction;
  String? valueAction;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Popup.fromJson(Map<String, dynamic> json) => Popup(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        name: json["name"] == null ? null : json["name"],
        linkImage: json["link_image"] == null ? null : json["link_image"],
        showOnce: json["show_once"] == null ? null : json["show_once"],
        typeAction: json["type_action"] == null ? null : json["type_action"],
        valueAction: json["value_action"] == null ? null : json["value_action"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class BannerAdsApp {
  BannerAdsApp({
    this.popups,
    this.position0,
    this.position1,
    this.position2,
    this.position3,
    this.position4,
    this.position5,
    this.position6,
    this.position7,
    this.position8,
  });
  List<Popup>? popups;
  List<BannerAds>? position0;
  List<BannerAds>? position1;
  List<BannerAds>? position2;
  List<BannerAds>? position3;
  List<BannerAds>? position4;
  List<BannerAds>? position5;
  List<BannerAds>? position6;
  List<BannerAds>? position7;
  List<BannerAds>? position8;

  factory BannerAdsApp.fromJson(Map<String, dynamic> json) => BannerAdsApp(
        popups: json["popups"] == null
            ? null
            : List<Popup>.from(json["popups"].map((x) => Popup.fromJson(x))),
        position0: json["position_0"] == null
            ? null
            : List<BannerAds>.from(
                json["position_0"].map((x) => BannerAds.fromJson(x))),
        position1: json["position_1"] == null
            ? null
            : List<BannerAds>.from(
                json["position_1"].map((x) => BannerAds.fromJson(x))),
        position2: json["position_2"] == null
            ? null
            : List<BannerAds>.from(
                json["position_2"].map((x) => BannerAds.fromJson(x))),
        position3: json["position_3"] == null
            ? null
            : List<BannerAds>.from(
                json["position_3"].map((x) => BannerAds.fromJson(x))),
        position4: json["position_4"] == null
            ? null
            : List<BannerAds>.from(
                json["position_4"].map((x) => BannerAds.fromJson(x))),
        position5: json["position_5"] == null
            ? null
            : List<BannerAds>.from(
                json["position_5"].map((x) => BannerAds.fromJson(x))),
        position6: json["position_6"] == null
            ? null
            : List<BannerAds>.from(
                json["position_6"].map((x) => BannerAds.fromJson(x))),
        position7: json["position_7"] == null
            ? null
            : List<BannerAds>.from(
                json["position_7"].map((x) => BannerAds.fromJson(x))),
        position8: json["position_8"] == null
            ? null
            : List<BannerAds>.from(
                json["position_8"].map((x) => BannerAds.fromJson(x))),
      );
}

class BannerProduct {
  String? image;
  String? link;

  BannerProduct({this.image, this.link});

  factory BannerProduct.fromJson(Map<String, dynamic> json) =>
      BannerProduct(image: json["image"], link: json["link"]);
}
