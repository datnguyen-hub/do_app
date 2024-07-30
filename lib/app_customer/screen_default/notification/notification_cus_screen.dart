import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_noti.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/const/const_type_message.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/notification_history/all_notification_response.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';

import 'notification_cus_controller.dart';

class NotificationCusScreen extends StatelessWidget {
  NotificationCusController notificationController =
      NotificationCusController();
  RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        notificationController.readAllNotification();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông báo"),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: CustomFooter(
            loadStyle: LoadStyle.ShowAlways,
            builder: (context, mode) {
              if (mode == LoadStatus.loading) {
                return Container(
                  height: 60.0,
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else
                return Container();
            },
          ),
          header: MaterialClassicHeader(),
          controller: _refreshController,
          onRefresh: () async {
            await notificationController.historyNotification(isRefresh: true);
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            await notificationController.historyNotification();
            _refreshController.loadComplete();
          },
          child: Obx(
            () => notificationController.isLoadRefresh.value == true
                ? SahaLoadingFullScreen()
                : notificationController.listNotificationCus.isEmpty
                    ? Center(
                        child: SahaEmptyNoti(
                          width: 50,
                          height: 50,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: notificationController.listNotificationCus
                              .map((element) => boxNotification(element))
                              .toList(),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget boxNotification(NotificationCus notificationCus) {
    return InkWell(
      onTap: () {
        notificationController.navigator(
            notificationCus.type ?? "", notificationCus.referencesValue ?? "");
        var index =
            notificationController.listNotificationCus.indexOf(notificationCus);
        notificationController.listNotificationCus[index].unread = false;
        notificationController.listNotificationCus.refresh();
      },
      child: Container(
        color: notificationCus.unread == true
            ? SahaColorUtils()
                .colorPrimaryTextWithWhiteBackground()
                .withOpacity(0.05)
            : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon(notificationCus),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationCus.title ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          notificationCus.content ?? "",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          SahaDateUtils().getDDMMYY3(
                              notificationCus.createdAt ?? DateTime.now()),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(NotificationCus notificationCus) {
    if (notificationCus.type == NEW_MESSAGE)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/chat2.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type == NEW_POST)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/newspaper.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type == NEW_PERIODIC_SETTLEMENT)
      SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/audit.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type!.split("-")[0] == ORDER_STATUS)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/tracking.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type == CUSTOMER_CANCELLED_ORDER)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/cancel.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type == CUSTOMER_PAID)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/debit_card.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type == SEND_ALL)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/all.svg',
        height: 45,
        width: 45,
      );
    if (notificationCus.type == TO_ADMIN)
      return SvgPicture.asset(
        'packages/sahashop_customer/assets/icons/admin.svg',
        height: 45,
        width: 45,
      );

    return Icon(
      Icons.circle,
      color: Colors.blue,
      size: 10,
    );
  }
}
