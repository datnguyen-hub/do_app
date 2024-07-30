import 'dart:convert';
import 'package:flutter/material.dart';

import 'combo.dart';
import 'info_address_customer.dart';
import 'info_customer.dart';
import 'product.dart';
import 'step_bonus_agency.dart';


const ALL = "";
const WAITING_FOR_PROGRESSING = "WAITING_FOR_PROGRESSING";
const PACKING = "PACKING";
const OUT_OF_STOCK = "OUT_OF_STOCK";
const USER_CANCELLED = "USER_CANCELLED";
const CUSTOMER_CANCELLED = "CUSTOMER_CANCELLED";
const SHIPPING = "SHIPPING";
const DELIVERY_ERROR = "DELIVERY_ERROR";
const COMPLETED = "COMPLETED";
const CUSTOMER_RETURNING = "CUSTOMER_RETURNING";
const CUSTOMER_HAS_RETURNS = "CUSTOMER_HAS_RETURNS";
const WAIT_FOR_PAYMENT = "WAIT_FOR_PAYMENT";

/// status payment
const UNPAID = "UNPAID";
const PAID = "PAID";
const PARTIALLY_PAID = "PARTIALLY_PAID";
const CANCELLED = "CANCELLED";
const REFUNDS = "REFUNDS";

Map<String, String> ORDER_STATUS_DEFINE = {
  WAITING_FOR_PROGRESSING: "Chờ xử lý",
  PACKING: "Đang chuẩn bị hàng",
  OUT_OF_STOCK: "Hết hàng",
  USER_CANCELLED: "Shop huỷ",
  CUSTOMER_CANCELLED: "Khách đã hủy",
  SHIPPING: "Đang giao hàng",
  DELIVERY_ERROR: "Lỗi giao hàng",
  COMPLETED: "Đã hoàn thành",
  CUSTOMER_RETURNING: "Chờ trả hàng",
  CUSTOMER_HAS_RETURNS: "Đơn hoàn tiền",
  WAIT_FOR_PAYMENT: "Đợi thanh toán",
  ALL : "Tất cả"
};

Map<String, String> ORDER_PAYMENT_DEFINE = {
  WAITING_FOR_PROGRESSING: "Chờ xử lý",
  UNPAID: "Chưa thanh toán",
  PAID: "Đã thanh toán",
  PARTIALLY_PAID: "Đã thanh toán một phần",
  CUSTOMER_CANCELLED: "Khách hủy",
  REFUNDS: "Đã hoàn tiền",
};

final mapStatusColor = {
  WAITING_FOR_PROGRESSING: Colors.amber,
  UNPAID: Colors.redAccent,
  PAID: Colors.green,
  PARTIALLY_PAID: Colors.redAccent,
  CUSTOMER_CANCELLED: Colors.red,
  REFUNDS: Colors.blue,
  PACKING: Colors.teal,
  OUT_OF_STOCK: Colors.redAccent,
  USER_CANCELLED: Colors.red,
  SHIPPING: Colors.orange,
  DELIVERY_ERROR: Colors.red,
  COMPLETED: Colors.green,
  CUSTOMER_RETURNING: Colors.amber,
  CUSTOMER_HAS_RETURNS: Colors.red,
  WAIT_FOR_PAYMENT: Colors.amber,
};

