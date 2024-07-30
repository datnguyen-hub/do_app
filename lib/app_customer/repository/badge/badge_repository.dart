import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/badge/badge_response.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/response-request/success/success_response.dart';
import '../handle_error.dart';

class BadgeRepository {
  Future<BadgeResponse?> getBadge() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getBadge(StoreInfo().getCustomerStoreCode()!);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> handleDynamicLink({required int id}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .handleDynamicLink(StoreInfo().getCustomerStoreCode()!, id);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
