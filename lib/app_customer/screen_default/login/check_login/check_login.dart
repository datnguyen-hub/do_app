import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/login_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../data_app_controller.dart';
import 'package:get/get.dart';

class CheckCustomerLogin extends StatelessWidget {
  final Widget child;
  DataAppCustomerController dataAppCustomerController = Get.find();

  CheckCustomerLogin({Key? key, required this.child}) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => dataAppCustomerController.isLogin.value == true
          ? child
          : Scaffold(
              appBar: AppBar(
                title: Text("Đăng nhập"),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "packages/sahashop_customer/assets/icons/password.svg",
                    height: 30,
                    width: 30,
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Bạn cần đăng nhập để sử dụng chức năng này"),
                  SizedBox(
                    height: 50,
                  ),
                  SahaButtonFullParent(
                    text: "Đăng nhập ngay",
                    onPressed: () {
                      Get.to(() => LoginScreenCustomer());
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
    );
  }
}
