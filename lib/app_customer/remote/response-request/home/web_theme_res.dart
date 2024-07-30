class WebThemeRes {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
   WebTheme? data;

  WebThemeRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  factory WebThemeRes.fromJson(Map<String, dynamic> json) => WebThemeRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null :  WebTheme.fromJson(json["data"]),
      );
}

class  WebTheme {
  bool? isShowProductSold;
  bool? isShowProductView;

   WebTheme({
    this.isShowProductSold,
    this.isShowProductView,
  });

  factory  WebTheme.fromJson(Map<String, dynamic> json) =>  WebTheme(
        isShowProductSold: json["is_show_product_sold"],
        isShowProductView: json["is_show_product_view"],
      );
}
