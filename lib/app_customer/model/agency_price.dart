import 'package:sahashop_customer/app_customer/model/product.dart';

class AgencyPrice {
  AgencyPrice({
    this.mainPrice,
    this.minPrice,
    this.maxPrice,
    this.distributes,
    this.percentAgency = 0,
  });

  double? mainPrice;
  double? minPrice;
  double? maxPrice;
  List<Distributes>? distributes;
  double? percentAgency;

  factory AgencyPrice.fromJson(Map<String, dynamic> json) => AgencyPrice(
    mainPrice: json["main_price"] == null ? null : json["main_price"].toDouble(),
    minPrice: json["min_price"] == null ? null : json["min_price"].toDouble(),
    maxPrice: json["max_price"] == null ? null : json["max_price"].toDouble(),
    percentAgency: json["percent_agency"] == null ? null : json["percent_agency"].toDouble(),
    distributes: json["distributes"] == null ? null : List<Distributes>.from(json["distributes"].map((x) => Distributes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "main_price": mainPrice == null ? null : mainPrice,
    "distributes": distributes == null ? null : List<dynamic>.from(distributes!.map((x) => x.toJson())),
  };
}