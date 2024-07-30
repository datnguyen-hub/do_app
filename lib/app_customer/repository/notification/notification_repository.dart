import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/notification_history/all_notification_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/success/success_response.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

class NotificationCusRepository {
  Future<AllNotificationCusResponse?> historyNotification(int page) async {
    try {
      var res = await CustomerServiceManager().service!.historyNotification(StoreInfo().getCustomerStoreCode(), page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> readAllNotification() async {
    try {
      var res = await CustomerServiceManager().service!.readAllNotification(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

}