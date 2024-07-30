import 'package:sahashop_customer/app_customer/remote/response-request/login/exists_response.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/login/login_response.dart';
import '../../repository/handle_error.dart';

class LoginCustomerRepository {
  Future<LoginResponse?> loginAccount(
    String emailOrPhoneNumber,
    String password,
  ) async {
    try {
      
      var res = await CustomerServiceManager()
          .service!
          .loginAccount(StoreInfo().getCustomerStoreCode(), {
        "email_or_phone_number": emailOrPhoneNumber,
        "password": password,
      });
      return res;
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<bool?> resetPassword(
      {String? emailOrPhoneNumber,
      String? pass,
      String? otp,
      String? otpFrom}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .resetPassword(StoreInfo().getCustomerStoreCode(), {
        "email_or_phone_number": emailOrPhoneNumber,
        "password": pass,
        "otp": otp,
        "otp_from": otpFrom,
      });
      return true;
    } catch (err) {
      handleErrorCustomer(err);
      return false;
    }
  }

  Future<bool?> changePassword({String? newPass, String? oldPass}) async {
    try {
      var res = await CustomerServiceManager().service!.changePassword(
          StoreInfo().getCustomerStoreCode(),
          {"old_password": oldPass, "new_password": newPass});
      return true;
    } catch (err) {
      handleErrorCustomer(err);
      return false;
    }
  }

  Future<List<ExistsLogin>?> checkExists(
      {String? email, String? phoneNumber}) async {
    try {
      var res = await CustomerServiceManager().service!.checkExists(
          StoreInfo().getCustomerStoreCode(),
          {"email": email, "phone_number": phoneNumber});
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
