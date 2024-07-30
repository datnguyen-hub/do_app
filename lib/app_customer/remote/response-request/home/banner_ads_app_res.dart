import '../../../model/home_data.dart';

class BannerAdsAppRes {
  BannerAdsAppRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.bannerAdsApp,

  });

  int? code;
  bool ?success;
  String? msgCode;
  String? msg;
  BannerAdsApp? bannerAdsApp;


  factory BannerAdsAppRes.fromJson(Map<String, dynamic> json) => BannerAdsAppRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    bannerAdsApp: json["data"] == null ? null : BannerAdsApp.fromJson(json["data"]),

  );
}
