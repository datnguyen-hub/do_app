import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../handle_error.dart';

class OtpRepository {
  Future<bool?> sendOtp({String numberPhone = ""}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .sendOtp({"phone_number": numberPhone});
      return true;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<bool?> sendEmailOtpCus({String email = ""}) async {
    try {
      var res = await CustomerServiceManager().service!.sendEmailOtpCus(
          StoreInfo().getCustomerStoreCode(), {"email": email});
      return true;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<bool?> sendEmailOtp({String email = ""}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .sendOtpEmail({"email": email});
      return true;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
