import 'package:sahashop_customer/app_customer/model/player_info.dart';

import 'gift.dart';

class MiniGame {
  MiniGame(
      {this.id,
      this.storeId,
      this.userId,
      this.name,
      this.images,
      this.icon,
      this.description,
      this.turnInDay,
      this.timeStart,
      this.timeEnd,
      this.status,
      this.groupCustomerId,
      this.applyFor,
      this.note,
      this.isLimitPeople,
      this.numberLimitPeople,
      this.maxAmountCoinPerPlayer,
      this.maxAmountGiftPerPlayer,
      this.createdAt,
      this.updatedAt,
      this.listGift,
      this.isCusHasJoined,
      this.playerInfo,
      this.isShake,
      this.agencyId,
      this.backgroundImageUrl,
      this.typeBackgroundImage});

  int? id;
  int? storeId;
  int? userId;
  String? name;
  List<String>? images;
  dynamic icon;
  dynamic description;
  int? turnInDay;
  DateTime? timeStart;
  DateTime? timeEnd;
  int? status;
  int? groupCustomerId;
  int? applyFor;

  dynamic note;
  int? isLimitPeople;
  int? numberLimitPeople;
  int? maxAmountCoinPerPlayer;
  int? maxAmountGiftPerPlayer;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Gift>? listGift;
  bool? isCusHasJoined;
  PlayerInfo? playerInfo;
  bool? isShake;
  int? agencyId;
  int? typeBackgroundImage;
  String? backgroundImageUrl;

  factory MiniGame.fromJson(Map<String, dynamic> json) => MiniGame(
      id: json["id"],
      storeId: json["store_id"],
      userId: json["user_id"],
      name: json["name"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      icon: json["icon"],
      description: json["description"],
      turnInDay: json["turn_in_day"],
      timeStart: json["time_start"] == null
          ? null
          : DateTime.parse(json["time_start"]),
      timeEnd:
          json["time_end"] == null ? null : DateTime.parse(json["time_end"]),
      status: json["status"],
      groupCustomerId: json["group_customer_id"],
      applyFor: json["apply_for"],
      note: json["note"],
      isLimitPeople: json["is_limit_people"],
      numberLimitPeople: json["number_limit_people"],
      maxAmountCoinPerPlayer: json["max_amount_coin_per_player"],
      maxAmountGiftPerPlayer: json["max_amount_gift_per_player"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      listGift: json["list_gift"] == null
          ? []
          : List<Gift>.from(json["list_gift"]!.map((x) => Gift.fromJson(x))),
      isCusHasJoined: json['is_cus_has_joined'],
      playerInfo: json['info_player'] == null
          ? null
          : PlayerInfo.fromJson(json['info_player']),
      isShake: json['is_shake'],
      agencyId: json['agency_type_id'],
      backgroundImageUrl: json['background_image_url'],
      typeBackgroundImage: json['type_background_image']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "icon": icon,
        "description": description,
        "turn_in_day": turnInDay,
        "time_start": timeStart?.toIso8601String(),
        "time_end": timeEnd?.toIso8601String(),
        "status": status,
        "group_customer_id": groupCustomerId,
        "apply_for": applyFor,
        "note": note,
        "is_limit_people": isLimitPeople,
        "number_limit_people": numberLimitPeople,
        "max_amount_coin_per_player": maxAmountCoinPerPlayer,
        "max_amount_gift_per_player": maxAmountGiftPerPlayer,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "list_gift": listGift == null
            ? []
            : List<dynamic>.from(listGift!.map((x) => x.toJson())),
        "agency_type_id": agencyId
      };
}
