import 'step_bonus.dart';

class GeneralInfoPaymentCtv {
  GeneralInfoPaymentCtv({
    this.balance,
    this.shareCollaborator,
    this.totalFinal = 0,
    this.typeRose,
    this.numberOrder,
    this.allowPaymentRequest,
    this.receivedMonthBonus,
    this.payment1OfMonth,
    this.payment16OfMonth,
    this.paymentLimit,
    this.hasPaymentRequest,
    this.moneyPaymentRequest,
    this.stepsBonus,
  });

  double? balance;
  double? shareCollaborator;
  double? totalFinal = 0;
  int? typeRose;
  int? numberOrder;
  bool? allowPaymentRequest;
  bool? receivedMonthBonus;
  bool? payment1OfMonth;
  bool? payment16OfMonth;
  double? paymentLimit;
  bool? hasPaymentRequest;
  double? moneyPaymentRequest;
  List<StepsBonus>? stepsBonus;

  factory GeneralInfoPaymentCtv.fromJson(Map<String, dynamic> json) =>
      GeneralInfoPaymentCtv(
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        totalFinal: json["total_final"] == null ? 0 : json["total_final"].toDouble(),
        shareCollaborator: json["share_collaborator"] == null
            ? null
            : json["share_collaborator"].toDouble(),
        typeRose: json["type_rose"] == null ? null : json["type_rose"],
        numberOrder: json["number_order"] == null ? null : json["number_order"],
        receivedMonthBonus: json["received_month_bonus"] == null
            ? null
            : json["received_month_bonus"],
        allowPaymentRequest: json["allow_payment_request"] == null
            ? null
            : json["allow_payment_request"],
        payment1OfMonth: json["payment_1_of_month"] == null
            ? null
            : json["payment_1_of_month"],
        payment16OfMonth: json["payment_16_of_month"] == null
            ? null
            : json["payment_16_of_month"],
        paymentLimit: json["payment_limit"] == null
            ? null
            : json["payment_limit"].toDouble(),
        hasPaymentRequest: json["has_payment_request"] == null
            ? null
            : json["has_payment_request"],
        moneyPaymentRequest: json["money_payment_request"] == null
            ? null
            : json["money_payment_request"].toDouble(),
        stepsBonus: json["steps_bonus"] == null
            ? null
            : List<StepsBonus>.from(
                json["steps_bonus"].map((x) => StepsBonus.fromJson(x))),
      );
}
