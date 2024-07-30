import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/text_field/sahashopTextField.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';


import 'change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ChangePasswordController changePasswordController =
      new ChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thay đổi mật khẩu"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SahaTextField(
              controller: changePasswordController.textEditingControllerOldPass,
              onChanged: (value) {},
              autoFocus: true,
              validator: (value) {
                if(value!.length <= 0) {
                  return "Chưa nhập mật khẩu";
                }
                return null;
              },
              maxLine: 1,
              textInputType: TextInputType.emailAddress,
              obscureText: true,
              withAsterisk: true,
              labelText: "Mật khẩu cũ",
              hintText: "Nhập mật khẩu cũ",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SahaTextField(
              controller: changePasswordController.textEditingControllerNewPass,
              onChanged: (value) {},
              autoFocus: true,
              maxLine: 1,
              validator: (value) {
                if (value!.length < 6) {
                  return 'Mật khẩu mới phải lớn hơn 6 ký tự';
                }
                return null;
              },
              textInputType: TextInputType.emailAddress,
              obscureText: true,
              withAsterisk: true,
              labelText: "Mật khẩu mới",
              hintText: "Nhập mật khẩu mới",
            ),

            SahaButtonSizeChild(
                width: 200,
                text: "Thay đổi",
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),

                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FocusScope.of(context).requestFocus(FocusNode());
                    changePasswordController.onChange();
                  }
                }),
            Spacer(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
