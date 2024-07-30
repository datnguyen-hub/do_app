import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/login_screen.dart';

import '../../components/button/saha_button.dart';
import '../../components/loading/loading_container.dart';
import '../../components/toast/saha_alert.dart';
import '../../model/guess_number_game.dart';
import 'award_announcement/award_announcement_screen.dart';
import 'guess_number_controller.dart';
import 'history_guess_game/history_guess_game_screen.dart';

class GuessGameScreen extends StatefulWidget {
  GuessGameScreen({super.key, required this.gameId}) {
    guessNumberController = GuessNumberController(gameId: gameId);
  }
  int gameId;

  late GuessNumberController guessNumberController;

  @override
  State<GuessGameScreen> createState() => _GuessGameScreenState();
}

class _GuessGameScreenState extends State<GuessGameScreen>
    with AfterLayoutMixin<GuessGameScreen> {
  ScrollController controller = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     scrollDown();
  //     print('----------abcdef');
  //   });
  // }

  @override
  void afterFirstLayout(BuildContext context) {
    print('----------abcdef');
    // controller.animateTo(
    //   controller.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.fastOutSlowIn,
    // );
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   scrollDown();
    //   print('----------abcdef');
    // });
    scrollDown();
    // print('----------abcdef---------');
  }

  void scrollDown() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.guessNumberController.loadInit.value
          ? SahaLoadingFullScreen()
          : widget.guessNumberController.guessNumber.value
                          .finalResultAnnounced !=
                      null &&
                  (widget.guessNumberController.guessNumber.value.timeEnd ??
                          DateTime.now())
                      .isBefore(DateTime.now())
              ? AwardAnnouncementScreen(
                  guessGameNumber:
                      widget.guessNumberController.guessNumber.value,
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Obx(() => Text(
                        widget.guessNumberController.guessNumber.value.name ??
                            '')),
                  ),
                  body: Obx(
                    () => widget.guessNumberController.loadInit.value
                        ? SahaLoadingFullScreen()
                        : SingleChildScrollView(
                            controller: controller,
                            child: Column(
                              children: [
                                if(widget.guessNumberController
                                          .guessNumber.value.images!.isNotEmpty)
                                Container(
                                  height: 200,
                                  width: Get.width,
                                  child: Swiper(
                                    itemBuilder: (context, index) {
                                      final image = widget.guessNumberController
                                          .guessNumber.value.images![index];
                                      return CachedNetworkImage(
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                        imageUrl: image,
                                        placeholder: (context, url) =>
                                            SahaLoadingContainer(),
                                        errorWidget: (context, url, error) =>
                                            SahaEmptyImage(),
                                      );
                                    },
                                    indicatorLayout: PageIndicatorLayout.COLOR,
                                    autoplay: true,
                                    itemCount: widget.guessNumberController
                                        .guessNumber.value.images!.length,
                                    pagination: const SwiperPagination(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.guessNumberController.expanded
                                            .value =
                                        !widget.guessNumberController.expanded
                                            .value;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: Get.width,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/bingo.svg",
                                          width: 30,
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'THỂ LỆ',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Obx(() => Icon(widget
                                                .guessNumberController
                                                .expanded
                                                .value
                                            ? Icons.keyboard_arrow_down_rounded
                                            : Icons.navigate_next_rounded))
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(() => widget
                                        .guessNumberController.expanded.value
                                    ? Container(
                                        height: 150,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: SvgPicture.asset(
                                                "assets/icons/bingo.svg",
                                              ),
                                            ),
                                            Positioned.fill(
                                                child: Container(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                            )),
                                            Positioned.fill(
                                              child: widget
                                                          .guessNumberController
                                                          .guessNumber
                                                          .value
                                                          .description ==
                                                      null
                                                  ? Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(widget
                                                                .guessNumberController
                                                                .guessNumber
                                                                .value
                                                                .description ??
                                                            'Chưa có thông tin'),
                                                      ),
                                                    )
                                                  : SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              widget
                                                                      .guessNumberController
                                                                      .guessNumber
                                                                      .value
                                                                      .description ??
                                                                  'Chưa có thông tin',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container()),
                                Obx(() => widget.guessNumberController
                                            .guessNumber.value.isCusHasJoined ==
                                        false
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Divider(
                                              color: Colors.red,
                                            ),
                                            Text(
                                              'Bạn chưa tham gia trò chơi này, hãy bấm Tham gia ngay để tham gia trò chơi và nhận những phần quà có giá trị',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await widget
                                                    .guessNumberController
                                                    .joinGuessGame();
                                                widget.guessNumberController
                                                    .getGuessNumberGame();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 3,
                                                        offset: Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                width: 200,
                                                child: Center(
                                                  child: Text(
                                                    'Tham gia ngay',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Column(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Bạn còn: ${widget.guessNumberController.guessNumber.value.infoPlayer?.totalTurnPlay ?? 0} lượt',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (Get.find<
                                                                DataAppCustomerController>()
                                                            .isLogin
                                                            .value ==
                                                        true) {
                                                      Get.to(() =>
                                                          HistoryGuessGameScreen(
                                                            gameId:
                                                                widget.gameId,
                                                          ));
                                                    } else {
                                                      Get.to(() =>
                                                              LoginScreenCustomer())!
                                                          .then((value) => {
                                                                Get.find<
                                                                        DataAppCustomerController>()
                                                                    .getBadge()
                                                              });
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.history,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'Lịch sử dự đoán',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (widget
                                                  .guessNumberController
                                                  .guessNumber
                                                  .value
                                                  .isGuessNumber ==
                                              true)
                                            Column(
                                              children: [
                                                if (widget
                                                        .guessNumberController
                                                        .guessNumber
                                                        .value
                                                        .rangeNumber !=
                                                    null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Bạn cần cần nhập số từ ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        for (int i = 0;
                                                            i <
                                                                widget
                                                                    .guessNumberController
                                                                    .guessNumber
                                                                    .value
                                                                    .rangeNumber!;
                                                            i++)
                                                          Text('0'),
                                                        Text(
                                                          ' đến ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        for (int i = 0;
                                                            i <
                                                                widget
                                                                    .guessNumberController
                                                                    .guessNumber
                                                                    .value
                                                                    .rangeNumber!;
                                                            i++)
                                                          Text('9'),
                                                      ],
                                                    ),
                                                  ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 8, 0),
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  height: 50,
                                                  width: Get.width / 1.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(3, 3),
                                                          blurRadius: 10,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.16),
                                                          spreadRadius: -2,
                                                        )
                                                      ],
                                                      color: Colors.white),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                          child: TextFormField(
                                                        enabled: (widget
                                                                            .guessNumberController
                                                                            .guessNumber
                                                                            .value
                                                                            .timeEnd ??
                                                                        DateTime
                                                                            .now())
                                                                    .isBefore(
                                                                        DateTime
                                                                            .now()) ==
                                                                true
                                                            ? false
                                                            : true,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Nhập đáp án của bạn',
                                                        ),
                                                        controller: widget
                                                            .guessNumberController
                                                            .textResult,
                                                        onChanged: (v) {},
                                                      )),
                                                      IgnorePointer(
                                                        ignoring: (widget
                                                                            .guessNumberController
                                                                            .guessNumber
                                                                            .value
                                                                            .timeEnd ??
                                                                        DateTime
                                                                            .now())
                                                                    .isBefore(
                                                                        DateTime
                                                                            .now()) ==
                                                                true
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                            onTap: () async {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              await widget
                                                                  .guessNumberController
                                                                  .playGuessGame();
                                                              widget
                                                                  .guessNumberController
                                                                  .getGuessNumberGame();
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Text(
                                                                'Gửi Số',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (widget
                                                  .guessNumberController
                                                  .guessNumber
                                                  .value
                                                  .isGuessNumber ==
                                              false)
                                            Column(
                                              children: [
                                                ...(widget
                                                            .guessNumberController
                                                            .guessNumber
                                                            .value
                                                            .listResult ??
                                                        [])
                                                    .map((e) => itemResult(e))
                                              ],
                                            )
                                        ],
                                      )),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                  ),
                  bottomNavigationBar: Obx(() => widget.guessNumberController
                              .guessNumber.value.isGuessNumber ==
                          true
                      ? SizedBox()
                      : widget.guessNumberController.guessNumber.value
                                  .isGuessNumber ==
                              false
                          ? Container(
                              height: 65,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SahaButtonFullParent(
                                    text: 'Xác nhận đáp án',
                                    onPressed: () async {
                                      if (widget.guessNumberController
                                              .onChooseResult.value.id !=
                                          null) {
                                        await widget.guessNumberController
                                            .playGuessGame();
                                        widget.guessNumberController
                                            .getGuessNumberGame();
                                      } else {
                                        SahaAlert.showError(
                                            message:
                                                'Bạn chưa chọn đáp án nào');
                                      }
                                    },
                                    color: widget.guessNumberController
                                                .onChooseResult.value.id ==
                                            null
                                        ? Colors.grey[400]
                                        : Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox()),
                ),
    );
  }

  Widget itemResult(GuessGameResult guessGameResult) {
    return InkWell(
      onTap: () {
        widget.guessNumberController.onChooseResult.value = guessGameResult;
      },
      child: Container(
        width: Get.width * 0.7,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: widget.guessNumberController.onChooseResult.value.id ==
                    guessGameResult.id
                ? Colors.green
                : Colors.grey[350],
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          guessGameResult.textResult ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
