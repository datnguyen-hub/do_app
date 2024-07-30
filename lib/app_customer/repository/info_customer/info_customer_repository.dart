import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/info_customer/info_customer_response.dart';
import '../../repository/handle_error.dart';
import '../../model/info_customer.dart';

class InfoCustomerRepository {
  Future<InfoCustomerResponse?> getInfoCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getInfoCustomer(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<InfoCustomerResponse?> updateAccountCustomer(
      InfoCustomer infoCustomer) async {
    try {
      var res = await CustomerServiceManager().service!.updateAccount(
          StoreInfo().getCustomerStoreCode(), infoCustomer.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<InfoCustomerResponse?> updateReferralPhoneNumber(
      String referralPhoneNumber) async {
    try {
      var res = await CustomerServiceManager().service!.updateReferralPhoneNumber(
          StoreInfo().getCustomerStoreCode(),
          {"referral_phone_number": referralPhoneNumber});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
