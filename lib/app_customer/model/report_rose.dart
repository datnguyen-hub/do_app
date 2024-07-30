class ReportRose {
  ReportRose({
    this.year,
    this.month,
    this.totalFinal,
    this.shareCollaborator,
    this.shareAgency,
    this.awarded,
    this.moneyBonusRewarded,
    this.moneyBonusCurrent,
  });

  int? year;
  int? month;
  double? totalFinal;
  double? shareCollaborator;
  double? shareAgency;
  bool? awarded;
  double? moneyBonusRewarded;
  double? moneyBonusCurrent;

  factory ReportRose.fromJson(Map<String, dynamic> json) => ReportRose(
    year: json["year"] == null ? null : json["year"],
    month: json["month"] == null ? null : json["month"],
    totalFinal: json["total_final"] == null ? null : json["total_final"].toDouble(),
    shareCollaborator: json["share_collaborator"] == null ? null : json["share_collaborator"].toDouble(),
    shareAgency: json["share_agency"] == null ? null : json["share_agency"].toDouble(),
    awarded: json["awarded"] == null ? null : json["awarded"],
    moneyBonusRewarded: json["money_bonus_rewarded"] == null ? null : json["money_bonus_rewarded"].toDouble(),
    moneyBonusCurrent: json["money_bonus_current"] == null ? null : json["money_bonus_current"].toDouble(),
  );
}
