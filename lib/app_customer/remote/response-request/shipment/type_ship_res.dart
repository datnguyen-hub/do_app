

import 'package:sahashop_customer/app_customer/model/tyoe_ship.dart';

class TypeShipRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    TypeShip? data;

    TypeShipRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory TypeShipRes.fromJson(Map<String, dynamic> json) => TypeShipRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : TypeShip.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}


