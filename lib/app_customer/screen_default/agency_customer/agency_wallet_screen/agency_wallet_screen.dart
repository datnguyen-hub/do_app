import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/step_bonus.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/config_payment_agency_screen/config_payment_ctv_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/order_history/order_history_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/payment_history/payment_history_agency_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/report/report_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/report_rose/report_rose_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../model/general_info_payment_agency.dart';
import '../referral/referral_screen.dart';
import '../register_agency_screen.dart';
import 'agency_wallet_controller.dart';
import 'widget/card_function.dart';

class AgencyWalletScreen extends StatefulWidget {
  @override
  State<AgencyWalletScreen> createState() => _AgencyWalletScreenState();
}

class _AgencyWalletScreenState extends State<AgencyWalletScreen>
    with SingleTickerProviderStateMixin {
  var height = AppBar().preferredSize.height;

  late List<Widget> itemWidgetCtv;
  late List<Widget> itemWidget;

  AgencyWalletController agencyWalletController =
      Get.put(AgencyWalletController());

  DataAppCustomerController dataAppCustomerController = Get.find();

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    itemWidgetCtv = [
      infomationWallet(),
      payment(),
      historyTransactionAgencyCtv(),
    ];
    itemWidget = [
      historyTransaction(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
      child: RegisterAgencyScreen(
        child: Obx(() {
          if ((dataAppCustomerController.badge.value.statusAgency == 0 ||
                  dataAppCustomerController.badge.value.statusAgency == -1 ||
                  dataAppCustomerController.badge.value.statusAgency == null) &&
              dataAppCustomerController.infoCustomer.value.isAgency == true) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Text(
                      "Đại lý",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                iconTheme: new IconThemeData(
                  color: Theme.of(context).primaryColor,
                ),
                elevation: 0,
              ),
              body: Center(
                child: Container(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Chức năng Đại lý của bạn chưa được phê duyệt!\nHãy liên hệ với chủ shop để được giải quyết",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Đại lý"),
              ),
              body: Column(
                children: [
                  Divider(
                    height: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: Get.width,
                        child: TabBar(
                          controller: tabController,
                          onTap: (v) {
                            agencyWalletController.tabIndex.value = v;
                          },
                          tabs: [
                            Tab(
                                child: Text('Nhập hàng',
                                    style: TextStyle(color: Colors.black))),
                            Tab(
                                child: Text('Hoa hồng',
                                    style: TextStyle(color: Colors.black))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 1,
                  ),
                  Expanded(
                    child: Obx(
                      () => agencyWalletController.tabIndex.value == 0
                          ? SingleChildScrollView(
                              child: Column(
                                children: itemWidget,
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.7),
                                          Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.repeated),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: Get.width,
                                            height: height - 20,
                                          ),
                                          Text(
                                            "Ví Đại lý",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("số dư"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Obx(
                                            () => Text(
                                              "${SahaStringUtils().convertToMoney(agencyWalletController.generalInfoPaymentAgency.value.balance ?? 0)} ₫",
                                              style: TextStyle(fontSize: 28),
                                            ),
                                          ),
                                          if ((agencyWalletController
                                                      .generalInfoPaymentAgency
                                                      .value
                                                      .moneyPaymentRequest ??
                                                  0) !=
                                              0)
                                            Obx(
                                              () => Text(
                                                "Đóng băng: ${SahaStringUtils().convertToMoney(agencyWalletController.generalInfoPaymentAgency.value.moneyPaymentRequest ?? 0)} ₫",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Obx(
                                        () => agencyWalletController
                                                    .generalInfoPaymentAgency
                                                    .value
                                                    .hasPaymentRequest ==
                                                true
                                            ? Positioned(
                                                left: 10,
                                                bottom: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[100]!
                                                        .withOpacity(0.2),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 2,
                                                      bottom: 2),
                                                  child: Text(
                                                    "Bạn đã gửi yêu cầu thanh toán ${SahaStringUtils().convertToMoney(agencyWalletController.generalInfoPaymentAgency.value.moneyPaymentRequest ?? 0)} cho shop, vui lòng chờ xác nhận !",
                                                    style:
                                                        TextStyle(fontSize: 11),
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
                                          agencyWalletController.indexWidget(0);
                                        }),
                                    Spacer(),
                                    boxTab(
                                        index: 1,
                                        title: "Thanh toán",
                                        onTap: () {
                                          agencyWalletController.indexWidget(1);
                                        }),
                                    Spacer(),
                                    boxTab(
                                        index: 2,
                                        title: "Thống kê",
                                        onTap: () {
                                          agencyWalletController.indexWidget(2);
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
                                        child: itemWidgetCtv[
                                            agencyWalletController
                                                .indexWidget.value]),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
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
                    color: agencyWalletController.indexWidget.value == index
                        ? SahaColorUtils().colorPrimaryTextWithWhiteBackground()
                        : Colors.grey[500]),
              ),
            ),
            Obx(
              () => agencyWalletController.indexWidget.value == index
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
            title: "Doanh thu tháng này",
            subText:
                "${agencyWalletController.generalInfoPaymentAgency.value.numberOrderCtv ?? 0} Giao dịch",
            totalMoney:
                "${SahaStringUtils().convertToMoney(agencyWalletController.generalInfoPaymentAgency.value.totalFinalCtv ?? 0)}",
            svgAssets: "packages/sahashop_customer/assets/icons/payment.svg",
            svgColor: Colors.green,
            onTap: () {
              Get.to(() => OrderHistoryAgencyScreen(
                    initPage: 3,
                    isCtv: true,
                    dateFrom: DateTime(DateTime.now().year,DateTime.now().month,1),
                    dateTo:DateTime(DateTime.now().year,DateTime.now().month +1,0),
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
                    "THƯỞNG THEO MỨC HOA HỒNG",
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
                      agencyWalletController.generalInfoPaymentAgency.value
                              .stepsBonus?.length ??
                          0,
                      (index) => boxGiftBonus(
                          typeRose: agencyWalletController
                                  .generalInfoPaymentAgency.value.typeRose ??
                              0,
                          svgAsset:
                              "packages/sahashop_customer/assets/icons/point.svg",
                          svgAssetCheck:
                              "packages/sahashop_customer/assets/icons/checked.svg",
                          stepsBonus: agencyWalletController
                              .generalInfoPaymentAgency
                              .value
                              .stepsBonus![index]),
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
                  color: agencyWalletController
                              .generalInfoPaymentAgency.value.totalFinalCtv! >=
                          stepsBonus.limit!
                      ? Colors.transparent
                      : Colors.amber,
                  width: 1.5)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  agencyWalletController
                              .generalInfoPaymentAgency.value.totalFinalCtv! >=
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

  Widget boxGiftBonusImport({
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
                  color: agencyWalletController
                              .generalInfoPaymentAgency.value.totalFinal! >=
                          stepsBonus.limit!
                      ? Colors.transparent
                      : Colors.amber,
                  width: 1.5)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  agencyWalletController
                              .generalInfoPaymentAgency.value.totalFinal! >=
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
                  () => agencyWalletController.isFullInfoPayment.value == true
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
                                  Text(
                                      "${agencyWalletController.fullName.value}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Số CMND/CCCD:"),
                                  Spacer(),
                                  Text("${agencyWalletController.cmnd.value}"),
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
                              Text("${agencyWalletController.bank}"),
                              Text("${agencyWalletController.accountNumber}"),
                            ],
                          ),
                        )
                      : Container(),
                ),
                Obx(
                  () => agencyWalletController.isFullInfoPayment.value == false
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                              "Bạn chưa có thông tin thanh toán.\nVui lòng nhập thông tin để được thanh toán tiền từ ví Agency"),
                        )
                      : Container(),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ConfigPaymentAgencyScreen())!.then((value) => {
                          agencyWalletController.getInfoAgency(),
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
                            "${agencyWalletController.isFullInfoPayment.value == false ? "THÊM THÔNG TIN THANH TOÁN" : "SỬA THÔNG TIN THANH TOÁN"}",
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
                            "Tiền từ Ví Agency của thành viên Diamond sẽ được thanh toán định kỳ ${agencyWalletController.generalInfoPaymentAgency.value.payment1OfMonth == true && agencyWalletController.generalInfoPaymentAgency.value.payment16OfMonth == true ? "02/Tháng" : agencyWalletController.generalInfoPaymentAgency.value.payment1OfMonth == true || agencyWalletController.generalInfoPaymentAgency.value.payment16OfMonth == true ? "01/Tháng" : ""}",
                          ),
                        ),
                        if (agencyWalletController.generalInfoPaymentAgency
                                .value.payment16OfMonth ==
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
                        if (agencyWalletController.generalInfoPaymentAgency
                                .value.payment1OfMonth ==
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
                                  "Ngày 30 hàng tháng",
                                  style: TextStyle(fontWeight: FontWeight.w600),
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
                                        "${SahaStringUtils().convertToMoney(agencyWalletController.generalInfoPaymentAgency.value.paymentLimit ?? 0)} VNĐ",
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
                        if (agencyWalletController.generalInfoPaymentAgency
                                .value.hasPaymentRequest ==
                            false)
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  agencyWalletController.requestPaymentAgency();
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

  Widget historyTransactionAgencyCtv() {
    return Column(
      children: [
        CartFunction(
          title: "Các đơn hàng giới thiệu",
          svgAssets: "packages/sahashop_customer/assets/icons/check_list.svg",
          svgColor: Colors.teal,
          onTap: () {
            Get.to(() => OrderHistoryAgencyScreen(
                  isCtv: true,
                ));
          },
        ),
        CartFunction(
          title: "Lịch sử thay đổi số dư",
          svgAssets: "packages/sahashop_customer/assets/icons/money.svg",
          svgColor: Colors.amber,
          onTap: () {
            Get.to(() => PaymentHistoryAgencyCTVScreen());
          },
        ),
        CartFunction(
          title: "Thưởng bậc thang",
          svgAssets: "packages/sahashop_customer/assets/icons/statistics.svg",
          svgColor: Colors.blue,
          onTap: () {
            Get.to(() => ReportRoseAgencyScreen());
          },
        ),
        CartFunction(
          title: "Báo cáo tổng quan",
          svgAssets: "packages/sahashop_customer/assets/icons/statistics.svg",
          svgColor: Colors.blue,
          onTap: () {
            Get.to(() => ReportAgencyScreen(
                  isCtv: true,
                ));
          },
        ),
        CartFunction(
          title: "Danh sách giới thiệu",
          svgAssets: "packages/sahashop_customer/assets/icons/group_empty.svg",
          svgColor: Colors.blue,
          onTap: () {
            Get.to(() => ReferralScreen());
          },
        ),
      ],
    );
  }

  Widget historyTransaction() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cấp đại lý:"),
                  Text("${agencyWalletController.nameAgency.value}"),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          CartFunction(
            title: "Các đơn hàng đã đặt",
            svgAssets: "packages/sahashop_customer/assets/icons/check_list.svg",
            svgColor: Colors.teal,
            onTap: () {
              Get.to(() => OrderHistoryAgencyScreen(
                    isCtv: false,
                  ));
            },
          ),
          // CartFunction(
          //   title: "Lịch sử thay đổi số dư",
          //   svgAssets: "packages/sahashop_customer/assets/icons/money.svg",
          //   svgColor: Colors.amber,
          //   onTap: () {
          //     Get.to(() => PaymentHistoryAgencyScreen());
          //   },
          // ),
          CartFunction(
            title: "Báo cáo tổng quan",
            svgAssets: "packages/sahashop_customer/assets/icons/report.svg",
            svgColor: Colors.pink,
            onTap: () {
              Get.to(() => ReportAgencyScreen(
                    isCtv: false,
                  ));
            },
          ),
          SizedBox(
            height: 8,
          ),
          report(),
        ],
      ),
    );
  }

  Widget report() {
    String getText(int? type) {
      if (type == 0) return "Theo tháng";
      if (type == 1) return "Theo tuần";
      if (type == 2) return "Theo quý";
      if (type == 3) return "Theo năm";
      return "Chọn kỳ";
    }

    return Container(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      agencyWalletController.type.value = 0;
                    },
                    child: Container(
                      width: Get.width / 4.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                        child: Obx(
                          () => Text(
                            'Tháng',
                            style: TextStyle(
                              color: agencyWalletController.type.value == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontSize: agencyWalletController.type.value == 0
                                  ? 17
                                  : 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      agencyWalletController.type.value = 1;
                    },
                    child: Container(
                      width: Get.width / 4.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                        child: Obx(
                          () => Text(
                            'Tuần',
                            style: TextStyle(
                              color: agencyWalletController.type.value == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontSize: agencyWalletController.type.value == 1
                                  ? 17
                                  : 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      agencyWalletController.type.value = 2;
                    },
                    child: Container(
                      width: Get.width / 4.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Obx(
                        () => Text(
                          'Quý',
                          style: TextStyle(
                            color: agencyWalletController.type.value == 2
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            fontSize: agencyWalletController.type.value == 2
                                ? 17
                                : 14,
                          ),
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      agencyWalletController.type.value = 3;
                    },
                    child: Container(
                      width: Get.width / 4.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                          child: Obx(
                        () => Text(
                          'Năm',
                          style: TextStyle(
                            color: agencyWalletController.type.value == 3
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            fontSize: agencyWalletController.type.value == 3
                                ? 17
                                : 14,
                          ),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        itemReport(
                            title: 'Tổng doanh số',
                            icon: Icon(
                              Icons.bar_chart,
                              color: Colors.red,
                            ),
                            number: (agencyWalletController
                                        .generalInfoPaymentAgency
                                        .value
                                        .totalAfterDiscountNoBonus ??
                                    0)
                                .toString()),
                        itemReport(
                            title: 'Tổng đơn',
                            icon: Icon(
                              Icons.list_alt_rounded,
                              color: Colors.red,
                            ),
                            number: (agencyWalletController
                                        .generalInfoPaymentAgency
                                        .value
                                        .numberOrder ??
                                    0)
                                .toString()),
                      ],
                    ),
                    Row(
                      children: [
                        itemReport(
                            title: 'Doanh thu ngày',
                            icon: Icon(
                              Icons.bar_chart,
                              color: Colors.blue,
                            ),
                            number: (agencyWalletController
                                        .generalInfoPaymentAgency
                                        .value
                                        .totalAfterDiscountNoBonusInDay ??
                                    0)
                                .toString()),
                        itemReport(
                            title: 'Tổng đơn ngày',
                            icon: Icon(
                              Icons.list_alt_rounded,
                              color: Colors.teal,
                            ),
                            number: (agencyWalletController
                                        .generalInfoPaymentAgency
                                        .value
                                        .countInDay ??
                                    0)
                                .toString()),
                      ],
                    ),
                    if (agencyWalletController.type.value == 0)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu tháng',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .totalAfterDiscountNoBonusInMonth ??
                                      0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn tháng',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .countInMonth ??
                                      0)
                                  .toString()),
                        ],
                      ),
                    if (agencyWalletController.type.value == 1)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu tuần',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .totalAfterDiscountNoBonusInWeek ??
                                      0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn tuần',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .countInWeek ??
                                      0)
                                  .toString()),
                        ],
                      ),
                    if (agencyWalletController.type.value == 2)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu quý',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .totalAfterDiscountNoBonusInQuarter ??
                                      0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn quý',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .countInQuarter ??
                                      0)
                                  .toString()),
                        ],
                      ),
                    if (agencyWalletController.type.value == 3)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu năm',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .totalAfterDiscountNoBonusInYear ??
                                      0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn năm',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number: (agencyWalletController
                                          .generalInfoPaymentAgency
                                          .value
                                          .countInYear ??
                                      0)
                                  .toString()),
                        ],
                      ),
                    Container(
                      padding: EdgeInsets.all(10),
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
                              Expanded(
                                child: Text(
                                  "THƯỞNG THEO MỨC DOANH THU ${getText(agencyWalletController.generalInfoPaymentAgency.value.typeBonusPeriodImport ?? 0).toUpperCase()}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(height: 1),
                          Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    ...List.generate(
                                      agencyWalletController
                                              .generalInfoPaymentAgency
                                              .value
                                              .stepsBonusImport
                                              ?.length ??
                                          0,
                                      (index) => boxGiftBonusImports(
                                          svgAsset:
                                              "packages/sahashop_customer/assets/icons/point.svg",
                                          svgAssetCheck:
                                              "packages/sahashop_customer/assets/icons/checked.svg",
                                          stepsBonus: agencyWalletController
                                              .generalInfoPaymentAgency
                                              .value
                                              .stepsBonusImport![index],
                                          overViewSale: agencyWalletController
                                              .generalInfoPaymentAgency.value),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget itemReport(
      {required String title, required Icon icon, required String? number}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: (Get.width - 40) / 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
          Divider(),
          Text(
            SahaStringUtils().convertToMoney(number),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget boxGiftBonusImports({
    required String svgAsset,
    required String svgAssetCheck,
    required StepsBonus stepsBonus,
    required GeneralInfoPaymentAgency overViewSale,
  }) {
    double getTotal() {
      var t = overViewSale.typeBonusPeriodImport;
      if (t == 0) {
        return overViewSale.totalFinalInMonth ?? 0;
      }
      if (t == 1) {
        return overViewSale.totalFinalInWeek ?? 0;
      }
      if (t == 2) {
        return overViewSale.totalFinalInQuarter ?? 0;
      }
      if (t == 3) {
        return overViewSale.totalFinalInYear ?? 0;
      }
      return 0;
    }

    return Container(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(
              color: getTotal() >= stepsBonus.limit!
                  ? Colors.amber
                  : Colors.grey[200]!,
              width: 1.5)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              getTotal() >= stepsBonus.limit! ? svgAssetCheck : svgAsset,
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
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
