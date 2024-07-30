import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import 'payment_history_controller.dart';

class PaymentHistoryScreen extends StatelessWidget {
  PaymentHistoryController paymentHistoryController =
      PaymentHistoryController();
  RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử số dư"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (
              BuildContext context,
              LoadStatus? mode,
              ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body = Obx(() => paymentHistoryController.isLoadMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: () async {
          await paymentHistoryController.getPaymentCtvHistory(isRefresh: true);
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await paymentHistoryController.getPaymentCtvHistory(isRefresh: false);
          _refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: paymentHistoryController.listPaymentCtvHtr
                    .map(
                      (element) => boxHistory(
                        title: element.typeName ?? "",
                        money: "${element.money ?? ""}",
                        date: element.createdAt!,
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }

  Widget boxHistory(
      {required String title, required String money, required DateTime date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("${SahaStringUtils().convertToMoney(money)} ₫"),
                  Spacer(),
                  Text("${SahaDateUtils().getDDMMYY(date)}")
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
