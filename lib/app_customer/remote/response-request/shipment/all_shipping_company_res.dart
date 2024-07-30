
import 'package:sahashop_customer/app_customer/model/shipping_company.dart';

class AllShippingCompanyRes {
    int? code;
    bool? success;
    List<ShippingCompany>? data;
    String? msgCode;
    String? msg;

    AllShippingCompanyRes({
        this.code,
        this.success,
        this.data,
        this.msgCode,
        this.msg,
    });

    factory AllShippingCompanyRes.fromJson(Map<String, dynamic> json) => AllShippingCompanyRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? [] : List<ShippingCompany>.from(json["data"]!.map((x) => ShippingCompany.fromJson(x))),
        msgCode: json["msg_code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg_code": msgCode,
        "msg": msg,
    };
}


