import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/text_field/text_field_input_otp.dart';

import '../register_controller.dart';

class OtpScreen extends StatelessWidget {
  final formKey3 = GlobalKey<FormState>();
  RegisterController registerController = Get.find();
  final bool isPhoneValidate;

  OtpScreen({required this.isPhoneValidate});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Đăng ký"),
      ),
      body: Form(
        key: formKey3,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFieldInputOtp(
                  numberPhone:
                      registerController.textEditingControllerPhone.text,
                  email: registerController.textEditingControllerEmail.text,
                  isCustomer: true,
                  isPhoneValidate: isPhoneValidate,
                  onChanged: (va) {
                    registerController.otp = va;
                  },
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (formKey3.currentState!.validate()) {
                        registerController.onSignUp(isPhoneValidate: isPhoneValidate);
                      }
                    },
                  ),
                ),
              ],
            ),
            registerController.signUpping.value
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: SahaLoadingWidget(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
