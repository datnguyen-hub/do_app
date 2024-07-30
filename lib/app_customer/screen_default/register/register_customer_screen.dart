import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components//button/saha_button.dart';
import '../../components//loading/loading_full_screen.dart';
import '../../utils/customer_info.dart';
import '../../utils/phone_number.dart';
import 'otp/choose_method_validate.dart';
import 'otp/otp_screen.dart';
import 'register_controller.dart';
import 'widget/text_field_customer_auth.dart';

class RegisterCustomerScreen extends StatefulWidget {
  bool? isOneBack;

  late RegisterController registerController;
  RegisterCustomerScreen({
    this.isOneBack,
  }) {
    registerController = Get.put(RegisterController());
  }
  @override
  _RegisterCustomerScreenState createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  String? phoneShop;

  @override
  void initState() {
    widget.registerController.isOneBack = widget.isOneBack;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Obx(
        () => Container(
          width: Get.width,
          height: Get.height - AppBar().preferredSize.height - 100,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFieldCustomerAuth(
                          textEditingController: widget
                              .registerController.textEditingControllerName,
                          label: "Tên đầy đủ",
                          autoFocus: true,
                          icon: Icon(
                            Icons.account_box,
                            color: Colors.grey,
                          ),
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Tên không được để trống';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        TextFieldCustomerAuth(
                          textEditingController: widget
                              .registerController.textEditingControllerPhone,
                          label: "Số điện thoại",
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          icon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          validator: (value) {
                            if (value!.length != 10) {
                              return 'Số điện thoại không hợp lệ';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        TextFieldCustomerAuth(
                          textEditingController: widget
                              .registerController.textEditingControllerEmail,
                          icon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.length > 0) {
                              if (!GetUtils.isEmail(value)) {
                                return 'Email không hợp lệ';
                              }
                            }
                            return null;
                          },
                          label: "Email (không bắt buộc)",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        TextFieldCustomerAuth(
                          textEditingController: widget
                              .registerController.textEditingControllerPass,
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Mật khẩu phải hơn 6 kí tự';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          label: "Mật khẩu",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey[200],
                        ),
                        //if(CustomerInfo().getPhoneNumberIntroduce() == null ||  CustomerInfo().getPhoneNumberIntroduce() == "")
                        TextFieldCustomerAuth(
                          enabled:  (CustomerInfo().getPhoneNumberIntroduce() == null ||  CustomerInfo().getPhoneNumberIntroduce() == "") ? true :false,
                          textEditingController: widget.registerController
                              .textEditingControllerIntroduce,
                          validator: (value) {
                            if (value!.length >= 1) {
                              return PhoneNumberValid.validateMobileIntroduce(
                                  value);
                            }
                            return null;
                          },
                          icon: Icon(
                            Icons.supervisor_account_sharp,
                            color: Colors.grey,
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          label: "Mã giới thiệu (Phone) hoặc mã nhân viên sale",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: SahaButtonSizeChild(
                            text: "Tiếp tục",
                            width: 200,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.registerController
                                        .textEditingControllerEmail.text ==
                                    "") {
                                  widget.registerController.checkHasPhoneNumber(
                                      noHas: () {
                                    Get.to(() => OtpScreen(
                                          isPhoneValidate: true,
                                        ));
                                  });
                                } else {
                                  widget.registerController.checkHasEmail(
                                      noHas: () {
                                    widget.registerController
                                        .checkHasPhoneNumber(noHas: () {
                                      Get.to(() => ChooseMethodValidate(
                                            title: "CHỌN PHƯƠNG THỨC XÁC THỰC",
                                            phoneNumber: widget
                                                .registerController
                                                .textEditingControllerPhone
                                                .text,
                                            email: widget
                                                .registerController
                                                .textEditingControllerEmail
                                                .text,
                                          ));
                                    });
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 40)
                      ],
                    ),
                  ),
                ),
                widget.registerController.checkingHasEmail.value
                    ? SahaLoadingFullScreen()
                    : Container(),
                widget.registerController.checkingHasPhone.value
                    ? SahaLoadingFullScreen()
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
