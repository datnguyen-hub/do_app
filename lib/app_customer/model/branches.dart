
class Branches {
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
    bool? isDefaultOrderOnline;
    String? txtCode;
    String? accountNumber;
    String? accountName;
    String? bank;
    DateTime? createdAt;
    DateTime? updatedAt;

    Branches({
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
        this.txtCode,
        this.accountNumber,
        this.accountName,
        this.bank,
        this.createdAt,
        this.updatedAt,
    });

    factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        id: json["id"],
        storeId: json["store_id"],
        name: json["name"],
        addressDetail: json["address_detail"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
        branchCode: json["branch_code"],
        postcode: json["postcode"],
        email: json["email"],
        phone: json["phone"],
        isDefault: json["is_default"],
        isDefaultOrderOnline: json["is_default_order_online"],
        txtCode: json["txt_code"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bank: json["bank"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "name": name,
        "address_detail": addressDetail,
        "province": province,
        "district": district,
        "wards": wards,
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
        "branch_code": branchCode,
        "postcode": postcode,
        "email": email,
        "phone": phone,
        "is_default": isDefault,
        "is_default_order_online": isDefaultOrderOnline,
        "txt_code": txtCode,
        "account_number": accountNumber,
        "account_name": accountName,
        "bank": bank,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}