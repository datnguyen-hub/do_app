import 'package:sahashop_customer/app_customer/model/guess_number_game.dart';

class AllHistoryGuessNumberRes {
  AllHistoryGuessNumberRes({
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

  factory AllHistoryGuessNumberRes.fromJson(Map<String, dynamic> json) =>
      AllHistoryGuessNumberRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<HistoryGuessNumber>? data;

  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<HistoryGuessNumber>.from(
                json["data"]!.map((x) => HistoryGuessNumber.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class HistoryGuessNumber {
  HistoryGuessNumber({
    this.id,
    this.storeId,
    this.guessNumberId,
    this.playerGuessNumberId,
    this.guessNumberResultId,
    this.isCorrect,
    this.valuePredict,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.guessNumber,
    this.guessNumberResult,
  });

  int? id;
  int? storeId;
  int? guessNumberId;
  int? playerGuessNumberId;
  dynamic guessNumberResultId;
  bool? isCorrect;
  String? valuePredict;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  GuessNumberGame? guessNumber;
  GuessNumberResult? guessNumberResult;

  factory HistoryGuessNumber.fromJson(Map<String, dynamic> json) =>
      HistoryGuessNumber(
        id: json["id"],
        storeId: json["store_id"],
        guessNumberId: json["guess_number_id"],
        playerGuessNumberId: json["player_guess_number_id"],
        guessNumberResultId: json["guess_number_result_id"],
        isCorrect: json["is_correct"],
        valuePredict: json["value_predict"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        guessNumber: json["guess_number"] == null
            ? null
            : GuessNumberGame.fromJson(json["guess_number"]),
        guessNumberResult: json["guess_number_result"] == null
            ? null
            : GuessNumberResult.fromJson(json["guess_number_result"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "guess_number_id": guessNumberId,
        "player_guess_number_id": playerGuessNumberId,
        "guess_number_result_id": guessNumberResultId,
        "is_correct": isCorrect,
        "value_predict": valuePredict,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "guess_number": guessNumber?.toJson(),
        "guess_number_result": guessNumberResult,
      };
}

class GuessNumberResult {
  GuessNumberResult(
      {this.description,
      this.imageUrl,
      this.textResult,
      this.descriptionGift,
      this.imageUrlGift,
      this.valueGift,
      this.createdAt,
      this.guessNumberId,
      this.id,
      this.storeId,
      this.updatedAt,
      this.isCorrect});
  String? textResult;
  String? imageUrl;
  String? description;
  String? valueGift;
  String? imageUrlGift;
  String? descriptionGift;
  int? id;
  int? storeId;
  int? guessNumberId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isCorrect;

  factory GuessNumberResult.fromJson(Map<String, dynamic> json) =>
      GuessNumberResult(
        textResult: json['text_result'],
        imageUrl: json['image_url'],
        description: json['description'],
        valueGift: json["value_gift"],
        imageUrlGift: json['image_url_gift'],
        descriptionGift: json['description_gift'],
        id: json["id"],
        storeId: json["store_id"],
        guessNumberId: json["guess_number_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        // isCorrect: json['is_correct']
      );

  Map<String, dynamic> toJson() => {
        'text_result': textResult,
        'image_url': imageUrl,
        'description': description,
        'value_gift': valueGift,
        'image_url_gift': imageUrlGift,
        'description_gift': descriptionGift,
        "is_correct": isCorrect
      };
}
