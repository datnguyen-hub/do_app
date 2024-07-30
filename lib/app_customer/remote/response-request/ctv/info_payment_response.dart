
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class InfoPaymentResponse {
  InfoPaymentResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  factory InfoPaymentResponse.fromJson(Map<String, dynamic> json) => InfoPaymentResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.id,
    this.storeId,
    this.customerId,
    this.paymentAuto,
    this.balance,
    this.firstAndLastName,
    this.cmnd,
    this.dateRange,
    this.issuedBy,
    this.frontCard,
    this.backCard,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.branch,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  int? id;
  int? storeId;
  int? customerId;
  bool? paymentAuto;
  double? balance;
  String? firstAndLastName;
  String? cmnd;
  DateTime? dateRange;
  String? issuedBy;
  String? frontCard;
  String? backCard;
  String? bank;
  String? accountNumber;
  String? accountName;
  String? branch;
  DateTime? createdAt;
  DateTime? updatedAt;
  InfoCustomer? customer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    paymentAuto: json["payment_auto"] == null ? null : json["payment_auto"],
    balance: json["balance"] == null ? null : json["balance"].toDouble(),
    firstAndLastName: json["first_and_last_name"] == null ? null : json["first_and_last_name"],
    cmnd: json["cmnd"] == null ? null : json["cmnd"],
    dateRange: json["date_range"] == null ? null : DateTime.parse(json["date_range"]),
    issuedBy: json["issued_by"] == null ? null : json["issued_by"],
    frontCard: json["front_card"] == null ? null : json["front_card"],
    backCard: json["back_card"] == null ? null : json["back_card"],
    bank: json["bank"] == null ? null : json["bank"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    accountName: json["account_name"] == null ? null : json["account_name"],
    branch: json["branch"] == null ? null : json["branch"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    customer: json["customer"] == null ? null : InfoCustomer.fromJson(json["customer"]),
  );

}
