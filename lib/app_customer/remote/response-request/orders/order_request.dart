class OrderRequest {
  OrderRequest({
    this.paymentMethodId,
    this.partnerShipperId,
    this.shipperType,
    this.totalShippingFee,
    this.customerAddressId,
    this.customerNote,
    this.collaboratorId,
    this.codeVoucher,
    this.paymentPartnerId,
    this.agencyByCustomerId,
    this.isUsedPiont,
    this.isUseBalanceCollaborator,
    this.isUseBalanceAgency,
    this.name,
    this.phone,
    this.addressDetail,
    this.province,
    this.district,
    this.wards,
    this.orderFrom,this.isOrderForCustomer,this.branchId
  });

  int? paymentMethodId;
  int? partnerShipperId;
  int? paymentPartnerId;
  int? shipperType;
  double? totalShippingFee;
  int? customerAddressId;
  String? name;
  String? phone;
  String? customerNote;
  int? collaboratorId;
  int? agencyByCustomerId;
  String? codeVoucher;
  bool? isUsedPiont;
  bool? isUseBalanceCollaborator;
  bool? isUseBalanceAgency;
  String? addressDetail;
  int? province;
  int? district;
  int? wards;
  int? orderFrom;
  bool? isOrderForCustomer;
  int? branchId;

  Map<String, dynamic> toJson() => {
        "payment_method_id": paymentMethodId,
        "partner_shipper_id": partnerShipperId,
        "shipper_type": shipperType,
        "total_shipping_fee": totalShippingFee,
        "customer_address_id": customerAddressId,
        "customer_note": customerNote,
        "payment_partner_id": paymentPartnerId,
        "collaborator_by_customer_id": collaboratorId,
        "agency_by_customer_id": agencyByCustomerId,
        "code_voucher": codeVoucher,
        "is_use_points": isUsedPiont,
        "is_use_balance_collaborator": isUseBalanceCollaborator,
        "is_use_balance_agency": isUseBalanceAgency,
        "phone": phone,
        "name": name,
        "address_detail": addressDetail,
        "province": province,
        "district": district,
        "wards": wards,
        "order_from": orderFrom,
        "is_order_for_customer":isOrderForCustomer,
        "branch_id":branchId
      };
}
