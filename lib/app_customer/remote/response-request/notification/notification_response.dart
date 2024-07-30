class NotificationResponse {
  int? code;
  bool? success;
  NotificationCTM? data;
  String? msgCode;
  String? msg;

  NotificationResponse(
      {this.code, this.success, this.data, this.msgCode, this.msg});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null
        ? new NotificationCTM.fromJson(json['data'])
        : null;
    msgCode = json['msg_code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    return data;
  }
}

class NotificationCTM {
  int? id;
  int? customerId;
  int? storeId;
  String? content;
  String? title;
  String? type;
  String? createdAt;
  String? updatedAt;

  NotificationCTM(
      {this.id,
      this.customerId,
      this.storeId,
      this.content,
      this.title,
      this.type,
      this.createdAt,
      this.updatedAt});

  NotificationCTM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    storeId = json['store_id'];
    content = json['content'];
    title = json['title'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['store_id'] = this.storeId;
    data['content'] = this.content;
    data['title'] = this.title;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
