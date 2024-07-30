import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/const/const_type_message.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/notification_history/all_notification_response.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/category_post_screen/category_post_screen_1.dart';
import 'package:sahashop_customer/app_customer/screen_default/chat_customer_screen/chat_user_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/ctv_wallet_screen/ctv_wallet_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/order_history/order_history_detail/order_detail_history_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/order_history/order_history_screen.dart';

class NotificationCusController extends GetxController {
  NotificationCusController() {
    historyNotification();
  }

  var listNotificationCus = RxList<NotificationCus>();
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;

  Future<void> readAllNotification({bool? isRefresh}) async {
    try {
      var res = await CustomerRepositoryManager.notificationCusRepository
          .readAllNotification();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> historyNotification({bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listNotificationCus([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var res = await CustomerRepositoryManager.notificationCusRepository
            .historyNotification(currentPage);

        res!.data!.listNotification!.data!.forEach((e) {
          listNotificationCus.add(e);
        });

        if (res.data!.listNotification!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }
      } else {
        isLoadMore.value = false;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadMore.value = false;
    isLoadRefresh.value = false;
  }

  void navigator(String typeNotification, String orderCode) {
    if (typeNotification == NEW_ORDER) {
      Get.to(() => OrderHistoryScreen())!.then((value) {
        // historyNotification(isRefresh: true);
      });
    }
    if (typeNotification == NEW_MESSAGE) {
      Get.to(() => ChatCustomerScreen())!.then((value) {
        //historyNotification(isRefresh: true);
      });
    }
    if (typeNotification == NEW_POST) {
      Get.to(() => CategoryPostScreen(
                isAutoBackIcon: true,
              ))!
          .then((value) {
        //historyNotification(isRefresh: true);
      });
    }

    if (typeNotification == NEW_PERIODIC_SETTLEMENT) {
      Get.to(() => CtvWalletScreen())!.then((value) {
        //historyNotification(isRefresh: true);
      });
    }

    if (typeNotification.split("-")[0] == ORDER_STATUS) {
      if (typeNotification.split("-")[1] == WAITING_FOR_PROGRESSING) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == PACKING) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == SHIPPING) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }
      if (typeNotification.split("-")[1] == COMPLETED) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == OUT_OF_STOCK) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == USER_CANCELLED) {
        Get.to(() => OrderHistoryScreen(
              initPage: 5,
            ));
      }

      if (typeNotification.split("-")[1] == CUSTOMER_CANCELLED) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == DELIVERY_ERROR) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == CUSTOMER_RETURNING) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }

      if (typeNotification.split("-")[1] == CUSTOMER_HAS_RETURNS) {
        Get.to(() => OrderHistoryDetailScreen(
              orderCode: orderCode,
            ));
      }
    }

    if (typeNotification == CUSTOMER_PAID) {
      Get.to(() => OrderHistoryScreen())!.then((value) {
        // historyNotification(isRefresh: true);
      });
    }

    if (typeNotification == SEND_ALL) {}
    if (typeNotification == TO_ADMIN) {}
  }
}
