import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/widget/choose_time/choose_time_screen.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../utils/date_utils.dart';

import 'referral_controller.dart';

class ReferralScreen extends StatelessWidget {
  ReferralController referralController = ReferralController();

  RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách giới thiệu"),
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
              body = Obx(() => referralController.isLoading.value
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
          await referralController.getAllReferralAgency(isRefresh: true);
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await referralController.getAllReferralAgency(isRefresh: false);
          _refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  head(),
                  ...referralController.listInfoCustomer
                    .map(
                      (e) => itemReferral(e),
                    )
                    .toList()]),
          ),
        ),
      ),
    );
  }

  Widget itemReferral(InfoCustomer infoCustomer) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tên:"),
                  Text("${infoCustomer.name ?? ""}"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SĐT:"),
                  Text("${infoCustomer.phoneNumber ?? ""}"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hoa hồng:"),
                  Text(
                      "${SahaStringUtils().convertToMoney(infoCustomer.totalShareAgencyReferen ?? "0")}"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Doanh thu:"),
                  Text(
                      "${SahaStringUtils().convertToMoney(infoCustomer.totalFinal ?? "0")}"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tổng đơn:"),
                  Text(
                      "${SahaStringUtils().convertToMoney(infoCustomer.countOrders ?? "0")}"),
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
  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: false,
                  hideCompare: true,
                  initTab: referralController.indexTabTime,
                  fromDayInput: referralController.fromDay.value,
                  toDayInput: referralController.toDay.value,
                  initChoose: referralController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    referralController.fromDay.value = fromDate;
                    referralController.toDay.value = toDay;

                    referralController.indexTabTime = indexTab ?? 0;
                    referralController.indexChooseTime = indexChoose ?? 0;
                  },
                ))!
            .then((value) => {
                  referralController.getAllReferralAgency(isRefresh: true),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(referralController.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(referralController.toDay.value))
                ? Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Từ: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(referralController.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  SahaDateUtils().getDDMMYY(referralController.toDay.value)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ngày: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(referralController.fromDay.value)} "),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  ),
          )),
    );
  }
}
