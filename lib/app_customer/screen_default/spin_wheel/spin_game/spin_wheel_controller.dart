import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/spin_wheel/mini_game_controller.dart';

import '../../../components/toast/saha_alert.dart';
import '../../../repository/repository_customer.dart';

class SpinWheelController extends GetxController {
  var turn = 0.obs;

  SpinWheelController() {
    getTurnInGame();
  }
  Future<void> getTurnInGame() async {
    try {
      var res = await CustomerRepositoryManager.miniGameRepository
          .getMiniGame(gameId: Get.find<MiniGameController>().gameId);
      turn.value = res!.data!.playerInfo?.totalTurnPlay ?? 0;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
