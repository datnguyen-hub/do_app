import 'step_bonus.dart';

class GeneralInfoPaymentAgency {
  GeneralInfoPaymentAgency({
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
    this.stepsBonusImport,
    this.totalFinalCtv,
    this.numberOrderCtv,
    this.totalOrder,
    this.countInDay,
    this.totalFinalInDay,
    this.countInMonth,
    this.totalFinalInMonth,
    this.countInYear,
    this.totalFinalInYear,
    this.countInQuarter,
    this.totalFinalInQuarter,
    this.totalFinalInWeek,
    this.countInWeek,
    this.typeBonusPeriodImport,
    this.totalAfterDiscountNoUseBonusWithDate,
    this.totalAfterDiscountNoBonus,
    this.totalAfterDiscountNoBonusInDay,
    this.totalAfterDiscountNoBonusInMonth,
    this.totalAfterDiscountNoBonusInQuarter,
    this.totalAfterDiscountNoBonusInWeek,
    this.totalAfterDiscountNoBonusInYear,
  });

  int? totalOrder;
  int? countInDay;
  double? totalFinalInDay;

  double? totalAfterDiscountNoBonus;
  int? countInMonth;
  double? totalFinalInMonth;
  double? totalAfterDiscountNoBonusInDay;
  double? totalAfterDiscountNoBonusInMonth;
  double? totalAfterDiscountNoBonusInQuarter;
  double? totalAfterDiscountNoBonusInWeek;
  double? totalAfterDiscountNoBonusInYear;
  int? countInYear;
  double? totalFinalInWeek;
  int? countInWeek;
  double? totalFinalInYear;
  int? countInQuarter;
  int? typeBonusPeriodImport;
  double? totalFinalInQuarter;
  double? balance;
  double? shareCollaborator;
  double? totalFinal = 0;
  double? totalAfterDiscountNoUseBonusWithDate = 0;
  double? totalFinalCtv = 0;
  int? typeRose;
  int? numberOrder;
  int? numberOrderCtv;
  bool? allowPaymentRequest;
  bool? receivedMonthBonus;
  bool? payment1OfMonth;
  bool? payment16OfMonth;
  double? paymentLimit;
  bool? hasPaymentRequest;
  double? moneyPaymentRequest;
  List<StepsBonus>? stepsBonus;
  List<StepsBonus>? stepsBonusImport;

  factory GeneralInfoPaymentAgency.fromJson(Map<String, dynamic> json) =>
      GeneralInfoPaymentAgency(
        countInDay: json["count_in_day"],
        typeBonusPeriodImport: json["type_bonus_period_import"],
        totalFinalInDay: json["total_final_in_day"] == null
            ? null
            : json["total_final_in_day"].toDouble(),
        countInWeek: json["count_in_week"],
        totalFinalInWeek: json["total_final_in_week"] == null
            ? null
            : json["total_final_in_week"].toDouble(),
        countInMonth: json["count_in_month"],
        totalAfterDiscountNoBonus: json["total_after_discount_no_bonus"] == null
            ? null
            : json["total_after_discount_no_bonus"].toDouble(),
        totalAfterDiscountNoBonusInYear:
            json["total_after_discount_no_bonus_in_year"] == null
                ? null
                : json["total_after_discount_no_bonus_in_year"].toDouble(),
        totalAfterDiscountNoBonusInWeek:
            json["total_after_discount_no_bonus_in_week"] == null
                ? null
                : json["total_after_discount_no_bonus_in_week"].toDouble(),
        totalAfterDiscountNoBonusInQuarter:
            json["total_after_discount_no_bonus_in_quarter"] == null
                ? null
                : json["total_after_discount_no_bonus_in_quarter"].toDouble(),
        totalAfterDiscountNoBonusInMonth:
            json["total_after_discount_no_bonus_in_month"] == null
                ? null
                : json["total_after_discount_no_bonus_in_month"].toDouble(),
        totalAfterDiscountNoBonusInDay:
            json["total_after_discount_no_bonus_in_day"] == null
                ? null
                : json["total_after_discount_no_bonus_in_day"].toDouble(),
        totalAfterDiscountNoUseBonusWithDate:
            json["total_after_discount_no_use_bonus_with_date"] == null
                ? null
                : json["total_after_discount_no_use_bonus_with_date"]
                    .toDouble(),
        totalFinalInMonth: json["total_final_in_month"] == null
            ? null
            : json["total_final_in_month"].toDouble(),
        countInYear: json["count_in_year"],
        totalFinalInYear: json["total_final_in_year"] == null
            ? null
            : json["total_final_in_year"].toDouble(),
        countInQuarter: json["count_in_quarter"],
        totalFinalInQuarter: json["total_final_in_quarter"] == null
            ? null
            : json["total_final_in_quarter"].toDouble(),
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        totalFinal:
            json["total_final"] == null ? 0 : json["total_final"].toDouble(),
        totalFinalCtv: json["total_final_ctv"] == null
            ? 0
            : json["total_final_ctv"].toDouble(),
        numberOrderCtv:
            json["number_order_ctv"] == null ? 0 : json["number_order_ctv"],
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
        stepsBonusImport: json["steps_import"] == null
            ? null
            : List<StepsBonus>.from(
                json["steps_import"].map((x) => StepsBonus.fromJson(x))),
      );
}