class Order {
  Order({
    this.id,
    this.customerId,
    this.orderCode,
    this.orderCodeRefund,
    this.orderStatus,
    this.paymentStatus,
    this.paymentMethodId,
    this.partnerShipperId,
    this.shipperType,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.comboDiscountAmount,
    this.productDiscountAmount,
    this.voucherDiscountAmount,
    this.totalAfterDiscount,
    this.totalFinal,
    this.discount,
    this.customerNote,
    this.createdAt,
    this.updatedAt,
    this.paymentStatusCode,
    this.paymentStatusName,
    this.orderStatusCode,
    this.orderStatusName,
    this.paymentMethodName,
    this.lineItems,
    this.shipperName,
    this.customerAddress,
    this.customerUsedDiscount,
    this.customerUsedCombos,
    this.customerUsedVoucher,
    this.lineItemsAtTime,
    this.infoCustomer,
    this.bonusPointsAmountUsed,
    this.paymentPartnerName,
    this.balanceCollaboratorUsed,
    this.shipDiscountAmount,
    this.reviewed,
    this.bonusAgencyHistory,
    this.remainingAmount,
    this.sentDelivery,
    this.branch,
    this.branchId,
    this.orderFrom,
    this.shareCollaborator,
    this.shareAgency,
    this.balanceAgencyUsed,
    this.packageWeight,
    this.packageLength,
    this.packageWidth,
    this.packageHeight,this.vat,this.cod,this.isOrderForCustomer,this.totalCommissionOrderForCustomer
  });

  int? id;
  int? customerId;
  String? orderCode;
  String? orderCodeRefund;
  int? orderStatus;
  int? paymentStatus;
  int? paymentMethodId;
  int? partnerShipperId;
  int? shipperType;
  int? branchId;
  double? totalShippingFee;
  double? packageWeight;
  double? packageLength;
  double? packageWidth;
  double? packageHeight;
  double? totalBeforeDiscount;
  double? comboDiscountAmount;
  double? productDiscountAmount;
  double? voucherDiscountAmount;
  double? totalAfterDiscount;
  double? shipDiscountAmount;
  double? totalFinal;
  double? discount;

