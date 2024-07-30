
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sahashop_customer/app_customer/screen_default/spin_wheel/shake_game/shake_game.dart';
import 'package:sahashop_customer/app_customer/screen_default/spin_wheel/spin_game/spin_wheel.dart';

import '../../components/loading/loading_full_screen2.dart';
import 'mini_game_controller.dart';

// class MiniGameScreen extends StatelessWidget {
//   int gameId;
//   MiniGameScreen({Key? key, required this.gameId}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return CheckCustomerLogin(
//         child: MiniGameLoggedScreen(
//       gameId: gameId,
//     ));
//   }
// }

class MiniGameScreen extends StatelessWidget {
  MiniGameScreen({super.key, required this.gameId}) {
    miniGameController = Get.put(MiniGameController(gameId: gameId));
  }
  int gameId;

  late MiniGameController miniGameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => miniGameController.loadInit.value
            ? SahaLoadingFullScreen2()
            : miniGameController.miniGame.value.isShake == false
                ? SpinWheel()
                : ShakeGame()));
  }
}
