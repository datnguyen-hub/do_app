import '../../../model/info_customer.dart';

class AllPersonChatRes {
  AllPersonChatRes({
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

  factory AllPersonChatRes.fromJson(Map<String, dynamic> json) => AllPersonChatRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<PersonChat>? data;

  String? nextPageUrl;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<PersonChat>.from(json["data"].map((x) => PersonChat.fromJson(x))),
    nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
  );

}

class PersonChat {
  PersonChat({
    this.id,
    this.storeId,
    this.customerId,
    this.toCustomerId,
    this.lastMess,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.toCustomer,
  });

  int? id;
  int? storeId;
  int? customerId;
  int ?toCustomerId;
  String? lastMess;
  bool? seen;
  DateTime? createdAt;
  DateTime? updatedAt;
  InfoCustomer? toCustomer;

  factory PersonChat.fromJson(Map<String, dynamic> json) => PersonChat(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    toCustomerId: json["to_customer_id"] == null ? null : json["to_customer_id"],
    lastMess: json["last_mess"] == null ? null : json["last_mess"],
    seen: json["seen"] == null ? null : json["seen"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    toCustomer: json["to_customer"] == null ? null : InfoCustomer.fromJson(json["to_customer"]),
  );
}
