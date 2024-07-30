import 'package:sahashop_customer/app_customer/model/home_data.dart';

class HomeResponse {
  HomeResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  HomeData? data;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: HomeData.fromJson(json["data"]),
  );

}

