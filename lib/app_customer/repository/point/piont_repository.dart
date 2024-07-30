import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/point/reward_pionts_ctm_response.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

class PointRepository {
  Future<RewardPointsCtmResponse?> getRewardPointCtm() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getRewardPointCtm(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
