class GuessNumberGame {
  GuessNumberGame(
      {this.id,
      this.storeId,
      this.userId,
      this.name,
      this.icon,
      this.images,
      this.turnInDay,
      this.timeStart,
      this.timeEnd,
      this.timeAnnounceResult,
      this.status,
      this.groupCustomerId,
      this.agencyTypeId,
      this.applyFor,
      this.description,
      this.note,
      this.isLimitPeople,
      this.numberLimitPeople,
      this.isGuessNumber,
      this.isShowGame,
      this.isInitialResult,
      this.createdAt,
      this.updatedAt,
      this.agencyId,
      this.isCusHasJoined,
      this.infoPlayer,
      this.listResult,
      this.rangeNumber,
      this.textResult,
      this.valueGift,
      this.finalResultAnnounced,
      this.isShowAllPrizer});
  int? id;
  int? storeId;
  int? userId;
  String? name;
  dynamic icon;
  List<String>? images;
  int? turnInDay;
  DateTime? timeStart;
  DateTime? timeEnd;
  DateTime? timeAnnounceResult;
  int? status;
  dynamic groupCustomerId;
  dynamic agencyTypeId;
  int? applyFor;
  String? description;
  dynamic note;
  bool? isLimitPeople;
  int? numberLimitPeople;
  bool? isGuessNumber;
  bool? isShowGame;
  bool? isInitialResult;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic agencyId;
  bool? isCusHasJoined;
  InfoPlayer? infoPlayer;
  List<GuessGameResult>? listResult;
  int? rangeNumber;
  dynamic textResult;
  String? valueGift;
  bool? isShowAllPrizer;
  FinalResultAnnounced? finalResultAnnounced;

  factory GuessNumberGame.fromJson(Map<String, dynamic> json) =>
      GuessNumberGame(
          id: json["id"],
          storeId: json["store_id"],
          userId: json["user_id"],
          name: json["name"],
          icon: json["icon"],
          images: json["images"] == null
              ? []
              : List<String>.from(json["images"]!.map((x) => x)),
          turnInDay: json["turn_in_day"],
          timeStart: json["time_start"] == null
              ? null
              : DateTime.parse(json["time_start"]),
          timeEnd: json["time_end"] == null
              ? null
              : DateTime.parse(json["time_end"]),
          timeAnnounceResult: json["time_announce_result"] == null
              ? null
              : DateTime.parse(json["time_announce_result"]),
          status: json["status"],
          groupCustomerId: json["group_customer_id"],
          agencyTypeId: json["agency_type_id"],
          applyFor: json["apply_for"],
          description: json["description"],
          note: json["note"],
          isLimitPeople: json["is_limit_people"],
          numberLimitPeople: json["number_limit_people"],
          isGuessNumber: json["is_guess_number"],
          isShowGame: json["is_show_game"],
          isInitialResult: json["is_initial_result"],
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]),
          agencyId: json["agency_id"],
          isCusHasJoined: json["is_cus_has_joined"],
          infoPlayer: json["info_player"] == null
              ? null
              : InfoPlayer.fromJson(json["info_player"]),
          listResult: json["list_result"] == null
              ? []
              : List<GuessGameResult>.from(
                  json["list_result"]!.map((x) => GuessGameResult.fromJson(x))),
          rangeNumber: json['range_number'],
          textResult: json['text_result'],
          valueGift: json['value_gift'],
          isShowAllPrizer: json['is_show_all_prizer'],
          finalResultAnnounced: json['final_result_announced'] == null
              ? null
              : FinalResultAnnounced.fromJson(json['final_result_announced']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "icon": icon,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "turn_in_day": turnInDay,
        "time_start": timeStart?.toIso8601String(),
        "time_end": timeEnd?.toIso8601String(),
        "time_announce_result": timeAnnounceResult?.toIso8601String(),
        //"status": status,
        "group_customer_id": groupCustomerId,
        "agency_type_id": agencyTypeId,
        "apply_for": applyFor,
        "description": description,
        "note": note,
        "is_limit_people": isLimitPeople,
        "number_limit_people": numberLimitPeople,
        "is_guess_number": isGuessNumber,
        "is_show_game": isShowGame,
        "is_initial_result": isInitialResult,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "agency_id": agencyId,
        "is_cus_has_joined": isCusHasJoined,
        "info_player": infoPlayer?.toJson(),
        "list_result": listResult == null
            ? []
            : List<dynamic>.from(listResult!.map((x) => x.toJson())),
        'range_number': rangeNumber,
        "text_result": textResult,
        "value_gift": valueGift,
        "is_show_all_prizer": isShowAllPrizer
      };
}

