

import 'package:sahashop_customer/app_customer/model/branches.dart';

class AllBranchesRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    List<Branches>? data;

    AllBranchesRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllBranchesRes.fromJson(Map<String, dynamic> json) => AllBranchesRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Branches>.from(json["data"]!.map((x) => Branches.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

