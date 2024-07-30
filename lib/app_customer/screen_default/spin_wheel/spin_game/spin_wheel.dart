import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/spin_wheel/spin_game/spin_wheel_controller.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/toast/saha_alert.dart';
import '../history_gift/history_gift_screen.dart';
import '../mini_game_controller.dart';
import '../rules/rules_screen.dart';

class SpinWheel extends StatelessWidget {
  SpinWheel({super.key});
  MiniGameController miniGameController = Get.find();
  StreamController<int> selected = StreamController<int>();

  SpinWheelController spinWheelController = SpinWheelController();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
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
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.8)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Obx(() => miniGameController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (dataAppCustomerController
                                              .isLogin.value ==
                                          false) {
                                        SahaAlert.showError(
                                            message:
                                                'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
                                        return;
                                      }
                                      Get.to(() => RulesScreen(
                                            miniGame: miniGameController
                                                .miniGame.value,
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
                                              offset: Offset(3,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Theme.of(Get.context!)
                                              .primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                      if (dataAppCustomerController
                                              .isLogin.value ==
                                          false) {
                                        SahaAlert.showError(
                                            message:
                                                'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
                                        return;
                                      }
                                      Get.to(() => HistoryGiftScreen(
                                            gameId: miniGameController
                                                .miniGame.value.id!,
                                          ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(Get.context!).primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: <Color>[
                                              Colors.indigoAccent,
                                              Colors.indigoAccent
                                                  .withOpacity(0.5)
                                            ]),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red,
                                            spreadRadius: 10,
                                            blurRadius: 10,
                                            offset: Offset(3,
                                                3), // changes position of shadow
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
                              const SizedBox(
                                height: 20,
                              ),
                              if (miniGameController
                                          .miniGame.value.isCusHasJoined ==
                                      true &&
                                  dataAppCustomerController.isLogin == true)
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                            'Số lượt quay còn lại : ${spinWheelController.turn.value}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // InkWell(
                                          //   onTap: () async {
                                          //     if (dataAppCustomerController
                                          //             .isLogin.value ==
                                          //         false) {
                                          //       SahaAlert.showError(
                                          //           message:
                                          //               'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
                                          //       return;
                                          //     }
                                          //     await miniGameController.getTurn(
                                          //         typeTurn: 0);
                                          //     miniGameController.getMiniGame();
                                          //   },
                                          //   child: Container(
                                          //     padding: const EdgeInsets.all(8),
                                          //     decoration: BoxDecoration(
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Colors.white
                                          //                 .withOpacity(0.4),
                                          //             spreadRadius: 10,
                                          //             blurRadius: 20,
                                          //             offset: Offset(0,
                                          //                 3), // changes position of shadow
                                          //           ),
                                          //         ],
                                          //         gradient: LinearGradient(
                                          //             begin:
                                          //                 Alignment.bottomLeft,
                                          //             end: Alignment.topRight,
                                          //             colors: <Color>[
                                          //               Colors.deepOrangeAccent,
                                          //               Colors.deepOrangeAccent
                                          //                   .withOpacity(0.5)
                                          //             ]),
                                          //         color: Theme.of(Get.context!)
                                          //             .primaryColor,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 10)),
                                          //     child: Center(
                                          //       child: Text(
                                          //         'Lấy thêm lượt quay',
                                          //         style: TextStyle(
                                          //             color: Colors.white),
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
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              width: Get.width * 0.8,
                              height: Get.width * 0.8,
                              child: FortuneWheel(
                                animateFirst: false,
                                indicators: const <FortuneIndicator>[
                                  FortuneIndicator(
                                    alignment: Alignment
                                        .topCenter, // <-- changing the position of the indicator
                                    child: TriangleIndicator(
                                      color: Colors
                                          .white, // <-- changing the color of the indicator
                                    ),
                                  ),
                                ],
                                onAnimationEnd: () {
                                  if (miniGameController.hasPlay == true) {
                                    if ((miniGameController
                                                .giftWinning.amountGift ??
                                            0) >
                                        0) {
                                      showDialog(
                                        context: Get.context!,
                                        barrierDismissible: false,
                                        builder: (context) => AlertDialog(
                                          title: Text('Xin chúc mừng bạn'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                if (miniGameController
                                                        .giftWinning.typeGift ==
                                                    0)
                                                  Text(
                                                      'Bạn nhân được ${miniGameController.giftWinning.amountCoin} xu'),
                                                if (miniGameController
                                                        .giftWinning.typeGift ==
                                                    2)
                                                  Text(
                                                      'Bạn nhân được ${miniGameController.giftWinning.name}'),
                                                if (miniGameController
                                                        .giftWinning.typeGift ==
                                                    1)
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
                                                      gameId: miniGameController
                                                          .miniGame.value.id!,
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
                                              'Xin lỗi bạn phần quà này hiện đã hết, xin bạn vui lòng chơi lại'),
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
                                            TextButton(
                                              child: Text('Thoát'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    spinWheelController.getTurnInGame();
                                  }
                                  miniGameController.isPlaying.value = false;
                                },
                                duration: const Duration(milliseconds: 3000),
                                // physics: CircularPanPhysics(
                                //   duration: Duration(seconds: 1),
                                //   curve: Curves.decelerate,
                                // ),
                                selected: selected.stream,
                                items: [
                                  for (int i = 0;
                                      i <
                                          miniGameController
                                              .miniGame.value.listGift!.length;
                                      i++)
                                    FortuneItem(
                                        style: FortuneItemStyle(
                                          color: i.isEven
                                              ? Colors.indigoAccent
                                              : Colors
                                                  .red, // <-- custom circle slice fill color
                                          borderColor: Colors
                                              .white, // <-- custom circle slice stroke color
                                          borderWidth:
                                              2, // <-- custom circle slice stroke width
                                        ),
                                        child: Stack(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Image.network(
                                                      miniGameController
                                                              .miniGame
                                                              .value
                                                              .listGift?[i]
                                                              .imageUrl ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                      width: 60,
                                                      height: 60,
                                                      errorBuilder: ((context,
                                                          error, stackTrace) {
                                                        return SahaEmptyImage(
                                                          height: 30,
                                                          width: 30,
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 5,
                                                          top: 20,
                                                          bottom: 25),
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Text(
                                                      miniGameController
                                                              .miniGame
                                                              .value
                                                              .listGift![i]
                                                              .name ??
                                                          '',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                if (dataAppCustomerController.isLogin ==
                                    false) {
                                  SahaAlert.showError(
                                      message:
                                          'Bạn chưa đăng nhập nên chưa thể tham gia trò chơi này');
                                  return;
                                }
                                if ((miniGameController
                                            .miniGame.value.timeEnd ??
                                        DateTime.now())
                                    .isBefore(DateTime.now())) {
                                  SahaAlert.showError(
                                      message: 'Trò chơi đã quá hạn chơi');
                                  return;
                                }
                                if (miniGameController
                                        .miniGame.value.isCusHasJoined ==
                                    true) {
                                  if (miniGameController.isPlaying.value ==
                                      false) {
                                    if (miniGameController.miniGame.value
                                                .playerInfo?.totalTurnPlay ==
                                            0 ||
                                        miniGameController.miniGame.value
                                                .playerInfo?.totalTurnPlay ==
                                            null) {
                                      SahaAlert.showError(
                                          message:
                                              'Bạn đã dùng hết lượt quay còn lại,\n vui lòng lấy thêm lượt quay!');
                                      return;
                                    }
                                    await miniGameController.playSpinWheel();
                                    if (miniGameController.startSpin.value ==
                                        true) {
                                      var index = miniGameController
                                          .miniGame.value.listGift!
                                          .indexWhere((e) =>
                                              e.id ==
                                              miniGameController
                                                  .giftWinning.id);
                                      selected.add(index);
                                      //miniGameController.getMiniGame();
                                    }
                                  }
                                } else {
                                  showDialog(
                                    context: Get.context!,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                          'Bạn có đồng ý tham gia trò chơi này không ?'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Đồng ý'),
                                          onPressed: () async {
                                            await miniGameController
                                                .joinMiniGame();
                                            await miniGameController
                                                .getMiniGame();
                                            Get.back();
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
                                }
                              },
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: <Color>[
                                          Colors.deepOrangeAccent,
                                          Colors.red
                                        ]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.9),
                                        spreadRadius: 10,
                                        blurRadius: 20,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: miniGameController.isPlaying.value ==
                                            false
                                        ? Theme.of(Get.context!).primaryColor
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'BẮT ĐẦU',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
