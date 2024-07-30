import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ResetPasswordController extends GetxController {
  var resting = false.obs;
  var newPassInputting = false.obs;
  var checkingHasPhone = false.obs;
  var checkingHasEmail = false.obs;
  var otp = "";

  TextEditingController textEditingControllerEmailOrNumberPhone =
      new TextEditingController();
  TextEditingController textEditingControllerNewPass =
      new TextEditingController();

  Future<void> onReset({required bool isPhoneValidate}) async {
    resting.value = true;
    try {
      var loginData = (await CustomerRepositoryManager.loginCustomerRepository
          .resetPassword(
        emailOrPhoneNumber: textEditingControllerEmailOrNumberPhone.text,
        pass: textEditingControllerNewPass.text,
        otp: otp,
        otpFrom: isPhoneValidate == true ? "phone" : "email",
      ))!;

      SahaAlert.showSuccess(
          message: "Lấy lại mật khẩu thành công, vui lòng đăng nhập lại");
      Get.back(result: {
        "success": true,
        "emailOrPhoneNumber": textEditingControllerEmailOrNumberPhone.text,
        "pass": textEditingControllerNewPass.text
      });
      resting.value = false;
    } catch (err) {
      resting.value = false;
      SahaAlert.showError(message: err.toString());
    }
    resting.value = false;
  }

  Future<void> checkHasPhoneNumber({Function? onHas, Function? noHas}) async {
    checkingHasPhone.value = true;
    try {
      var data =
          await CustomerRepositoryManager.loginCustomerRepository.checkExists(
        phoneNumber: textEditingControllerEmailOrNumberPhone.text,
      );

      for (var e in data!) {
        if (e.name == "phone_number" && e.value == true) {
          if (onHas != null) onHas();
          checkingHasPhone.value = false;
          return;
        }
      }
      SahaAlert.showError(message: "Số điện thoại không tồn tại");
      if (noHas != null) noHas();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    checkingHasPhone.value = false;
  }

  Future<void> checkHasEmail({Function? onHas, Function? noHas}) async {
    checkingHasEmail.value = true;
    try {
      var data =
          await CustomerRepositoryManager.loginCustomerRepository.checkExists(
        email: textEditingControllerEmailOrNumberPhone.text,
      );

      for (var e in data!) {
        if (e.name == "email" && e.value == true) {
          if (onHas != null) onHas();
          checkingHasEmail.value = false;
          return;
        }
      }
      SahaAlert.showError(message: "Email không tồn tại");
      if (noHas != null) noHas();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    checkingHasEmail.value = false;
  }
}
