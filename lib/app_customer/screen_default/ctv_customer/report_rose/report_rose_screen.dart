import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import 'report_rose_controller.dart';

class ReportRoseScreen extends StatelessWidget {
  ReportRoseController reportRoseController = ReportRoseController();
  RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo hoa hồng"),
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
              body = Obx(() => reportRoseController.isLoadMore.value
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
          await reportRoseController.getReportRose(isRefresh: true);
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await reportRoseController.getReportRose(isRefresh: false);
          _refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              Obx(
                () => Column(
                  children: reportRoseController.listReportRose
                      .map(
                        (e) => boxReportRose(
                          month: e.month!,
                          year: e.year!,
                          totalFinal: e.totalFinal!,
                          rose: e.shareCollaborator!,
                          bonus: e.moneyBonusCurrent!,
                          awarded: e.awarded!,
                          bonusRewared: e.moneyBonusRewarded!,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget boxReportRose(
      {required int month,
      required int year,
      required double totalFinal,
      required double rose,
      required double bonus,
      required double bonusRewared,
      required bool awarded}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tháng $month Năm $year",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Tổng doanh thu: ${SahaStringUtils().convertToMoney(totalFinal)} ₫"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Tổng hoa hồng: ${SahaStringUtils().convertToMoney(rose)} ₫"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Tổng thưởng: ${SahaStringUtils().convertToMoney(bonus)} ₫"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Đã nhận: ${SahaStringUtils().convertToMoney(bonusRewared)} ₫"),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (awarded == true)
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 3,
                            offset: Offset(4, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/gift_received.svg",
                              height: 35,
                              width: 35,
                              color: Colors.green,
                            ),
                            Text(
                              "Đã nhận",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
