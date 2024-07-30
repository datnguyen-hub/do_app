
import 'package:sahashop_customer/app_customer/model/reward_point_ctm.dart';

class RewardPointsCtmResponse {
  RewardPointsCtmResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.rewardPoint,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  RewardPointCtm? rewardPoint;

  factory RewardPointsCtmResponse.fromJson(Map<String, dynamic> json) => RewardPointsCtmResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    rewardPoint: json["data"] == null ? null : RewardPointCtm.fromJson(json["data"]),
  );

}