  dynamic customerNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? remainingAmount;
  String? paymentStatusCode;
  String? paymentStatusName;
  String? orderStatusCode;
  String? orderStatusName;
  List<LineItem>? lineItems;
  Branch? branch;
  String? paymentMethodName;
  String? paymentPartnerName;
  String? shipperName;
  InfoAddressCustomer? customerAddress;
  List<CustomerUsedDiscount>? customerUsedDiscount;
  List<CustomerUsedCombo>? customerUsedCombos;
  dynamic customerUsedVoucher;
  List<LineItemsAtTime>? lineItemsAtTime;
  InfoCustomer? infoCustomer;
  double? bonusPointsAmountUsed;
  double? balanceCollaboratorUsed;
  double? balanceAgencyUsed;
  double? shareCollaborator;
  double? shareAgency;
  bool? reviewed;
  StepBonusAgency? bonusAgencyHistory;
  bool? sentDelivery;
  int? orderFrom;
  double? vat;
  double? cod;
  bool? isOrderForCustomer;
  double? totalCommissionOrderForCustomer;
  

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"],
      customerId: json["customer_id"],
      orderCode: json["order_code"],
      orderStatus: json["order_status"],
      orderCodeRefund:
          json["order_code_refund"] == null ? null : json["order_code_refund"],
      paymentStatus: json["payment_status"],
      packageWeight: json["package_weight"] == null
          ? null
          : json["package_weight"].toDouble(),
      packageHeight: json["package_height"] == null
          ? null
          : json["package_height"].toDouble(),
      packageWidth: json["package_width"] == null
          ? null
          : json["package_width"].toDouble(),
      packageLength: json["package_length"] == null
          ? null
          : json["package_length"].toDouble(),
      paymentMethodId: json["payment_method_id"],
      partnerShipperId: json["partner_shipper_id"],
      shipperType: json["shipper_type"],
      branchId: json["branch_id"] == null ? null : json["branch_id"],
      remainingAmount: json["remaining_amount"] == null
          ? null
          : json['remaining_amount'].toDouble(),
      shipDiscountAmount: json["ship_discount_amount"] == null
          ? null
          : json['ship_discount_amount'].toDouble(),
      totalShippingFee: json["total_shipping_fee"] == null
          ? null
          : json["total_shipping_fee"].toDouble(),
      totalBeforeDiscount: json["total_before_discount"] == null
          ? null
          : json["total_before_discount"].toDouble(),
      comboDiscountAmount: json["combo_discount_amount"] == null
          ? null
          : json["combo_discount_amount"].toDouble(),
      shareAgency:
          json["share_agency"] == null ? null : json["share_agency"].toDouble(),
      shareCollaborator: json["share_collaborator"] == null
          ? null
          : json["share_collaborator"].toDouble(),
      productDiscountAmount: json["product_discount_amount"] == null
          ? null
          : json["product_discount_amount"].toDouble(),
      voucherDiscountAmount: json["voucher_discount_amount"] == null
          ? null
          : json["voucher_discount_amount"].toDouble(),
      totalAfterDiscount: json["total_after_discount"] == null
          ? null
          : json["total_after_discount"].toDouble(),
      discount: json["discount"] == null ? null : json["discount"].toDouble(),
      totalFinal:
          json["total_final"] == null ? null : json["total_final"].toDouble(),
      customerNote: json["customer_note"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      paymentStatusCode: json["payment_status_code"],
      paymentStatusName: json["payment_status_name"],
      orderStatusCode: json["order_status_code"],
      orderStatusName: json["order_status_name"],
      lineItems: json["line_items"] == null
          ? null
          : List<LineItem>.from(
              json["line_items"].map((x) => LineItem.fromJson(x))),
      paymentMethodName: json["payment_method_name"],
      paymentPartnerName: json["payment_partner_name"],
      shipperName: json["shipper_name"],
      customerAddress: json["customer_address"] == null
          ? null
          : InfoAddressCustomer.fromJson(json["customer_address"]),
      customerUsedDiscount: json["customer_used_discount"] == null
          ? null
          : List<CustomerUsedDiscount>.from(json["customer_used_discount"]
              .map((x) => CustomerUsedDiscount.fromJson(x))),
      customerUsedCombos: json["customer_used_combos"] == null
          ? null
          : List<CustomerUsedCombo>.from(json["customer_used_combos"]
              .map((x) => CustomerUsedCombo.fromJson(x))),
      customerUsedVoucher: json["customer_used_voucher"],
      lineItemsAtTime: json["line_items_at_time"] == null
          ? null
          : List<LineItemsAtTime>.from(
              json["line_items_at_time"].map((x) => LineItemsAtTime.fromJson(x))),
      infoCustomer: json["customer"] == null ? null : InfoCustomer.fromJson(json["customer"]),
      branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      bonusAgencyHistory: json["bonus_agency_history"] == null ? null : StepBonusAgency.fromJson(json["bonus_agency_history"]),
      bonusPointsAmountUsed: json["bonus_points_amount_used"] == null ? null : json["bonus_points_amount_used"].toDouble(),
      balanceCollaboratorUsed: json["balance_collaborator_used"] == null ? null : json["balance_collaborator_used"].toDouble(),
      balanceAgencyUsed: json["balance_agency_used"] == null ? null : json["balance_agency_used"].toDouble(),
      reviewed: json["reviewed"] == null ? false : json["reviewed"],
      sentDelivery: json["sent_delivery"] == null ? false : json["sent_delivery"],
      orderFrom: json['order_from'] == null ? null : json['order_from'],
      vat : json['vat'] == null ? null : json['vat'].toDouble(),
      cod: json['cod'] == null ? null : json['cod'].toDouble(),
      isOrderForCustomer : json["is_order_for_customer"],
      totalCommissionOrderForCustomer: json["total_commission_order_for_customer"] == null ? null : json["total_commission_order_for_customer"].toDouble()

     
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "order_code": orderCode,
        "order_from": orderFrom,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "payment_method_id": paymentMethodId,
        "partner_shipper_id": partnerShipperId,
        "shipper_type": shipperType,
        "total_shipping_fee": totalShippingFee,
        "package_weight": packageWeight,
        "package_length": packageLength,
        "package_width": packageWidth,
        "package_height": packageWeight,
        "total_before_discount": totalBeforeDiscount,
        "combo_discount_amount": comboDiscountAmount,
        "product_discount_amount": productDiscountAmount,
        "voucher_discount_amount": voucherDiscountAmount,
        "total_after_discount": totalAfterDiscount,
        "total_final": totalFinal,
        "customer_note": customerNote,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "line_items": List<dynamic>.from(lineItems!.map((x) => x.toJson())),
        "payment_method_name": paymentMethodName,
        "payment_partner_name": paymentPartnerName,
        "shipper_name": shipperName,
        "sent_delivery": sentDelivery,
        "customer_address": customerAddress!.toJson(),
        "customer_used_discount":
            List<dynamic>.from(customerUsedDiscount!.map((x) => x.toJson())),
        "customer_used_combos":
            List<dynamic>.from(customerUsedCombos!.map((x) => x.toJson())),
        "customer_used_voucher": customerUsedVoucher,
        "line_items_at_time":
            List<dynamic>.from(lineItemsAtTime!.map((x) => x.toJson())),
        "vat": vat,
        "cod": cod,
        "total_commission_order_for_customer" : totalCommissionOrderForCustomer,
        "is_order_for_customer" :isOrderForCustomer
      };
}

