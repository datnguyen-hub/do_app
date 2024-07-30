import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/text_field/info_input_text_field.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';


import 'config_payment_ctv_controller.dart';
import 'widget/select_image_cmnd.dart';

class ConfigPaymentAgencyScreen extends StatelessWidget {
  ConfigPaymentAgencyController configPaymentAgencyController =
      ConfigPaymentAgencyController();

  late List<Widget> itemWidget;

  @override
  Widget build(BuildContext context) {
    itemWidget = [
      cmndForm(),
      stkWidget(),
    ];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              Text(
                "THÔNG TIN THANH TOÁN",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                height: 1,
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    boxTab(
                        index: 0,
                        title: "Chứng minh nhân dân",
                        onTap: () {
                          configPaymentAgencyController.indexWidget(0);
                        }),
                    Spacer(),
                    boxTab(
                        index: 1,
                        title: "Tài khoản ngân hàng",
                        onTap: () {
                          configPaymentAgencyController.indexWidget(1);
                        }),
                  ],
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              Obx(() =>
                  itemWidget[configPaymentAgencyController.indexWidget.value]),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "LƯU THÔNG TIN",
                onPressed: () {
                  configPaymentAgencyController.checkInfoPayment();
                },
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget boxTab(
      {required int index, required String title, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap()!;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  color: configPaymentAgencyController.indexWidget.value == index
                      ? SahaColorUtils().colorPrimaryTextWithWhiteBackground()
                      : Colors.grey[500]),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Obx(
            () => configPaymentAgencyController.indexWidget.value == index
                ? Container(
                    height: 3,
                    width: 40,
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget stkWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tự động gửi yêu cầu quyết toán"),
                    Obx(
                      () => CupertinoSwitch(
                        value: configPaymentAgencyController.isPaymentAuto.value,
                        onChanged: (bool value) {
                          configPaymentAgencyController.isPaymentAuto.value =
                              !configPaymentAgencyController.isPaymentAuto.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              )
            ],
          ),
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.bankTextEditingController,
          title: "Ngân hàng",
          hintText: "Nhập Ngân hàng của tài khoản",
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.childBankTextEditingController,
          title: "Chi nhánh",
          hintText: "Nhập Chi nhánh",
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.nameOwnTextEditingController,
          title: "Tên chủ tài khoản",
          hintText: "Nhập Tên chủ tài khoản",
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.stkTextEditingController,
          keyboardType: TextInputType.number,
          title: "Số tài khoản",
          hintText: "Nhập Số tài khoản",
        ),
      ],
    );
  }

  Widget cmndForm() {
    return Column(
      children: [
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.nameTextEditingController,
          title: "Họ & Tên",
          hintText: "Nhập Họ & Tên",
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.cmndTextEditingController,
          keyboardType: TextInputType.number,
          title: "Số CMND",
          hintText: "Nhập Số CMND",
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.dateRangeTextEditingController,
          title: "Ngày cấp",
          hintText: "Nhập Ngày cấp",
          icon: Icon(Icons.calendar_today_sharp),
          onTap: () {
            DatePicker.showDatePicker(Get.context!,
                showTitleActions: true,
                minTime: DateTime(1999, 1, 1),
                maxTime: DateTime(2050, 1, 1),
                // theme: DatePickerTheme(
                //     headerColor: Colors.white,
                //     backgroundColor: Colors.white,
                //     itemStyle: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 18),
                //     doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                onConfirm: (date) {
              configPaymentAgencyController.dateRange = date;
              configPaymentAgencyController.dateRangeTextEditingController.text =
                  DateFormat('dd-MM-yyyy').format(date);
            }, currentTime: DateTime.now(), locale: LocaleType.vi);
          },
        ),
        InfoInputTextField(
          textEditingController:
              configPaymentAgencyController.issuedByTextEditingController,
          title: "Nơi cấp",
          hintText: "Nhập Nơi cấp",
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Ảnh CMND 2 mặt"),
        ),
        Row(
          children: [
            Container(
              height: 150,
              width: Get.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => SelectCmndImage(
                      linkLogo: "${configPaymentAgencyController.frontCard.value}",
                      onChange: (link) {
                        configPaymentAgencyController.frontCard.value = link;
                      },
                    ),
                  ),
                  Text("Mặt trước")
                ],
              ),
            ),
            Container(
              height: 150,
              width: Get.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => SelectCmndImage(
                      linkLogo: "${configPaymentAgencyController.backCard.value}",
                      onChange: (link) {
                        configPaymentAgencyController.backCard.value = link;
                      },
                    ),
                  ),
                  Text("Mặt sau")
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
