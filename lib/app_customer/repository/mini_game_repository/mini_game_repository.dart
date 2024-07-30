import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/join_mini_game_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/mini_game_res.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/mini_game/all_history_gift_res.dart';
import '../../remote/response-request/mini_game/all_history_guess_number_res.dart';
import '../../remote/response-request/mini_game/get_turn_res.dart';
import '../../remote/response-request/mini_game/gift_winning_res.dart';
import '../../remote/response-request/mini_game/guess_number_game_res.dart';
import '../../remote/response-request/mini_game/join_guess_number_res.dart';
import '../../remote/response-request/mini_game/play_guess_game_res.dart';
import '../../utils/store_info.dart';
import '../handle_error.dart';

class MiniGameRepository {
  Future<MiniGameRes?> getMiniGame({required int gameId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getMiniGame(StoreInfo().getCustomerStoreCode(), gameId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<GiftWinningRes?> playSpinWheel({required int gameId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .playSpinWheel(StoreInfo().getCustomerStoreCode(), gameId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<JoinMiniGameRes?> joinMiniGame({required int gameId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .joinMiniGame(StoreInfo().getCustomerStoreCode(), gameId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<GetTurnRes?> getTurn(
      {required int gameId, required int typeTurn}) async {
    try {
      var res = await CustomerServiceManager().service!.getTurn(
          StoreInfo().getCustomerStoreCode(), gameId, {"type_turn": typeTurn});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllHistoryGiftRes?> getAllHistoryGift(
      {required int gameId, required int page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllHistoryGift(StoreInfo().getCustomerStoreCode(), gameId, page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<GuessNumberGameRes?> getGuessNumberGame({required int gameId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getGuessNumberGame(StoreInfo().getCustomerStoreCode(), gameId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<JoinGuessNumberRes?> joinGuessGame({required int gameId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .joinGuessGame(StoreInfo().getCustomerStoreCode(), gameId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PlayGuessGameRes?> playGuessGame(
      {required int gameId,
      String? predictResult,
      int? guessNumberResultId}) async {
    try {
      var res = await CustomerServiceManager().service!.playGuessGame(
          StoreInfo().getCustomerStoreCode(), gameId, {
        "value_predict": predictResult,
        "guess_number_result_id": guessNumberResultId
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllHistoryGuessNumberRes?> getAllHistoryGuessNumber(
      {required int gameId, required int page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllHistoryGuessNumber(
              StoreInfo().getCustomerStoreCode(), gameId, page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
