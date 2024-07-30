import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/gift_winning.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../model/mini_game.dart';
import '../../repository/repository_customer.dart';

class MiniGameController extends GetxController {
  int gameId;
  var miniGame = MiniGame().obs;
  var loadInit = true.obs;
  var giftWinning = GiftWinning();
  var hasPlay = false.obs;
  var isPlaying = false.obs;
  var startSpin = false.obs;

  MiniGameController({required this.gameId}) {
    getMiniGame();
  }

  Future<void> getMiniGame() async {
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .getMiniGame(gameId: gameId);
      miniGame.value = res!.data!;
      //turn.value = miniGame.value.playerInfo?.totalTurnPlay ?? 0;
      if (miniGame.value.isCusHasJoined == false &&
          Get.find<DataAppCustomerController>().isLogin == true) {
        await joinMiniGame();
        res = await CustomerRepositoryManager.miniGameRepository
            .getMiniGame(gameId: gameId);
        miniGame.value = res!.data!;
      }
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> playSpinWheel() async {
    isPlaying.value = true;

    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .playSpinWheel(gameId: gameId);
      giftWinning = res!.data!.giftWinning!;
      hasPlay.value = true;
      startSpin.value = true;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
      startSpin.value = false;
      isPlaying.value = false;
    }
  }

  Future<void> joinMiniGame() async {
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .joinMiniGame(gameId: gameId);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getTurn({required int typeTurn}) async {
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .getTurn(gameId: gameId, typeTurn: typeTurn);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  List<Color> listColor = [
    Colors.blue,
    Color.fromARGB(255, 213, 194, 14),
    Colors.orange
  ];
}
