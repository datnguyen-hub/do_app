
import 'package:sahashop_customer/app_customer/model/shipment_method.dart';



class ShipmentCustomerResponse {
  ShipmentCustomerResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  Data? data;
  String? msgCode;
  String? msg;

  factory ShipmentCustomerResponse.fromJson(Map<String, dynamic> json) =>
      ShipmentCustomerResponse(
        code: json["code"],
        success: json["success"],
        data:json["data"] == null ? null : Data.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data!.toJson(),
        "msg_code": msgCode,
        "msg": msg,
      };
}

class Data {
  Data({
    this.info,
    this.data,
  });

  dynamic info;
  List<ShipmentMethod>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        info: json["info"],
        data:json["data"] == null ? [] : List<ShipmentMethod>.from(
            json["data"].map((x) => ShipmentMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
