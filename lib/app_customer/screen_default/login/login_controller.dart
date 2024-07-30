import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/load_data/load_firebase.dart';
import '../../repository/repository_customer.dart';
import '../../screen_default/data_app_controller.dart';
import '../../components//toast/saha_alert.dart';
import '../../utils/customer_info.dart';

class LoginController extends GetxController {
  var isHidePassword = true.obs;
  var phoneOrEmailEditingController = new TextEditingController().obs;
  var passwordEditingController = new TextEditingController().obs;
  var isLoginSuccess = false.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  Future<void> loginAccount(String emailOrPhoneNumber, String password) async {
    try {
      var res = await CustomerRepositoryManager.loginCustomerRepository
          .loginAccount(emailOrPhoneNumber, password);
      await CustomerInfo().setToken(res!.data!.token);
      isLoginSuccess.value = true;
      updateDeviceToken();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateDeviceToken() async {
    try {
      var token = FCMToken().getToken();
      if (token != null) {
        var res = await CustomerRepositoryManager.deviceTokenRepository
            .updateDeviceTokenCustomer(token);
      }
    } catch (err) {
      print("Loi update token");
    }
  }
}
