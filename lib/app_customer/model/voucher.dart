import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

Voucher voucherFromJson(String str) => Voucher.fromJson(json.decode(str));

String voucherToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  Voucher({
    this.id,
    this.storeId,
    this.isEnd,
    this.voucherType,
    this.name,
    this.code,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.isFreeShip,
    this.discountFor,
    this.shipDiscountValue,
    this.valueDiscount,
    this.setLimitValueDiscount,
    this.maxValueDiscount,
    this.setLimitTotal,
    this.valueLimitTotal,
    this.isShowVoucher,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int? id;
  int? storeId;
  bool? isEnd;
  int? voucherType;
  String? name;
  String? code;
  String? description;
  String? imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  int? discountType;
  int? discountFor;
  bool? isFreeShip;
  double? shipDiscountValue;
  double? valueDiscount;
  bool? setLimitValueDiscount;
  int? maxValueDiscount;
  bool? setLimitTotal;
  int? valueLimitTotal;
  bool? isShowVoucher;
  bool? setLimitAmount;
  int? amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    isEnd: json["is_end"] == null ? null : json["is_end"],
    voucherType: json["voucher_type"] == null ? null : json["voucher_type"],
    name: json["name"] == null ? null : json["name"],
    code: json["code"] == null ? null : json["code"],
    description: json["description"] == null ? null : json["description"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    startTime: json["start_time"] == null
        ? null
        : DateTime.parse(json["start_time"]),
    endTime:
    json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    discountType:
    json["discount_type"] == null ? null : json["discount_type"],
    isFreeShip: json["is_free_ship"] == null ? null : json["is_free_ship"],
    discountFor: json["discount_for"] == null ? null : json["discount_for"],
    valueDiscount: json["value_discount"] == null
        ? null
        : json["value_discount"].toDouble(),
    shipDiscountValue: json["ship_discount_value"] == null
        ? null
        : json["ship_discount_value"].toDouble(),
    setLimitValueDiscount: json["set_limit_value_discount"] == null
        ? null
        : json["set_limit_value_discount"],
    maxValueDiscount: json["max_value_discount"] == null
        ? null
        : json["max_value_discount"],
    setLimitTotal:
    json["set_limit_total"] == null ? null : json["set_limit_total"],
    valueLimitTotal: json["value_limit_total"] == null
        ? null
        : json["value_limit_total"],
    isShowVoucher:
    json["is_show_voucher"] == null ? null : json["is_show_voucher"],
    setLimitAmount:
    json["set_limit_amount"] == null ? null : json["set_limit_amount"],
    amount: json["amount"] == null ? null : json["amount"],
    used: json["used"] == null ? null : json["used"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    products: json["products"] == null
        ? null
        : List<Product>.from(
        json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "is_end": isEnd,
    "voucher_type": voucherType,
    "name": name,
    "code": code,
    "description": description,
    "image_url": imageUrl,
    "start_time": startTime!.toIso8601String(),
    "end_time": endTime!.toIso8601String(),
    "discount_type": discountType,
    "value_discount": valueDiscount,
    "set_limit_value_discount": setLimitValueDiscount,
    "is_free_ship": isFreeShip,
    "discount_for": discountFor,
    "ship_discount_value": shipDiscountValue,
    "max_value_discount": maxValueDiscount,
    "set_limit_total": setLimitTotal,
    "value_limit_total": valueLimitTotal,
    "is_show_voucher": isShowVoucher,
    "set_limit_amount": setLimitAmount,
    "amount": amount,
    "used": used,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}
