import '../../../model/info_customer.dart';

class AllReferralAgencyRes {
  int? code;
  bool? success;
  Data? data;
  String? msgCode;
  String? msg;

  AllReferralAgencyRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  factory AllReferralAgencyRes.fromJson(Map<String, dynamic> json) =>
      AllReferralAgencyRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

}

class Data {
  int? currentPage;
  List<InfoCustomer>? data;
  String? nextPageUrl;

  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<InfoCustomer>.from(json["data"]!.map((x) => InfoCustomer.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

}

class Datum {
  int? id;
  dynamic username;
  String? areaCode;
  String? phoneNumber;
  bool? official;
  dynamic phoneVerifiedAt;
  dynamic email;
  dynamic emailVerifiedAt;
  String? name;
  String? nameStrFilter;
  String? referralPhoneNumber;
  DateTime? dateOfBirth;
  String? avatarImage;
  int? points;
  int? sex;
  bool? isCollaborator;
  bool? isPassersby;
  bool? isAgency;
  bool? isSale;
  bool? isFromJson;
  int? debt;
  dynamic province;
  dynamic district;
  dynamic wards;
  dynamic addressDetail;
  dynamic countryName;
  dynamic provinceName;
  dynamic districtName;
  dynamic wardsName;
  dynamic saleStaffId;
  int? notificationsCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalFinal;
  int? countOrders;
  int? totalShareAgency;
  int? totalReferrals;
  int? totalFinalWithoutRefund;
  int? totalFinalAllStatus;
  int? totalAfterDiscountNoBonus;

  Datum({
    this.id,
    this.username,
    this.areaCode,
    this.phoneNumber,
    this.official,
    this.phoneVerifiedAt,
    this.email,
    this.emailVerifiedAt,
    this.name,
    this.nameStrFilter,
    this.referralPhoneNumber,
    this.dateOfBirth,
    this.avatarImage,
    this.points,
    this.sex,
    this.isCollaborator,
    this.isPassersby,
    this.isAgency,
    this.isSale,
    this.isFromJson,
    this.debt,
    this.province,
    this.district,
    this.wards,
    this.addressDetail,
    this.countryName,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.saleStaffId,
    this.notificationsCount,
    this.createdAt,
    this.updatedAt,
    this.totalFinal,
    this.countOrders,
    this.totalShareAgency,
    this.totalReferrals,
    this.totalFinalWithoutRefund,
    this.totalFinalAllStatus,
    this.totalAfterDiscountNoBonus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        username: json["username"],
        areaCode: json["area_code"],
        phoneNumber: json["phone_number"],
        official: json["official"],
        phoneVerifiedAt: json["phone_verified_at"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        name: json["name"],
        nameStrFilter: json["name_str_filter"],
        referralPhoneNumber: json["referral_phone_number"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        avatarImage: json["avatar_image"],
        points: json["points"],
        sex: json["sex"],
        isCollaborator: json["is_collaborator"],
        isPassersby: json["is_passersby"],
        isAgency: json["is_agency"],
        isSale: json["is_sale"],
        isFromJson: json["is_from_json"],
        debt: json["debt"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail: json["address_detail"],
        countryName: json["country_name"],
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
        saleStaffId: json["sale_staff_id"],
        notificationsCount: json["notifications_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalFinal: json["total_final"],
        countOrders: json["count_orders"],
        totalShareAgency: json["total_share_agency"],
        totalReferrals: json["total_referrals"],
        totalFinalWithoutRefund: json["total_final_without_refund"],
        totalFinalAllStatus: json["total_final_all_status"],
        totalAfterDiscountNoBonus: json["total_after_discount_no_bonus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "area_code": areaCode,
        "phone_number": phoneNumber,
        "official": official,
        "phone_verified_at": phoneVerifiedAt,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "name": name,
        "name_str_filter": nameStrFilter,
        "referral_phone_number": referralPhoneNumber,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "avatar_image": avatarImage,
        "points": points,
        "sex": sex,
        "is_collaborator": isCollaborator,
        "is_passersby": isPassersby,
        "is_agency": isAgency,
        "is_sale": isSale,
        "is_from_json": isFromJson,
        "debt": debt,
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "country_name": countryName,
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
        "sale_staff_id": saleStaffId,
        "notifications_count": notificationsCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_final": totalFinal,
        "count_orders": countOrders,
        "total_share_agency": totalShareAgency,
        "total_referrals": totalReferrals,
        "total_final_without_refund": totalFinalWithoutRefund,
        "total_final_all_status": totalFinalAllStatus,
        "total_after_discount_no_bonus": totalAfterDiscountNoBonus,
      };
}