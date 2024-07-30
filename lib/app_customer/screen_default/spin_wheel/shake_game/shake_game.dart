import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shake/shake.dart';

import '../../../components/toast/saha_alert.dart';
import '../../data_app_controller.dart';
import '../history_gift/history_gift_screen.dart';
import '../mini_game_controller.dart';
import '../rules/rules_screen.dart';

class ShakeGame extends StatefulWidget {
  const ShakeGame({super.key});

  @override
  State<ShakeGame> createState() => _ShakeGameState();
}

class _ShakeGameState extends State<ShakeGame> {
  MiniGameController miniGameController = Get.find();
  late ShakeDetector detector;
  late AssetImage image;
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    super.initState();
    image = AssetImage('packages/sahashop_customer/assets/gift.gif');

    detector = ShakeDetector.autoStart(onPhoneShake: () async {
      if (dataAppCustomerController.isLogin.value = false) {
        SahaAlert.showError(
            message: 'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
        return;
      }
      if ((miniGameController.miniGame.value.timeEnd ?? DateTime.now())
          .isBefore(DateTime.now())) {
        SahaAlert.showError(message: 'Trò chơi đã quá hạn chơi');
        return;
      }
      if (miniGameController.miniGame.value.isCusHasJoined == false) {
        SahaAlert.showError(message: "Vui lòng hay bấm tham gia trò chơi ");
      } else {
        if (miniGameController.isPlaying == false) {
          if (miniGameController.miniGame.value.playerInfo?.totalTurnPlay ==
                  0 ||
              miniGameController.miniGame.value.playerInfo?.totalTurnPlay ==
                  null) {
            SahaAlert.showError(
                message:
                    'Bạn đã dùng hết lượt quay còn lại,\n vui lòng lấy thêm lượt quay!');
            return;
          }
          await miniGameController.playSpinWheel();
          miniGameController.getMiniGame();
          Future.delayed(Duration(milliseconds: 5000), () async {
            miniGameController.isPlaying.value = false;
            image.evict();
            if ((miniGameController.giftWinning.amountGift ?? 0) > 0) {
              showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Text('Xin chúc mừng bạn'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        if (miniGameController.giftWinning.typeGift == 0)
                          Text(
                              'Bạn nhân được ${miniGameController.giftWinning.amountCoin} xu'),
                        if (miniGameController.giftWinning.typeGift == 2)
                          Text(
                              'Bạn nhân được ${miniGameController.giftWinning.name}'),
                        if (miniGameController.giftWinning.typeGift == 1)
                          Text(
                              'Bạn nhân được ${miniGameController.giftWinning.name}'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Đồng ý'),
                      onPressed: () async {
                        Get.back();
                        Get.to(() => HistoryGiftScreen(
                              gameId: miniGameController.miniGame.value.id!,
                            ));
                      },
                    ),
                    TextButton(
                      child: Text('Thoát'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            } else {
              showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Text(
                      'Xin lỗi bạn phần quà này đã hết, xin bạn vui lòng chơi lại'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Đồng ý'),
                      onPressed: () async {
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            }
          });
        }
      }
    });
  }

  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: miniGameController.miniGame.value.typeBackgroundImage == 0
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(miniGameController
                              .miniGame.value.backgroundImageUrl ==
                          null
                      ? 'packages/sahashop_customer/assets/images/background_spin_wheel.png'
                      : "packages/sahashop_customer/${miniGameController.miniGame.value.backgroundImageUrl}"))
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      miniGameController.miniGame.value.backgroundImageUrl ??
                          ''))),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            child: Obx(
              () => miniGameController.isPlaying.value
                  ? Center(
                      child: Image(
                        image: image,
                        fit: BoxFit.cover,
                        height: Get.height,
                        width: Get.width,
                      ),
                    )
                  : Center(
                      child: Image(
                        image: AssetImage(
                            'packages/sahashop_customer/assets/gift_box.gif'),
                        fit: BoxFit.cover,
                        height: Get.height / 2,
                        width: Get.width / 2,
                      ),
                    ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.8)),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Obx(
                        () => miniGameController
                                    .miniGame.value.isCusHasJoined ==
                                false
                            ? InkWell(
                                onTap: () async {
                                  await miniGameController.joinMiniGame();
                                  await miniGameController.getMiniGame();
                                },
                                child: Container(
                                  width: 200,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(Get.context!).primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'THAM GIA TRÒ CHƠI',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (miniGameController
                                          .miniGame.value.isCusHasJoined ==
                                      true)
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 2,
                                                bottom: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                                'Số lượt lắc còn lại : ${miniGameController.miniGame.value.playerInfo?.totalTurnPlay ?? 'Chưa có thông tin'}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // InkWell(
                                              //   onTap: () async {
                                              //     if (dataAppCustomerController
                                              //         .isLogin.value = false) {
                                              //       SahaAlert.showError(
                                              //           message:
                                              //               'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
                                              //       return;
                                              //     }
                                              //     await miniGameController
                                              //         .getTurn(typeTurn: 0);
                                              //     miniGameController
                                              //         .getMiniGame();
                                              //   },
                                              //   child: Container(
                                              //     padding:
                                              //         const EdgeInsets.all(8),
                                              //     decoration: BoxDecoration(
                                              //         color:
                                              //             Theme.of(Get.context!)
                                              //                 .primaryColor,
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 10)),
                                              //     child: Center(
                                              //       child: Row(
                                              //         children: [
                                              //           Icon(
                                              //             Icons.get_app,
                                              //             color: Colors.white,
                                              //           ),
                                              //           SizedBox(
                                              //             width: 5,
                                              //           ),
                                              //           Text(
                                              //             'Lấy thêm lượt lắc',
                                              //             style: TextStyle(
                                              //                 color:
                                              //                     Colors.white,
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .bold,
                                              //                 fontSize: 16),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),

                  ////
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (dataAppCustomerController.isLogin.value == false) {
                            SahaAlert.showError(
                                message:
                                    'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
                            return;
                          }
                          Get.to(() => RulesScreen(
                                miniGame: miniGameController.miniGame.value,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: <Color>[
                                    Colors.amber,
                                    Colors.amber.withOpacity(0.5)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red,
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              color: Theme.of(Get.context!).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Thể lệ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => HistoryGiftScreen(
                                gameId: miniGameController.miniGame.value.id!,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(Get.context!).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Colors.indigoAccent,
                                  Colors.indigoAccent.withOpacity(0.5)
                                ]),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red,
                                spreadRadius: 10,
                                blurRadius: 10,
                                offset:
                                    Offset(3, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Lịch sử quà',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
