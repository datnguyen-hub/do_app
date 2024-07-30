import 'package:sahashop_customer/app_customer/model/agency_type.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class Agency {
  Agency({
    this.id,
    this.storeId,
    this.customerId,
    this.agencyTypeId,
    this.paymentAuto,
    this.balance,
    this.firstAndLastName,
    this.cmnd,
    this.dateRange,
    this.issuedBy,
    this.frontCard,
    this.backCard,
    this.status,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.ordersCount,
    this.sumTotalFinal,
    this.branch,
    this.sumPoint,
    this.createdAt,
    this.updatedAt,
    this.agencyType,
    this.customer,
    this.pointsCount,
    this.sumShareAgency,this.latitude,this.longitude
  });

  int? id;
  int? storeId;
  int? customerId;
  int? agencyTypeId;
  bool? paymentAuto;
  double? balance;
  int? pointsCount;
  String? sumPoint;
  String? firstAndLastName;
  String? cmnd;
  DateTime? dateRange;
  String? issuedBy;
  String? frontCard;
  String? backCard;
  int? status;
  int? ordersCount;
  int? sumTotalFinal;
  double? sumShareAgency;
  String? bank;
  String? accountNumber;
  String? accountName;
  String? branch;
  DateTime? createdAt;
  DateTime? updatedAt;
  AgencyType? agencyType;
  InfoCustomer? customer;
  double? latitude;
  double? longitude;
  

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        agencyTypeId: json["agency_type_id"],
        paymentAuto: json["payment_auto"] == null ? null : json["payment_auto"],
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        firstAndLastName: json["first_and_last_name"],
        sumShareAgency: json["sum_share_agency"] == null
            ? null
            : json["sum_share_agency"].toDouble(),
        cmnd: json["cmnd"],
        sumPoint: json["sum_point"],
        dateRange: json["date_range"] == null
            ? null
            : DateTime.parse(json["date_range"]),
        issuedBy: json["issued_by"],
        frontCard: json["front_card"],
        pointsCount: json["points_count"],
        backCard: json["back_card"],
        status: json["status"],
        bank: json["bank"],
        ordersCount: json["orders_count"],
        sumTotalFinal: json["sum_total_final"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        branch: json["branch"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        agencyType: json["agency_type"] == null
            ? null
            : AgencyType.fromJson(json["agency_type"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
        latitude: json["latitude"],
        longitude: json["longitude"]
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "customer_id": customerId == null ? null : customerId,
        "agency_type_id": agencyTypeId,
        "payment_auto": paymentAuto == null ? null : paymentAuto,
        "balance": balance == null ? null : balance,
        "first_and_last_name": firstAndLastName,
        "sum_point": sumPoint,
        "cmnd": cmnd,
        "date_range": dateRange,
        "issued_by": issuedBy,
        "front_card": frontCard,
        "back_card": backCard,
        "status": status,
        "bank": bank,
        "account_number": accountNumber,
        "account_name": accountName,
        "branch": branch,
        "customer": customer == null ? null : customer!.toJson(),
        "longitude":longitude,
        "latitude":latitude
      };
}