class GuessGameResult {
  GuessGameResult({
    this.id,
    this.storeId,
    this.guessNumberId,
    this.textResult,
    this.isCorrect,
    this.imageUrlResult,
    this.descriptionResult,
    this.valueGift,
    this.imageUrlGift,
    this.descriptionGift,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? guessNumberId;
  String? textResult;
  bool? isCorrect;
  String? imageUrlResult;
  String? descriptionResult;
  String? valueGift;
  String? imageUrlGift;
  String? descriptionGift;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GuessGameResult.fromJson(Map<String, dynamic> json) =>
      GuessGameResult(
        id: json["id"],
        storeId: json["store_id"],
        guessNumberId: json["guess_number_id"],
        textResult: json["text_result"],
        isCorrect: json["is_correct"],
        imageUrlResult: json["image_url_result"],
        descriptionResult: json["description_result"],
        valueGift: json["value_gift"],
        imageUrlGift: json["image_url_gift"],
        descriptionGift: json["description_gift"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "guess_number_id": guessNumberId,
        "text_result": textResult,
        "is_correct": isCorrect,
        "image_url_result": imageUrlResult,
        "description_result": descriptionResult,
        "value_gift": valueGift,
        "image_url_gift": imageUrlGift,
        "description_gift": descriptionGift,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class InfoPlayer {
  InfoPlayer({
    this.id,
    this.storeId,
    this.guessNumberId,
    this.customerId,
    this.totalTurnPlay,
    this.totalWin,
    this.totalMissed,
    this.isGetTurnToday,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? guessNumberId;
  int? customerId;
  int? totalTurnPlay;
  int? totalWin;
  int? totalMissed;
  bool? isGetTurnToday;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory InfoPlayer.fromJson(Map<String, dynamic> json) => InfoPlayer(
        id: json["id"],
        storeId: json["store_id"],
        guessNumberId: json["guess_number_id"],
        customerId: json["customer_id"],
        totalTurnPlay: json["total_turn_play"],
        totalWin: json["total_win"],
        totalMissed: json["total_missed"],
        isGetTurnToday: json["is_get_turn_today"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "guess_number_id": guessNumberId,
        "customer_id": customerId,
        "total_turn_play": totalTurnPlay,
        "total_win": totalWin,
        "total_missed": totalMissed,
        "is_get_turn_today": isGetTurnToday,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class FinalResultAnnounced {
  FinalResultAnnounced({
    this.customerWin,
    this.gameResulted,
  });

  List<CustomerWin>? customerWin;
  GameResulted? gameResulted;

  factory FinalResultAnnounced.fromJson(Map<String, dynamic> json) =>
      FinalResultAnnounced(
          customerWin: json["customer_win"] == null
              ? []
              : List<CustomerWin>.from(
                  json["customer_win"]!.map((x) => CustomerWin.fromJson(x))),
          gameResulted: json["game_resulted"] == null
              ? null
              : GameResulted.fromJson(json["game_resulted"]));

  // Map<String, dynamic> toJson() => {
  //     "customer_win": customerWin?.toJson(),
  //     "game_resulted": gameResulted == null ? [] : List<dynamic>.from(gameResulted!.map((x) => x.toJson())),
  // };
}

class GameResulted {
  GameResulted({
    this.textResult,
    this.valueGift,
  });

  dynamic textResult;
  String? valueGift;

  factory GameResulted.fromJson(Map<String, dynamic> json) => GameResulted(
        textResult: json["text_result"],
        valueGift: json["value_gift"],
      );

  Map<String, dynamic> toJson() => {
        "text_result": textResult,
        "value_gift": valueGift,
      };
}

class CustomerWin {
  CustomerWin({
    this.id,
    this.storeId,
    this.username,
    this.areaCode,
    this.phoneNumber,
    this.official,
    this.phoneVerifiedAt,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.name,
    this.nameStrFilter,
    this.referralPhoneNumber,
    this.dateOfBirth,
    this.avatarImage,
    this.points,
    this.sex,
    this.isCollaborator,
    this.isPassersby,
    this.isAgency,
    this.isSale,
    this.isFromJson,
    this.debt,
    this.province,
    this.district,
    this.wards,
    this.addressDetail,
    this.countryName,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.saleStaffId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  dynamic username;
  String? areaCode;
  String? phoneNumber;
  int? official;
  dynamic phoneVerifiedAt;
  String? email;
  dynamic emailVerifiedAt;
  String? password;
  dynamic rememberToken;
  String? name;
  String? nameStrFilter;
  String? referralPhoneNumber;
  DateTime? dateOfBirth;
  String? avatarImage;
  int? points;
  int? sex;
  int? isCollaborator;
  int? isPassersby;
  int? isAgency;
  int? isSale;
  int? isFromJson;
  int? debt;
  dynamic province;
  dynamic district;
  dynamic wards;
  dynamic addressDetail;
  dynamic countryName;
  dynamic provinceName;
  dynamic districtName;
  dynamic wardsName;
  int? saleStaffId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CustomerWin.fromJson(Map<String, dynamic> json) => CustomerWin(
        id: json["id"],
        storeId: json["store_id"],
        username: json["username"],
        areaCode: json["area_code"],
        phoneNumber: json["phone_number"],
        official: json["official"],
        phoneVerifiedAt: json["phone_verified_at"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        name: json["name"],
        nameStrFilter: json["name_str_filter"],
        referralPhoneNumber: json["referral_phone_number"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        avatarImage: json["avatar_image"],
        points: json["points"],
        sex: json["sex"],
        isCollaborator: json["is_collaborator"],
        isPassersby: json["is_passersby"],
        isAgency: json["is_agency"],
        isSale: json["is_sale"],
        isFromJson: json["is_from_json"],
        debt: json["debt"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail: json["address_detail"],
        countryName: json["country_name"],
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
        saleStaffId: json["sale_staff_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "username": username,
        "area_code": areaCode,
        "phone_number": phoneNumber,
        "official": official,
        "phone_verified_at": phoneVerifiedAt,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "remember_token": rememberToken,
        "name": name,
        "name_str_filter": nameStrFilter,
        "referral_phone_number": referralPhoneNumber,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "avatar_image": avatarImage,
        "points": points,
        "sex": sex,
        "is_collaborator": isCollaborator,
        "is_passersby": isPassersby,
        "is_agency": isAgency,
        "is_sale": isSale,
        "is_from_json": isFromJson,
        "debt": debt,
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "country_name": countryName,
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
        "sale_staff_id": saleStaffId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
