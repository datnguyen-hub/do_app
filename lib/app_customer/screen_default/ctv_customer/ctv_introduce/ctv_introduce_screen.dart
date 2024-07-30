import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/widget/choose_time/choose_time_screen.dart';

import '../../../model/info_customer.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/string_utils.dart';
import 'ctv_introduce_controller.dart';


class CtvIntroduceScreen extends StatelessWidget {
   CtvIntroduceScreen({super.key});

   RefreshController _refreshController = RefreshController();
   CtvIntroduceController controller = CtvIntroduceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách giới thiệu"),),
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
              body = Obx(() => controller.isLoading.value
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
          await controller.getAllCollaborator(isRefresh: true);
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await controller.getAllCollaborator(isRefresh: false);
          _refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  head(),
                  ...controller.listInfoCustomer
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
                  initTab: controller.indexTabTime,
                  fromDayInput: controller.fromDay.value,
                  toDayInput: controller.toDay.value,
                  initChoose: controller.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    controller.fromDay.value = fromDate;
                    controller.toDay.value = toDay;

                    controller.indexTabTime = indexTab ?? 0;
                    controller.indexChooseTime = indexChoose ?? 0;
                  },
                ))!
            .then((value) => {
                  controller.getAllCollaborator(isRefresh: true),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(controller.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(controller.toDay.value))
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
                                  "${SahaDateUtils().getDDMMYY(controller.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  SahaDateUtils().getDDMMYY(controller.toDay.value)),
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
                                  "${SahaDateUtils().getDDMMYY(controller.fromDay.value)} "),
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