import '../../../model/home_data.dart';

class PopupRes {
  PopupRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  factory PopupRes.fromJson(Map<String, dynamic> json) => PopupRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.popups,
  });

  List<Popup>? popups;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        popups: json["popups"] == null
            ? null
            : List<Popup>.from(json["popups"].map((x) => Popup.fromJson(x))),
      );
}
