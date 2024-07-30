import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/text_field/text_field_input_otp.dart';
import 'package:sahashop_customer/app_customer/screen_default/register/widget/text_field_customer_auth.dart';
import 'package:sahashop_customer/app_customer/utils/phone_number.dart';
import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<ResetPasswordScreen> {
  ResetPasswordController resetPasswordController = ResetPasswordController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (resetPasswordController.newPassInputting.value == true) {
        return buildNewPasswordInputScreen();
      }
      return buildNumInputScreen();
    });
  }

  Widget buildNumInputScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFieldCustomerAuth(
                      textEditingController: resetPasswordController
                          .textEditingControllerEmailOrNumberPhone,
                      autoFocus: true,
                      validator: (value) {
                        if (value!.length < 1) {
                          return 'Bạn chưa nhập Email hoặc số điện thoại';
                        } else {
                          if (GetUtils.isEmail(value)) {
                            return null;
                          } else {
                            return PhoneNumberValid.validateMobile(value);
                          }
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      label: "Nhập Email hoặc Số điện thoại",
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SahaButtonSizeChild(
                        width: 200,
                        text: "Tiếp tục",
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (GetUtils.isEmail(resetPasswordController
                                .textEditingControllerEmailOrNumberPhone
                                .text)) {
                              resetPasswordController.checkHasEmail(onHas: () {
                                resetPasswordController.newPassInputting.value =
                                    true;
                              });
                            } else {
                              resetPasswordController.checkHasPhoneNumber(
                                  onHas: () {
                                resetPasswordController.newPassInputting.value =
                                    true;
                              });
                            }
                          }
                        }),
                    Spacer(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            resetPasswordController.resting.value ||
                    resetPasswordController.checkingHasPhone.value
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    child: SahaLoadingWidget(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget buildNewPasswordInputScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            resetPasswordController.newPassInputting.value = false;
          },
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  child: Center(
                    child: Text(
                        "Nhập mã OTP và nhập mật khẩu mới để lấy lại mật khẩu"),
                  ),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  padding: EdgeInsets.all(20),
                ),
                TextFieldInputOtp(
                  numberPhone: resetPasswordController
                      .textEditingControllerEmailOrNumberPhone.text,
                  email: resetPasswordController
                      .textEditingControllerEmailOrNumberPhone.text,
                  isPhoneValidate: GetUtils.isEmail(resetPasswordController
                              .textEditingControllerEmailOrNumberPhone.text) ==
                          true
                      ? false
                      : true,
                  isCustomer: true,
                  autoFocus: true,
                  onChanged: (va) {
                    resetPasswordController.otp = va;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldCustomerAuth(
                    textEditingController:
                        resetPasswordController.textEditingControllerNewPass,
                    autoFocus: true,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Mật khẩu mới phải lớn hơn 6 ký tự';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    label: "Nhập mật khẩu mới",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SahaButtonSizeChild(
                    width: 200,
                    color: Theme.of(context).primaryColor,
                    text: "Tiếp tục",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScope.of(context).requestFocus(FocusNode());
                        resetPasswordController.onReset(
                          isPhoneValidate: GetUtils.isEmail(
                                      resetPasswordController
                                          .textEditingControllerEmailOrNumberPhone
                                          .text) ==
                                  true
                              ? false
                              : true,
                        );
                      }
                    }),
                Spacer(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Obx(() {
            return resetPasswordController.resting.value
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    child: SahaLoadingWidget(),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
