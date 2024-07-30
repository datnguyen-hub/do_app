import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/score/check_in_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/score/history_score_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/score/roll_call_response.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/response-request/community/all_customer_friend_res.dart';
import '../handle_error.dart';

class ScoreRepository {
  Future<RollCallsResponse?> getRollCall() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getRollCall(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CheckInResponse?> checkIn() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .checkIn(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<HistoryScoreResponse?> getScoreHistory({required int page}) async {
    try {
      var res = await CustomerServiceManager().service!.getScoreHistory(
            page,
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllCustomerFriendRes?> getAllReferral({required int page}) async {
    try {
      var res = await CustomerServiceManager().service!.getAllReferral(
            page,
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
