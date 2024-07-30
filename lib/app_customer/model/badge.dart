class BadgeModel {
  BadgeModel(
      {this.ordersWaitingForProgressing = 0,
      this.ordersPacking = 0,
      this.ordersShipping = 0,
      this.ordersNoReviews = 0,
      this.chatsUnread = 0,
      this.postsUnread = 0,
      this.cartQuantity = 0,
      this.favoriteProducts = 0,
      this.statusCollaborator = 0,
      this.statusAgency = 0,
      this.customerPoint = 0,
      this.voucherTotal = 0,
      this.domain,
      this.linkAppple,
      this.storeName,
      this.linkCh,
      this.productsDiscount = 0,
      this.totalBoughtAmount = 0,
      this.notificationUnread,
      this.allowUsePointOrder = false,
      this.allowSemiNegative,
      this.hasTrain,
      this.hasCommunity,
      this.versionIos,
      this.versionAndroid,
      this.dynamicLinks,
      this.collaboratorRegisterRequest,
      this.agencyRegisterRequest,
      this.allowBranchPaymentOrder,
      this.autoChooseDefaultBranchPaymentOrder});

  int? ordersWaitingForProgressing;
  int? ordersPacking;
  int? ordersShipping;
  int? postsUnread;
  int? ordersNoReviews;
  int? chatsUnread;
  int? cartQuantity;
  int? favoriteProducts;
  int? statusCollaborator;
  int? statusAgency;
  double? customerPoint;
  String? domain;
  String? storeName;
  String? linkAppple;
  String? linkCh;
  String? versionIos;
  String? versionAndroid;
  int? voucherTotal;
  int? productsDiscount;
  int? notificationUnread;
  double? totalBoughtAmount;
  bool? allowUsePointOrder;
  bool? allowSemiNegative;
  bool? hasTrain;
  bool? hasCommunity;
  DynamicLinks? dynamicLinks;
  CollaboratorRegisterRequest? collaboratorRegisterRequest;
  AgencyRegisterRequest? agencyRegisterRequest;
  bool? allowBranchPaymentOrder;
  bool? autoChooseDefaultBranchPaymentOrder;

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
      ordersWaitingForProgressing:
          json["orders_waitting_for_progressing"] == null
              ? null
              : json["orders_waitting_for_progressing"],
      ordersPacking:
          json["orders_packing"] == null ? null : json["orders_packing"],
      ordersShipping:
          json["orders_shipping"] == null ? null : json["orders_shipping"],
      ordersNoReviews:
          json["orders_no_reviews"] == null ? null : json["orders_no_reviews"],
      chatsUnread: json["chats_unread"] == null ? null : json["chats_unread"],
      hasTrain: json["has_train"] == null ? null : json["has_train"],
      hasCommunity:
          json["has_community"] == null ? null : json["has_community"],
      postsUnread: json["posts_unread"] == null ? null : json["posts_unread"],
      domain: json["domain"] == null ? null : json["domain"],
      linkCh:
          json["link_google_play"] == null ? null : json["link_google_play"],
      storeName: json["store_name"] == null ? null : json["store_name"],
      versionIos: json["version_ios"] == null ? null : json["version_ios"],
      versionAndroid:
          json["version_android"] == null ? null : json["version_android"],
      linkAppple:
          json["link_apple_store"] == null ? null : json["link_apple_store"],
      cartQuantity:
          json["cart_quantity"] == null ? null : json["cart_quantity"],
      favoriteProducts:
          json["favorite_products"] == null ? null : json["favorite_products"],
      statusCollaborator: json["status_collaborator"] == null
          ? null
          : json["status_collaborator"],
      statusAgency:
          json["status_agency"] == null ? null : json["status_agency"],
      customerPoint: json["customer_point"] == null
          ? null
          : json["customer_point"].toDouble(),
      voucherTotal:
          json["voucher_total"] == null ? null : json["voucher_total"],
      productsDiscount:
          json["products_discount"] == null ? null : json["products_discount"],
      totalBoughtAmount: json["total_bought_amount"] == null
          ? null
          : json["total_bought_amount"].toDouble(),
      allowUsePointOrder: json["allow_use_point_order"] == null
          ? null
          : json["allow_use_point_order"],
      notificationUnread: json["notification_unread"] == null
          ? null
          : json["notification_unread"],
      allowSemiNegative: json["allow_semi_negative"] == null
          ? null
          : json["allow_semi_negative"],
      dynamicLinks: json['dynamic_links'] == null
          ? null
          : DynamicLinks.fromJson(json['dynamic_links']),
      collaboratorRegisterRequest: json['collaborator_register_request'] == null
          ? null
          : CollaboratorRegisterRequest.fromJson(
              json['collaborator_register_request']),
      agencyRegisterRequest: json["agency_register_request"] == null
          ? null
          : AgencyRegisterRequest.fromJson(json["agency_register_request"]),
      allowBranchPaymentOrder: json["allow_branch_payment_order"],
      autoChooseDefaultBranchPaymentOrder: json["auto_choose_default_branch_payment_order"]
          );
}

class DynamicLinks {
  DynamicLinks({
    this.productRef,
    this.phoneRef,
    this.postRef,
  });

  DynamicRef? productRef;
  DynamicRef? phoneRef;
  DynamicRef? postRef;

  factory DynamicLinks.fromJson(Map<String, dynamic> json) => DynamicLinks(
        productRef: json["product_ref"] == null
            ? null
            : DynamicRef.fromJson(json["product_ref"]),
        phoneRef: json["phone_ref"] == null
            ? null
            : DynamicRef.fromJson(json["phone_ref"]),
        postRef: json["post_ref"] == null
            ? null
            : DynamicRef.fromJson(json["post_ref"]),
      );
}

class DynamicRef {
  DynamicRef(
      {this.id,
      this.action,
      this.phone,
      this.referencesId,
      this.handled,
      this.collaboratorByCustomerId});
  int? id;
  String? action;
  String? phone;
  String? referencesId;
  bool? handled;
  int? collaboratorByCustomerId;

  factory DynamicRef.fromJson(Map<String, dynamic> json) => DynamicRef(
      id: json['id'],
      action: json['action'],
      phone: json['phone'],
      referencesId: json['references_id'],
      handled: json['handled'],
      collaboratorByCustomerId: json['collaborator_by_customer_id']);
}

class CollaboratorRegisterRequest {
  CollaboratorRegisterRequest({this.hasRequest, this.note, this.status});
  bool? hasRequest;
  String? note;
  int? status;

  factory CollaboratorRegisterRequest.fromJson(Map<String, dynamic> json) =>
      CollaboratorRegisterRequest(
          hasRequest: json['has_request'],
          note: json['note'],
          status: json['status']);
}

class AgencyRegisterRequest {
  AgencyRegisterRequest({this.hasRequest, this.note, this.status});
  bool? hasRequest;
  String? note;
  int? status;

  factory AgencyRegisterRequest.fromJson(Map<String, dynamic> json) =>
      AgencyRegisterRequest(
          hasRequest: json['has_request'],
          note: json['note'],
          status: json['status']);
}
