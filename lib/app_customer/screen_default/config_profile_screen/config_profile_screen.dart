import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import '../../components/dialog/dialog.dart';
import '../../components/loading/loading_container.dart';
import '../../screen_default/config_profile_screen/config_profile_controller.dart';
import '../../model/info_customer.dart';
import '../../utils/customer_info.dart';
import '../../utils/date_utils.dart';

import 'change_password/change_password.dart';

// ignore: must_be_immutable
class ConfigProfileScreen extends StatelessWidget {
  InfoCustomer? infoCustomer;

  ConfigProfileScreen({this.infoCustomer}) {
    configProfileController =
        ConfigProfileController(infoCustomer2: infoCustomer);
  }
  late ConfigProfileController configProfileController;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sửa hồ sơ"),
          actions: [
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  configProfileController.updateProfileCustomer();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Lưu",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      InkWell(
                        onTap: () {
                          configProfileController.loadAssets();
                        },
                        child: Container(
                          height: 200,
                          width: Get.width,
                          child: Opacity(
                            opacity: 0.8,
                            child: CachedNetworkImage(
                              height: 70,
                              width: 70,
                              imageUrl:
                                  configProfileController.linkAvatar.value,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  SahaLoadingContainer(),
                              errorWidget: (context, url, error) =>
                                  SahaEmptyImage(),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        child: InkWell(
                          onTap: () {
                            configProfileController.loadAssets();
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        Theme.of(Get.context!).primaryColor)),
                            padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    configProfileController.linkAvatar.value,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    SahaLoadingContainer(),
                                errorWidget: (context, url, error) =>
                                    SahaEmptyImage(),
                              ),
                              borderRadius: BorderRadius.circular(3000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tên"),
                      Container(
                        width: Get.width * 0.55,
                        child: TextFormField(
                          controller: configProfileController
                              .nameEditingController.value,
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          validator: (v) {
                            if (v!.length <= 0) {
                              return "Chưa nhập tên";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập họ và tên"),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Giới tính"),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffffffff),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xff999999),
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Text('Thoát'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text('Xong'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    color: Color(0xfff7f7f7),
                                    child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (value) {
                                        configProfileController
                                            .onChangeSexPicker(value);
                                      },
                                      children: const [
                                        Text('Khác'),
                                        Text('Nam'),
                                        Text('Nữ'),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(
                                () => Text(
                                  configProfileController.sex.value,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày sinh"),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1950, 1, 1),
                                  maxTime: DateTime(2050, 1, 1),
                                  // theme: DatePickerTheme(
                                  //     headerColor: Colors.white,
                                  //     backgroundColor: Colors.white,
                                  //     itemStyle: TextStyle(
                                  //         color: Colors.black,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 18),
                                  //     doneStyle: TextStyle(
                                  //         color: Colors.black, fontSize: 16)),
                                  onChanged: (date) {}, onConfirm: (date) {
                                configProfileController.birthDate.value = date;
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi);
                            },
                            child: Obx(
                              () => Text(
                                 SahaDateUtils().isSameDate(DateTime.now(),configProfileController.birthDate.value ) == true ? "Chưa có ngày sinh" : '${SahaDateUtils().getDDMMYY(configProfileController.birthDate.value)}',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Điện thoại"),
                          Container(
                            width: Get.width * 0.55,
                            child: TextField(
                              controller: configProfileController
                                  .phoneEditingController.value,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Nhập số điện thoại"),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                        child: InkWell(
                            onTap: () {
                              SahaAlert.showError(
                                  message:
                                      "Không thể thay đổi số điện thoại và email");
                            },
                            child: Container(
                              color: Colors.grey.withOpacity(0.1),
                            )))
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email"),
                          Container(
                            width: Get.width * 0.55,
                            child: TextField(
                              controller: configProfileController
                                  .emailEditingController.value,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Nhập email"),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                        child: InkWell(
                            onTap: () {
                              SahaAlert.showError(
                                  message:
                                      "Không thể thay đổi số điện thoại và email");
                            },
                            child: Container(
                              color: Colors.grey.withOpacity(0.1),
                            )))
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogInput(
                          title: "Số điện thoại người giới thiệu",
                          onInput: (b) {
                            configProfileController
                                .updateReferralPhoneNumber(b);
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Số điện thoại người giới thiệu"),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                SahaDialogApp.showDialogInput(
                                    title: "Số điện thoại người giới thiệu",
                                    onInput: (b) {
                                      configProfileController
                                          .updateReferralPhoneNumber(b);
                                    });
                              },
                              child: Obx(
                                () => Text(configProfileController.infoCustomer
                                        .value.referralPhoneNumber ??
                                    ""),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.to(ChangePassword());
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thay đổi mật khẩu"),
                        Container(
                            height: 13,
                            width: 13,
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/right_arrow.svg",
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(
                      mess:
                          "Tài khoản của bạn sẽ được xoá sau khoảng thời gian 1 ngày, trong thời gian này bạn có thể huỷ kích hoạt xoá tài khoản bằng cách đăng nhập lại!",
                      onOK: () {
                        CustomerInfo().logout();
                      });
                },
                child: Text(
                  "Yêu cầu xoá tài khoản",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey[500]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
