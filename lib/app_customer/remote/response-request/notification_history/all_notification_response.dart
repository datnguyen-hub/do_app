
class AllNotificationCusResponse {
  AllNotificationCusResponse({
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

  factory AllNotificationCusResponse.fromJson(Map<String, dynamic> json) =>
      AllNotificationCusResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.totalUnread,
    this.listNotification,
  });

  int? totalUnread;
  ListNotificationCus? listNotification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalUnread: json["total_unread"] == null ? null : json["total_unread"],
    listNotification: json["list_notification"] == null || json["list_notification"] == []
            ? null
            : ListNotificationCus.fromJson(json["list_notification"]),
      );
}

class ListNotificationCus {
  ListNotificationCus({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<NotificationCus>? data;
  String? nextPageUrl;

  factory ListNotificationCus.fromJson(Map<String, dynamic> json) =>
      ListNotificationCus(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<NotificationCus>.from(json["data"].map((x) => NotificationCus.fromJson(x))),

        nextPageUrl: json["next_page_url"],
      );
}

class NotificationCus {
  NotificationCus({
    this.id,
    this.customerId,
    this.storeId,
    this.content,
    this.title,
    this.type,
    this.unread,
    this.referencesValue,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? customerId;
  int? storeId;
  String? content;
  String? title;
  String? type;
  String? referencesValue;
  bool? unread;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationCus.fromJson(Map<String, dynamic> json) => NotificationCus(
        id: json["id"] == null ? null : json["id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        content: json["content"] == null ? null : json["content"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        unread: json["unread"] == null ? null : json["unread"],
        referencesValue: json["references_value"] == null ? null : json["references_value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
