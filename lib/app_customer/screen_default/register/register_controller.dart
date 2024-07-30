import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import '../../components//toast/saha_alert.dart';
import '../../load_data/load_firebase.dart';
import '../../utils/customer_info.dart';

class RegisterController extends GetxController {
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;

  var phoneInputtingOtp = false.obs;

  var checkingHasEmail = false.obs;
  var checkingHasPhone = false.obs;
  var checkRebuild = 1;
  var otp = "";
  RegisterController() {
    textEditingControllerIntroduce.text =
        CustomerInfo().getPhoneNumberIntroduce() ?? '';
  }

  bool? isOneBack;

  TextEditingController textEditingControllerPhone =
      new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerName = new TextEditingController();
  TextEditingController textEditingControllerIntroduce =
      new TextEditingController();

  Future<void> onSignUp({required bool isPhoneValidate}) async {
    signUpping.value = true;
    try {
      var dataRegister = await CustomerRepositoryManager
          .registerCustomerRepository
          .registerAccount(
        phone: textEditingControllerPhone.text,
        password: textEditingControllerPass.text,
        name: textEditingControllerName.text,
        email: textEditingControllerEmail.text,
        otp: otp,
        otpFrom: isPhoneValidate == true ? "phone" : "email",
        codeIntroduce: textEditingControllerIntroduce.text == ""
            ? null
            : textEditingControllerIntroduce.text,
      );
      SahaAlert.showSuccess(message: "Đăng ký thành công, đang đăng nhập");
      await loginAccount();
      Get.back();
      Get.back();
      if (isOneBack != true) {
        Get.back();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    signUpping.value = false;
  }

  Future<void> loginAccount() async {
    try {
      var res =
          await CustomerRepositoryManager.loginCustomerRepository.loginAccount(
        textEditingControllerPhone.text,
        textEditingControllerPass.text,
      );
      await CustomerInfo().setToken(res!.data!.token);
      updateDeviceToken();
      Get.find<DataAppCustomerController>().isLogin.value = true;
      Get.find<DataAppCustomerController>().getBadge();
      Get.find<DataAppCustomerController>().getInfoCustomer();
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

  Future<void> checkHasEmail({Function? onHas, Function? noHas}) async {
    checkingHasEmail.value = true;
    try {
      var data =
          await CustomerRepositoryManager.loginCustomerRepository.checkExists(
        email: textEditingControllerEmail.text,
      );

      for (var e in data!) {
        if (e.name == "email" && e.value == true) {
          SahaAlert.showError(message: "Email đã tồn tại");
          if (onHas != null) onHas();
          checkingHasEmail.value = false;
          return;
        }
      }

      if (noHas != null) noHas();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    checkingHasEmail.value = false;
  }

  Future<void> checkHasPhoneNumber({Function? onHas, Function? noHas}) async {
    checkingHasPhone.value = true;
    try {
      var data =
          await CustomerRepositoryManager.loginCustomerRepository.checkExists(
        phoneNumber: textEditingControllerPhone.text,
      );

      for (var e in data!) {
        if (e.name == "phone_number" && e.value == true) {
          SahaAlert.showError(message: "Số điện thoại đã tồn tại");
          if (onHas != null) onHas();
          checkingHasPhone.value = false;
          return;
        }
      }

      if (noHas != null) noHas();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    checkingHasPhone.value = false;
  }
}
