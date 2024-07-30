import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/all_history_gift_res.dart';

import '../../../components/loading/loading_full_screen.dart';
import 'history_gift_controller.dart';

class HistoryGiftScreen extends StatelessWidget {
  HistoryGiftScreen({super.key, required this.gameId}) {
    historyGiftController = HistoryGiftController(gameId: gameId);
  }
  int gameId;
  late HistoryGiftController historyGiftController;
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử quà tặng'),
      ),
      body: SmartRefresher(
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body = Obx(() => historyGiftController.isLoading.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Container(
              height: 100,
              child: Center(child: body),
            );
          },
        ),
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        onRefresh: () async {
          await historyGiftController.getAllHistoryGift(isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await historyGiftController.getAllHistoryGift();
          refreshController.loadComplete();
        },
        controller: refreshController,
        child: Obx(
          () => historyGiftController.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Wrap(
                          children: [
                            ...historyGiftController.listGift.map((e) {
                              return giftItem(e);
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget giftItem(HistoryGift historyGift) {
    if (historyGift.typeGift == 0) {
      return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Số xu nhận được là :'),
                Text('${historyGift.amountCoinChange}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ngày nhận :'),
                Text(
                    '${DateFormat('dd-MM-yyyy').format(historyGift.createdAt!)}'),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phần quà bạn nhận được là:'),
                Expanded(
                    child: Text(
                  '${historyGift.nameGift ?? ''}',
                  textAlign: TextAlign.right,
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ngày nhận :'),
                Text(
                    '${DateFormat('dd-MM-yyyy').format(historyGift.createdAt!)}'),
              ],
            ),
          ],
        ),
      );
    }
  }
}
