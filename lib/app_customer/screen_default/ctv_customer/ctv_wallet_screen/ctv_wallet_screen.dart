import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/step_bonus.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/config_payment_ctv_screen/config_payment_ctv_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/list_product_rose/list_product_rose_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/order_history/order_history_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/payment_history/payment_history_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/report/report_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/report_rose/report_rose_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../ctv_introduce/ctv_introduce_screen.dart';
import '../register_ctv_screen.dart';
import 'ctv_wallet_controller.dart';
import 'widget/card_function.dart';

class CtvWalletScreen extends StatelessWidget {
  var height = AppBar().preferredSize.height;

  late List<Widget> itemWidget;

  CtvWalletController ctvWalletController = Get.put(CtvWalletController());
  DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  Widget build(BuildContext context) {
    itemWidget = [
      infomationWallet(),
      payment(),
      historyTransaction(),
    ];
    return CheckCustomerLogin(
      child: RegisterCtvScreen(
        child: Scaffold(
          body: Obx(() {
            if (dataAppCustomerController.badge.value.statusCollaborator == 0 &&
                dataAppCustomerController.infoCustomer.value.isCollaborator ==
                    true) {
              return Center(
                child: Container(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Cộng tác viên",
                            style: TextStyle(fontSize: 19),
                          )
                        ],
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Chức năng CTV của bạn chưa được phê duyệt!\nHãy liên hệ với chủ shop để được giải quyết",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.7),
                            Theme.of(context).primaryColor.withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.repeated),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width,
                              height: height + 10,
                            ),
                            Text(
                              "Ví CTV",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            Text("số dư"),
                            Obx(
                              () => Text(
                                "${SahaStringUtils().convertToMoney(ctvWalletController.generalInfoPaymentCtv.value.balance ?? 0)} ₫",
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                            if ((ctvWalletController.generalInfoPaymentCtv.value
                                        .moneyPaymentRequest ??
                                    0) !=
                                0)
                              Obx(
                                () => Text(
                                  "Đóng băng: ${SahaStringUtils().convertToMoney(ctvWalletController.generalInfoPaymentCtv.value.moneyPaymentRequest ?? 0)} ₫",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                          ],
                        ),
                        Positioned(
                          left: 10,
                          top: height,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Obx(
                          () => ctvWalletController.generalInfoPaymentCtv.value
                                      .hasPaymentRequest ==
                                  true
                              ? Positioned(
                                  left: 10,
                                  bottom: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100]!.withOpacity(0.2),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 2, bottom: 2),
                                    child: Text(
                                      "Bạn đã gửi yêu cầu thanh toán cho shop, vui lòng chờ xác nhận !",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      boxTab(
                          index: 0,
                          title: "Thông tin ví",
                          onTap: () {
                            ctvWalletController.indexWidget(0);
                          }),
                      Spacer(),
                      boxTab(
                          index: 1,
                          title: "Thanh toán",
                          onTap: () {
                            ctvWalletController.indexWidget(1);
                          }),
                      Spacer(),
                      boxTab(
                          index: 2,
                          title: "Thống kê",
                          onTap: () {
                            ctvWalletController.indexWidget(2);
                          }),
                    ],
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  Expanded(
                    child: Obx(
                      () => SingleChildScrollView(
                          child: itemWidget[
                              ctvWalletController.indexWidget.value]),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  Widget boxTab(
      {required int index, required String title, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: Get.width / 3,
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5,
            ),
            Obx(
              () => Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    color: ctvWalletController.indexWidget.value == index
                        ? SahaColorUtils().colorPrimaryTextWithWhiteBackground()
                        : Colors.grey[500]),
              ),
            ),
            Obx(
              () => ctvWalletController.indexWidget.value == index
                  ? Container(
                      height: 3,
                      width: 40,
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget infomationWallet() {
    return Column(
      children: [
        Obx(
          () => CartFunction(
            title: "Hoa hồng tháng này",
            subText:
                "${ctvWalletController.generalInfoPaymentCtv.value.numberOrder ?? 0} Giao dịch",
            totalMoney:
                "${SahaStringUtils().convertToMoney(ctvWalletController.generalInfoPaymentCtv.value.shareCollaborator ?? 0)}",
            svgAssets: "packages/sahashop_customer/assets/icons/person.svg",
            svgColor: Colors.pink,
            onTap: () {
              Get.to(() => PaymentHistoryScreen());
            },
          ),
        ),
        Obx(
          () => CartFunction(
            title: "Doanh thu tháng này",
            subText:
                "${ctvWalletController.generalInfoPaymentCtv.value.numberOrder ?? 0} Giao dịch",
            totalMoney:
                "${SahaStringUtils().convertToMoney(ctvWalletController.generalInfoPaymentCtv.value.totalFinal ?? 0)}",
            svgAssets: "packages/sahashop_customer/assets/icons/payment.svg",
            svgColor: Colors.green,
            onTap: () {
              Get.to(() => OrderHistoryCtvScreen(
                    initPage: 3,
                    dateFrom: DateTime(DateTime.now().year,DateTime.now().month,1),
                    dateTo: DateTime(DateTime.now().year,DateTime.now().month +1,0),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "packages/sahashop_customer/assets/icons/gift_fill.svg",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "THƯỞNG THEO MỨC DOANH THU",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(height: 1),
              Obx(
                () => Column(
                  children: [
                    ...List.generate(
                      ctvWalletController
                              .generalInfoPaymentCtv.value.stepsBonus?.length ??
                          0,
                      (index) => boxGiftBonus(
                          typeRose: ctvWalletController
                                  .generalInfoPaymentCtv.value.typeRose ??
                              0,
                          svgAsset:
                              "packages/sahashop_customer/assets/icons/point.svg",
                          svgAssetCheck:
                              "packages/sahashop_customer/assets/icons/checked.svg",
                          stepsBonus: ctvWalletController
                              .generalInfoPaymentCtv.value.stepsBonus![index]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget boxGiftBonus({
    required int typeRose,
    required String svgAsset,
    required String svgAssetCheck,
    required StepsBonus stepsBonus,
  }) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
          decoration: BoxDecoration(
              border: Border.all(
                  color: typeRose == 0
                      ? ctvWalletController
                                  .generalInfoPaymentCtv.value.totalFinal! >=
                              stepsBonus.limit!
                          ? Colors.transparent
                          : Colors.amber
                      : ctvWalletController
                                  .generalInfoPaymentCtv.value.balance! >=
                              stepsBonus.limit!
                          ? Colors.transparent
                          : Colors.amber,
                  width: 1.5)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  typeRose == 0
                      ? ctvWalletController
                                  .generalInfoPaymentCtv.value.totalFinal! >=
                              stepsBonus.limit!
                          ? svgAssetCheck
                          : svgAsset
                      : ctvWalletController
                                  .generalInfoPaymentCtv.value.balance! >=
                              stepsBonus.limit!
                          ? svgAssetCheck
                          : svgAsset,
                  height: 25,
                  width: 25,
                ),
              ),
              Text(
                "Đạt: ${SahaStringUtils().convertToMoney(stepsBonus.limit)}₫",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                "Thưởng: ${SahaStringUtils().convertToMoney(stepsBonus.bonus)}₫",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget payment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/wallet.svg",
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "THÔNG TIN THANH TOÁN",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(height: 1),
                Obx(
                  () => ctvWalletController.isFullInfoPayment.value == true
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "CMND/CCCD",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              Row(
                                children: [
                                  Text("Họ và tên:"),
                                  Spacer(),
                                  Text("${ctvWalletController.fullName.value}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Số CMND/CCCD:"),
                                  Spacer(),
                                  Text("${ctvWalletController.cmnd.value}"),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "Tài khoản ngân hàng",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text("${ctvWalletController.bank}"),
                              Text("${ctvWalletController.accountNumber}"),
                            ],
                          ),
                        )
                      : Container(),
                ),
                Obx(
                  () => ctvWalletController.isFullInfoPayment.value == false
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                              "Bạn chưa có thông tin thanh toán.\nVui lòng nhập thông tin để được thanh toán tiền từ ví CTV"),
                        )
                      : Container(),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ConfigPaymentCtvScreen())!.then((value) => {
                          ctvWalletController.getInfoCTV(),
                        });
                  },
                  child: Container(
                    width: Get.width,
                    height: 40,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(Get.context!)
                                .primaryColor
                                .withOpacity(0.7),
                            Theme.of(Get.context!)
                                .primaryColor
                                .withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.repeated),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Obx(() => Text(
                            "${ctvWalletController.isFullInfoPayment.value == false ? "THÊM THÔNG TIN THANH TOÁN" : "SỬA THÔNG TIN THANH TOÁN"}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/wallet.svg",
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "CHÍNH SÁCH THANH TOÁN",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(height: 1),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Tiền từ Ví CTV của thành viên Diamond sẽ được thanh toán định kỳ ${ctvWalletController.generalInfoPaymentCtv.value.payment1OfMonth == true && ctvWalletController.generalInfoPaymentCtv.value.payment16OfMonth == true ? "02/Tháng" : ctvWalletController.generalInfoPaymentCtv.value.payment1OfMonth == true || ctvWalletController.generalInfoPaymentCtv.value.payment16OfMonth == true ? "01/Tháng" : ""}",
                          ),
                        ),
                        if (ctvWalletController
                                .generalInfoPaymentCtv.value.payment16OfMonth ==
                            true)
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/point.svg",
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                Text(
                                  "Ngày 15 hàng tháng",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        if (ctvWalletController
                                .generalInfoPaymentCtv.value.payment1OfMonth ==
                            true)
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/icons/point.svg",
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    Text(
                                      "Ngày 30 hàng tháng",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tự động gửi yêu cầu quyết toán"),
                                      Obx(
                                        () => CupertinoSwitch(
                                          value: ctvWalletController
                                              .isPaymentAuto.value,
                                          onChanged: (bool value) {
                                            ctvWalletController
                                                    .isPaymentAuto.value =
                                                !ctvWalletController
                                                    .isPaymentAuto.value;
                                            ctvWalletController.updateInfoCTV();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "* Lưu ý:\nBạn cần có số dư ví tối thiểu là ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text:
                                        "${SahaStringUtils().convertToMoney(ctvWalletController.generalInfoPaymentCtv.value.paymentLimit ?? 0)} VNĐ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red)),
                                TextSpan(
                                    text: " để được thanh toán định kỳ",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        if (ctvWalletController.generalInfoPaymentCtv.value
                                .hasPaymentRequest ==
                            false)
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  ctvWalletController.requestPayment();
                                },
                                child: Container(
                                  width: Get.width,
                                  height: 40,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Theme.of(Get.context!)
                                              .primaryColor
                                              .withOpacity(0.7),
                                          Theme.of(Get.context!)
                                              .primaryColor
                                              .withOpacity(0.3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.repeated),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "GỬI YÊU CẦU THANH TOÁN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                  "* Lưu ý:\nBạn cần gửi yêu cầu thanh toán trước ít nhất 3 ngày so với kỳ hạn thanh toán"),
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget historyTransaction() {
    return Column(
      children: [
        CartFunction(
          title: "Các đơn hàng giới thiệu",
          svgAssets: "packages/sahashop_customer/assets/icons/check_list.svg",
          svgColor: Colors.teal,
          onTap: () {
            Get.to(() => OrderHistoryCtvScreen());
          },
        ),
        CartFunction(
          title: "Lịch sử thay đổi số dư",
          svgAssets: "packages/sahashop_customer/assets/icons/money.svg",
          svgColor: Colors.amber,
          onTap: () {
            Get.to(() => PaymentHistoryScreen());
          },
        ),
        CartFunction(
          title: "Báo cáo hoa hồng",
          svgAssets: "packages/sahashop_customer/assets/icons/statistics.svg",
          svgColor: Colors.blue,
          onTap: () {
            Get.to(() => ReportRoseScreen());
          },
        ),
        CartFunction(
          title: "Báo cáo tổng quan",
          svgAssets: "packages/sahashop_customer/assets/icons/statistics.svg",
          svgColor: Colors.blue,
          onTap: () {
            Get.to(() => ReportScreen());
          },
        ),
        CartFunction(
          title: "Các sản phẩm hoa hồng",
          svgAssets: "packages/sahashop_customer/assets/icons/gift_box.svg",
          svgColor: Colors.pink,
          onTap: () {
            Get.to(() => CategoryCtvSceen());
          },
        ),
          CartFunction(
          title: "Danh sách giới thiệu",
          svgAssets: "packages/sahashop_customer/assets/icons/group_empty.svg",
          svgColor: Colors.blue,
          onTap: () {
           Get.to(()=>CtvIntroduceScreen());
          },
        ),
      ],
    );
  }
}
