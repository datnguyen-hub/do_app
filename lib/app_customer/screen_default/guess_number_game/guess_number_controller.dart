import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/guess_number_game.dart';

import '../../repository/repository_customer.dart';

class GuessNumberController extends GetxController {
  var guessNumber = GuessNumberGame().obs;
  int gameId;
  var loadInit = true.obs;
  var textResult = TextEditingController();
  var onChooseResult = GuessGameResult().obs;
  var expanded = false.obs;

  GuessNumberController({required this.gameId}) {
    getGuessNumberGame();
  }

  Future<void> getGuessNumberGame() async {
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .getGuessNumberGame(gameId: gameId);
      guessNumber.value = res!.data!;
      if (guessNumber.value.isCusHasJoined == false) {
        await joinGuessGame();
        res = await CustomerRepositoryManager.miniGameRepository
            .getGuessNumberGame(gameId: gameId);
        guessNumber.value = res!.data!;
      }
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> joinGuessGame() async {
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .joinGuessGame(gameId: gameId);
      //SahaAlert.showSuccess(message: 'Tham gia thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> playGuessGame() async {
    if (guessNumber.value.isGuessNumber == false &&
        onChooseResult.value.id == null) {
      SahaAlert.showError(message: 'Bạn chưa chọn đáp án nào');
      return;
    }
    if (guessNumber.value.isGuessNumber == true && textResult.text.isEmpty) {
      SahaAlert.showError(message: 'Bạn chưa nhập đáp án');
      return;
    }
    if (guessNumber.value.isGuessNumber == true &&
        textResult.text.length > (guessNumber.value.rangeNumber ?? 0)) {
      SahaAlert.showError(
          message: 'Bạn nhập đáp án quá số lượng chữ số cho phép');
      return;
    }
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .playGuessGame(
              gameId: gameId,
              predictResult: textResult.text.isEmpty ? null : textResult.text,
              guessNumberResultId: onChooseResult.value.id);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
