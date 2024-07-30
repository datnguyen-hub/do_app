import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components//loading/loading_shimmer.dart';
import '../../screen_default/cart_screen/cart_screen.dart';
import '../../screen_default/data_app_controller.dart';
import '../../screen_default/order_history/order_history_detail/order_detail_history_screen.dart';
import '../../utils/store_info.dart';
import 'order_completed_controller.dart';

// ignore: must_be_immutable
class OrderCompletedScreen extends StatefulWidget {
  final String? orderCode;
  final bool viewHistory;

  OrderCompletedController? orderCompletedController;

  OrderCompletedScreen({Key? key, this.orderCode, this.viewHistory = false})
      : super(key: key) {
    orderCompletedController = OrderCompletedController(orderCode);
  }

  @override
  State<OrderCompletedScreen> createState() => _OrderCompletedScreenState();
}

class _OrderCompletedScreenState extends State<OrderCompletedScreen>
    with WidgetsBindingObserver {
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       {
  //         widget.orderCompletedController!.refreshData();
  //         break;
  //       }
  //     case AppLifecycleState.inactive:
  //       print("app is in inactive state");
  //       break;
  //     case AppLifecycleState.paused:
  //       print("app is in paused state");
  //       break;
  //     case AppLifecycleState.detached:
  //       print("app has been removed");
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Obx(
                  () {
                    var x = widget.orderCompletedController!.refreshValue.value;
                    return widget.orderCompletedController!.loading.value ==
                            true
                        ? SahaSimmer(
                            isLoading: true,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              color: Colors.black,
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        color: Theme.of(context).primaryColor),
                                    child: Icon(
                                      widget.viewHistory == true
                                          ? Icons.warning_rounded
                                          : Icons.check,
                                      size: 15.0,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.viewHistory
                                        ? "Thực hiện thanh toán"
                                        : "Đặt hàng thành công !",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  widget.viewHistory
                                      ? ""
                                      : "Bạn đã đặt hàng thành công xin đợi xác nhận từ cửa hàng",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              widget.orderCompletedController!.order.value!
                                              .paymentMethodId ==
                                          2 ||
                                      widget.orderCompletedController!.order
                                              .value!.paymentMethodId ==
                                          null
                                  ? Container()
                                  : Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await launchUrl(
                                              Uri.parse(
                                                  "https://main.doapp.vn/api/customer/${StoreInfo().getCustomerStoreCode()}/purchase/pay/${widget.orderCode}"),
                                            ).then((value) => {});
                                          },
                                          child: Container(
                                            height: 40,
                                            width: Get.width * 0.8,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "THANH TOÁN",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryTextTheme
                                                        .titleLarge!
                                                        .color,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.viewHistory == false)
                                    InkWell(
                                      onTap: () {
                                        Get.until((route) =>
                                            route.settings.name ==
                                            "customer_home");
                                      },
                                      child: Container(
                                        height: 35,
                                        width: Get.width * 0.35,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Trang chủ",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.off(() => OrderHistoryDetailScreen(
                                            orderCode: widget
                                                    .orderCompletedController!
                                                    .order
                                                    .value
                                                    ?.orderCode ??
                                                "",
                                          ));
                                    },
                                    child: Container(
                                      height: 35,
                                      width: Get.width * 0.35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Đơn đã mua",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Thay đổi hình thức thanh toán",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              Obx(
                                () => widget.orderCompletedController!
                                            .isLoadingPayment.value ==
                                        true
                                    ? Container()
                                    : DropdownButton<Map<String, String>?>(
                                        focusColor: Colors.white,
                                        value: null,
                                        // orderCompletedController!
                                        //             .paymentMethod['name'] ==
                                        //         null
                                        //     ? null
                                        //     : {'name': orderCompletedController!
                                        //     .paymentMethod['name'] ?? ""},
                                        elevation: 5,
                                        style: TextStyle(color: Colors.white),
                                        items: widget.orderCompletedController!
                                            .listPaymentMethod!
                                            .map<
                                                    DropdownMenuItem<
                                                        Map<String, String>>>(
                                                (Map<String, String>? value) {
                                          return DropdownMenuItem<
                                              Map<String, String>>(
                                            value: value,
                                            child: Text(
                                              "${value!['name'] ?? ''}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "${widget.orderCompletedController!.order.value?.paymentPartnerName ?? "Loading..."}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged:
                                            (Map<String, String>? value) {
                                          print(value);
                                          widget.orderCompletedController!
                                              .paymentMethod = value!;

                                          widget.orderCompletedController!
                                              .changPaymentMethod(
                                            int.tryParse(value[
                                                        "payment_method_id"] ??
                                                    "0") ??
                                                0,
                                            int.tryParse(value[
                                                        "payment_partner_id"] ??
                                                    "0") ??
                                                0,
                                          );
                                        },
                                      ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: AppBar().preferredSize.height,
            left: 20,
            right: 20,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color:
                          Theme.of(context).primaryTextTheme.titleLarge!.color,
                      size: 20,
                    ),
                  ),
                ),
                Spacer(),
                Obx(
                  () => InkWell(
                    onTap: () {
                      Get.to(() => CartScreen());
                    },
                    child: b.Badge(
                      badgeStyle: b.BadgeStyle(
                        padding: EdgeInsets.all(3),
                      ),
                      position: b.BadgePosition.custom(end: 0, top: -5),
                      badgeContent: Text(
                        '${dataAppCustomerController.badge.value.cartQuantity}',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                      showBadge:
                          dataAppCustomerController.badge.value.cartQuantity ==
                                  0
                              ? false
                              : true,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "packages/sahashop_customer/assets/icons/cart_icon.svg",
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleLarge!
                              .color,
                        ),
                      ),
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
}
