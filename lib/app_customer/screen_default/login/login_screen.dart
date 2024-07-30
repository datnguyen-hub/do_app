import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/empty/saha_empty_image.dart';
import '../../config_controller.dart';
import '../../screen_default/login/login_controller.dart';
import '../../screen_default/register/register_customer_screen.dart';
import '../../components//button/saha_button.dart';
import '../../components//toast/saha_alert.dart';
import 'package:get/get.dart';

import '../data_app_controller.dart';
import 'reset_password/reset_password.dart';

class LoginScreenCustomer extends StatelessWidget {
  @override
  CustomerConfigController configController = Get.find();
  LoginController loginController = LoginController();
  DataAppCustomerController dataAppCustomerController = Get.find();
  StreamSubscription? sub;

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Đăng nhập"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width,
                height: 50,
              ),
              CachedNetworkImage(
                height: 100,
                width: 100,
                imageUrl: configController.configApp.logoUrl ?? "",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => SahaEmptyImage(
                  height: 30,
                  width: 30,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            loginController.phoneOrEmailEditingController.value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Email hoặc Số điện thoại",
                        ),
                        style: TextStyle(fontSize: 15),
                        minLines: 1,
                        maxLines: 1,
                        onChanged: (v) {
                          loginController.phoneOrEmailEditingController
                              .refresh();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.lock_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller:
                              loginController.passwordEditingController.value,
                          obscureText: loginController.isHidePassword.value,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Mật khẩu",
                          ),
                          style: TextStyle(fontSize: 15),
                          minLines: 1,
                          maxLines: 1,
                          onChanged: (v) {
                            loginController.passwordEditingController.refresh();
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            loginController.isHidePassword.value =
                                !loginController.isHidePassword.value;
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Obx(() => loginController
                                    .isHidePassword.value
                                ? SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/eyelash.svg")
                                : SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/visible_eye.svg")),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ResetPasswordScreen())!.then((mapData) {
                              if (mapData["success"] != null) {
                                loginController.phoneOrEmailEditingController
                                    .value.text = mapData["emailOrPhoneNumber"];
                                loginController.passwordEditingController.value
                                    .text = mapData["pass"];
                                loginController.phoneOrEmailEditingController
                                    .refresh();
                                loginController.passwordEditingController
                                    .refresh();
                              }
                            });
                          },
                          child: Text(
                            "Quên?",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => loginController.phoneOrEmailEditingController.value.text
                            .isNotEmpty &&
                        loginController
                            .passwordEditingController.value.text.isNotEmpty
                    ? SahaButtonFullParent(
                        text: "Đăng nhập",
                        onPressed: () {
                          loginController.loginAccount(
                              loginController
                                  .phoneOrEmailEditingController.value.text,
                              loginController
                                  .passwordEditingController.value.text);
                          sub ??=
                              loginController.isLoginSuccess.listen((state) {
                            if (state == true) {
                              dataAppCustomerController.checkLogin();
                              Get.back();
                              SahaAlert.showSuccess(
                                  message: "Đăng nhập thành công");
                            }
                          });
                        },
                        color: Theme.of(context).primaryColor,
                      )
                    : IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Đăng nhập",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => RegisterCustomerScreen());
                  },
                  child: Text("Đăng ký"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
