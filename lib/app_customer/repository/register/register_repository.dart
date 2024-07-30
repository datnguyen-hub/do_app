import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/register/register_response.dart';
import '../../repository/handle_error.dart';

class RegisterCustomerRepository {
  Future<RegisterResponse?> registerAccount({
    String? phone,
    String? password,
    String? email,
    String? name,
    String? otp,
    String? otpFrom,
    String? codeIntroduce,
  }) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .registerAccount(StoreInfo().getCustomerStoreCode(), {
        "phone_number": phone,
        "password": password,
        "name": name,
        "email": email,
        "otp": otp,
        "otp_from": otpFrom,
        "referral_phone_number": codeIntroduce,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
