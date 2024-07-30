
class InfoPaymentRequest {
  InfoPaymentRequest({
    this.paymentAuto,
    this.firstAndLastName,
    this.cmnd,
    this.dateRange,
    this.issuedBy,
    this.frontCard,
    this.backCard,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.branch,
  });

  bool? paymentAuto;
  String? firstAndLastName;
  String? cmnd;
  DateTime? dateRange;
  String? issuedBy;
  String? frontCard;
  String? backCard;
  String? bank;
  String? accountNumber;
  String? accountName;
  String? branch;

  Map<String, dynamic> toJson() => {
    "payment_auto": paymentAuto == null ? null : paymentAuto,
    "first_and_last_name": firstAndLastName == null ? null : firstAndLastName,
    "cmnd": cmnd == null ? null : cmnd,
    "date_range": dateRange == null ? null : dateRange!.toIso8601String(),
    "issued_by": issuedBy == null ? null : issuedBy,
    "front_card": frontCard == null ? null : frontCard,
    "back_card": backCard == null ? null : backCard,
    "bank": bank == null ? null : bank,
    "account_number": accountNumber == null ? null : accountNumber,
    "account_name": accountName == null ? null : accountName,
    "branch": branch == null ? null : branch,
  };
}
