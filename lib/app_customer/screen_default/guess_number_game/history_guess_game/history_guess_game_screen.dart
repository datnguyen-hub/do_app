import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/screen_default/guess_number_game/history_guess_game/history_guess_game_controller.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../remote/response-request/mini_game/all_history_guess_number_res.dart';

class HistoryGuessGameScreen extends StatelessWidget {
  HistoryGuessGameScreen({super.key, required this.gameId}) {
    historyGuessGameController = HistoryGuessGameController(gameId: gameId);
  }
  int gameId;
  late HistoryGuessGameController historyGuessGameController;
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử dự đoán'),
      ),
      body: Obx(
        () => historyGuessGameController.loadInit.value
            ? SahaLoadingFullScreen()
            : historyGuessGameController.listHistory.isEmpty
                ? const Center(
                    child: Text('Chưa có dự đoán nào'),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() =>
                              historyGuessGameController.isLoading.value
                                  ? const CupertinoActivityIndicator()
                                  : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await historyGuessGameController.getAllHistoryGuessNumber(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await historyGuessGameController
                          .getAllHistoryGuessNumber();
                      refreshController.loadComplete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: historyGuessGameController.listHistory
                              .map((e) => itemHistory(e))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget itemHistory(HistoryGuessNumber historyGuessNumber) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Đáp án bạn chọn:'),
              Text(historyGuessNumber.valuePredict == null
                  ? historyGuessNumber.guessNumberResult?.textResult ??
                      'Chưa có thông tin'
                  : historyGuessNumber.valuePredict ?? 'Chưa có thông tin'),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ngày dự đoán:'),
              Text(DateFormat('dd-MM-yyyy')
                  .format(historyGuessNumber.createdAt ?? DateTime.now())),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ngày công bố kết quả:'),
              Text(DateFormat('dd-MM-yyyy').format(
                  historyGuessNumber.guessNumber?.timeEnd ?? DateTime.now())),
            ],
          ),
        ],
      ),
    );
  }
}
