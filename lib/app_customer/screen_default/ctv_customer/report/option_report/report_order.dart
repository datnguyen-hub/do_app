import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../agency_customer/report/widget/item_report_order.dart';
import '../report_controller.dart';

// ignore: must_be_immutable
class ReportOrder extends StatelessWidget {
  ReportController reportController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              reportController.openAndCloseOrderDetail();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      "assets/icons/check_list.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    " Hoá đơn: ",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Chi tiết",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Obx(
            () => AnimatedContainer(
              height: reportController.isOpenOrderDetail.value ? 240 : 0,
              duration: Duration(milliseconds: 300),
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      ItemReportOrder(
                        text: "Chờ xử lí: ",
                        totalOrder: reportController
                            .orderWaitingProcess.value.totalOrderCount!
                            .toInt(),
                        totalPrice: reportController
                            .orderWaitingProcess.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Đang giao hàng: ",
                        totalOrder: reportController
                            .orderShipping.value.totalOrderCount!
                            .toInt(),
                        totalPrice:
                            reportController.orderShipping.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Đã hoàn thành: ",
                        totalOrder: reportController
                            .orderCompleted.value.totalOrderCount!
                            .toInt(),
                        totalPrice:
                            reportController.orderCompleted.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Khách huỷ: ",
                        totalOrder: reportController
                            .orderCustomerCancel.value.totalOrderCount!
                            .toInt(),
                        totalPrice: reportController
                            .orderCustomerCancel.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Shop huỷ: ",
                        totalOrder: reportController
                            .orderUserCancel.value.totalOrderCount!
                            .toInt(),
                        totalPrice:
                            reportController.orderUserCancel.value.totalFinal!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 3,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