class CustomerUsedCombo {
  CustomerUsedCombo({
    this.combo,
    this.quantity,
  });

  Combo? combo;
  int? quantity;

  factory CustomerUsedCombo.fromJson(Map<String, dynamic> json) =>
      CustomerUsedCombo(
        combo: Combo.fromJson(json["combo"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "combo": combo!.toJson(),
        "quantity": quantity,
      };
}

class CustomerUsedDiscount {
  CustomerUsedDiscount({
    this.id,
    this.quantity,
    this.name,
    this.beforePrice,
    this.afterDiscount,
  });

  int? id;
  int? quantity;
  String? name;
  double? beforePrice;
  double? afterDiscount;

  factory CustomerUsedDiscount.fromJson(Map<String, dynamic> json) =>
      CustomerUsedDiscount(
        id: json["id"],
        quantity: json["quantity"],
        name: json["name"],
        beforePrice: json["before_price"] == null
            ? null
            : json["before_price"].toDouble(),
        afterDiscount: json["after_discount"] == null
            ? null
            : json["after_discount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "name": name,
        "before_price": beforePrice,
        "after_discount": afterDiscount,
      };
}

class LineItem {
  LineItem({
    this.id,
    this.customerId,
    this.quantity,
    this.totalRefund,
    this.itemPrice,
    this.bonusProductName,
    this.beforeDiscountPrice,
    this.allowsChooseDistribute,
    this.reviewed,
    this.isBonus,
    this.product,
    this.distributesSelected,
    this.parentCartItemIds,
    this.note
  });

  int? id;
  int? customerId;
  int? quantity;
  int? totalRefund;
  String? bonusProductName;
  double? itemPrice;
  double? beforeDiscountPrice;
  bool? reviewed;
  bool? allowsChooseDistribute;
  bool? isBonus;
  Product? product;
  List<DistributesSelected>? distributesSelected;
  String? parentCartItemIds;
  String? note;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"] == null ? null : json["id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        totalRefund: json["total_refund"] == null ? null : json["total_refund"],
        allowsChooseDistribute: json["allows_choose_distribute"] == null
            ? null
            : json["allows_choose_distribute"],
        bonusProductName: json["bonus_product_name"] == null
            ? null
            : json["bonus_product_name"],
        itemPrice:
            json["item_price"] == null ? null : json["item_price"].toDouble(),
    parentCartItemIds: json["parent_cart_item_ids"],
        beforeDiscountPrice: json["before_discount_price"] == null
            ? null
            : double.tryParse(json["before_discount_price"].toString()) ?? 0,
        reviewed: json["reviewed"] == null ? null : json["reviewed"],
        isBonus: json["is_bonus"] == null ? null : json["is_bonus"],
        product: Product.fromJson(json["product"]),
        distributesSelected: json["distributes_selected"] == null
            ? null
            : List<DistributesSelected>.from(json["distributes_selected"]
                .map((x) => DistributesSelected.fromJson(x))),
        note : json["note"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product!.toJson(),
        "distributes_selected":
            List<dynamic>.from(distributesSelected!.map((x) => x.toJson())),
      };
}

class LineItemsAtTime {
  LineItemsAtTime({
    this.id,
    this.quantity,
    this.name,
    this.totalRefund,
    this.itemPrice,
    this.imageUrl,
    this.beforePrice,
    this.afterDiscount,
    this.distributesSelected,
    this.isBonus,this.note
  });

  int? id;
  int? quantity;
  String? name;
  String? imageUrl;
  int? totalRefund;
  double? itemPrice;
  double? beforePrice;
  double? afterDiscount;
  bool? isBonus;
  List<DistributesSelected>? distributesSelected;
  String? note;

  factory LineItemsAtTime.fromJson(Map<String, dynamic> json) =>
      LineItemsAtTime(
        id: json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        totalRefund: json["total_refund"] == null ? null : json["total_refund"],
        name: json["name"] == null ? null : json["name"],
        isBonus: json["is_bonus"] == null ? null : json["is_bonus"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        beforePrice: json["before_discount_price"] == null
            ? null
            : json["before_discount_price"].toDouble(),
        itemPrice:
            json["item_price"] == null ? null : json["item_price"].toDouble(),
        afterDiscount: json["after_discount"] == null
            ? null
            : json["after_discount"].toDouble(),
        distributesSelected: json["distributes_selected"] == null
            ? null
            : List<DistributesSelected>.from(json["distributes_selected"]
                .map((x) => DistributesSelected.fromJson(x))),
        note: json["note"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "name": name,
        "image_url": imageUrl == null ? null : imageUrl,
        "before_price": beforePrice,
        "after_discount": afterDiscount,
        "distributes_selected":
            List<dynamic>.from(distributesSelected!.map((x) => x.toJson())),
      };
}

class DistributesSelected {
  String? name;
  String? value;
  String? subElement;

  DistributesSelected({
    this.name,
    this.value,
    this.subElement,
  });

  factory DistributesSelected.fromJson(Map<String, dynamic> json) =>
      DistributesSelected(
        name: json["name"],
        value: json["value"],
        subElement: json["sub_element_distributes"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
        "sub_element_distributes": subElement,
      };
}

class Branch {
  Branch({
    this.id,
    this.storeId,
    this.name,
    this.addressDetail,
    this.province,
    this.district,
    this.wards,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.branchCode,
    this.postcode,
    this.email,
    this.phone,
    this.isDefault,
    this.isDefaultOrderOnline,
    this.createdAt,
    this.updatedAt,
  });

  int? id;

  int? storeId;

  String? name;

  String? addressDetail;

  int? province;

  int? district;

  int? wards;

  String? provinceName;

  String? districtName;

  String? wardsName;

  String? branchCode;

  String? postcode;

  String? email;

  String? phone;

  bool? isDefault;

  DateTime? createdAt;

  DateTime? updatedAt;

  bool? isDefaultOrderOnline;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        name: json["name"] == null ? null : json["name"],
        addressDetail:
            json["address_detail"] == null ? null : json["address_detail"],
        province: json["province"] == null ? null : json["province"],
        district: json["district"] == null ? null : json["district"],
        wards: json["wards"] == null ? null : json["wards"],
        provinceName:
            json["province_name"] == null ? null : json["province_name"],
        districtName:
            json["district_name"] == null ? null : json["district_name"],
        wardsName: json["wards_name"] == null ? null : json["wards_name"],
        branchCode: json["branch_code"] == null ? null : json["branch_code"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        isDefaultOrderOnline: json["is_default_order_online"] == null
            ? null
            : json["is_default_order_online"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "name": name == null ? null : name,
        "address_detail": addressDetail == null ? null : addressDetail,
        "province": province == null ? null : province,
        "district": district == null ? null : district,
        "wards": wards == null ? null : wards,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "wards_name": wardsName == null ? null : wardsName,
        "branch_code": branchCode == null ? null : branchCode,
        "postcode": postcode == null ? null : postcode,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "is_default": isDefault == null ? null : isDefault,
        "is_default_order_online":
            isDefaultOrderOnline == null ? null : isDefaultOrderOnline,
      };
}
