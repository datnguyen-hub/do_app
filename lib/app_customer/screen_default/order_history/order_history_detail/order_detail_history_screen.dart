import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_shimmer.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/screen_default/chat_customer_screen/chat_user_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/order_history/order_history_detail/widget/choose_reason_cancel_order.dart';

import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import 'order_detail_history_controller.dart';

// ignore: must_be_immutable
class OrderHistoryDetailScreen extends StatelessWidget {
  final String? orderCode;

  var listStatusCode = [
    WAITING_FOR_PROGRESSING,
    PACKING,
    OUT_OF_STOCK,
    USER_CANCELLED,
    CUSTOMER_CANCELLED,
    SHIPPING,
    DELIVERY_ERROR,
    COMPLETED,
    CUSTOMER_RETURNING,
    CUSTOMER_HAS_RETURNS,
  ];

  OrderHistoryDetailScreen({this.orderCode}) {
    orderHistoryDetailController =
        Get.put(OrderHistoryDetailController(orderCode: orderCode));
  }

  late OrderHistoryDetailController orderHistoryDetailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đơn hàng"),
      ),
      body: Obx(
        () => orderHistoryDetailController.isLoading.value == true
            ? SahaSimmer(
                isLoading: true,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Color(0xff16a5a1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Trạng thái đơn hàng: ${orderHistoryDetailController.order.value.orderStatusName}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                ),
                                Spacer(),
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/delivery_truck.svg",
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Trạng thái thanh toán: ${orderHistoryDetailController.order.value.paymentStatusName}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                ),
                                Spacer(),
                                Container(
                                  child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/wallet.svg",
                                      width: 28,
                                      height: 28,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/delivery_truck.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Đơn vị vận chuyển: ${orderHistoryDetailController.order.value.shipperName ?? "Chưa có đơn vị vận chuyển"}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Phí giao hàng: đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalShippingFee ?? 0)}"),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/location.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Địa chỉ nhận hàng của khách:",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderHistoryDetailController.order.value.customerAddress!.name ?? "Chưa có tên"}  | ${orderHistoryDetailController.order.value.customerAddress!.phone ?? "Chưa có số điện thoại"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderHistoryDetailController.order.value.customerAddress!.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderHistoryDetailController.order.value.customerAddress!.wardsName ?? "Chưa có Phường/Xã"}, ${orderHistoryDetailController.order.value.customerAddress!.districtName ?? "Chưa có Quận/Huyện"}, ${orderHistoryDetailController.order.value.customerAddress!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 13),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    if (orderHistoryDetailController.order.value.customerNote !=
                        null)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lời nhắn: ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                  "${orderHistoryDetailController.order.value.customerNote ?? ""}"),
                            )
                          ],
                        ),
                      ),
                    if (orderHistoryDetailController.order.value.customerNote !=
                        null)
                      Divider(
                        height: 1,
                      ),
                    Column(
                      children: [
                        ...List.generate(
                          orderHistoryDetailController
                              .order.value.lineItemsAtTime!.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]!)),
                                        child: CachedNetworkImage(
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          imageUrl: orderHistoryDetailController
                                                      .order
                                                      .value
                                                      .lineItemsAtTime!
                                                      .length ==
                                                  0
                                              ? ""
                                              : "${orderHistoryDetailController.order.value.lineItemsAtTime![index].imageUrl}",
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 80,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${orderHistoryDetailController.order.value.lineItemsAtTime![index].name}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      " x ${orderHistoryDetailController.order.value.lineItemsAtTime![index].quantity}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    if (orderHistoryDetailController
                                                            .order
                                                            .value
                                                            .lineItemsAtTime![
                                                                index]
                                                            .beforePrice !=
                                                        orderHistoryDetailController
                                                            .order
                                                            .value
                                                            .lineItemsAtTime![
                                                                index]
                                                            .itemPrice)
                                                      Text(
                                                        "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.lineItemsAtTime![index].beforePrice)}",
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      orderHistoryDetailController
                                                                  .order
                                                                  .value
                                                                  .lineItemsAtTime![
                                                                      index]
                                                                  .isBonus ==
                                                              true
                                                          ? 'Hàng tặng'
                                                          : "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.lineItemsAtTime![index].itemPrice ?? 0)}",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Ghi chú : ${orderHistoryDetailController.order.value.lineItemsAtTime![index].note ?? ''}"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tổng tiền hàng: ",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Spacer(),
                              Text(
                                "₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalBeforeDiscount)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if (orderHistoryDetailController.order.value.vat !=
                                  null &&
                              orderHistoryDetailController.order.value.vat != 0)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "VAT: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.vat)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Text(
                                "Phí vận chuyển: ",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Spacer(),
                              Text(
                                "+ ₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalShippingFee)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          (orderHistoryDetailController
                                          .order.value.shipDiscountAmount ??
                                      0) ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Miễn phí vận chuyển: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- ₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.shipDiscountAmount ?? 0)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          orderHistoryDetailController
                                      .order.value.productDiscountAmount ==
                                  0
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Giảm giá sản phẩm: ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Spacer(),
                                        Text(
                                          "- đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.productDiscountAmount)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          orderHistoryDetailController
                                      .order.value.comboDiscountAmount ==
                                  0
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Giảm giá Combo: ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Spacer(),
                                        Text(
                                          "- đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.comboDiscountAmount)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          orderHistoryDetailController
                                      .order.value.voucherDiscountAmount ==
                                  0
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Giảm giá Voucher:",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Spacer(),
                                        Text(
                                          "- ₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.voucherDiscountAmount)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          orderHistoryDetailController
                                          .order.value.bonusPointsAmountUsed ==
                                      0 ||
                                  orderHistoryDetailController
                                          .order.value.bonusPointsAmountUsed ==
                                      null
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Giảm giá Xu:",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Spacer(),
                                        Text(
                                          "- ₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.bonusPointsAmountUsed)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          orderHistoryDetailController.order.value
                                          .balanceCollaboratorUsed ==
                                      0 ||
                                  orderHistoryDetailController.order.value
                                          .balanceCollaboratorUsed ==
                                      null
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Giảm giá Ví CTV:",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Spacer(),
                                        Text(
                                          "- ₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.balanceCollaboratorUsed)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          (orderHistoryDetailController
                                          .order.value.balanceAgencyUsed ??
                                      0) ==
                                  0
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Giảm giá Ví đại lý:",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Spacer(),
                                        Text(
                                          "- ₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.balanceAgencyUsed)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          if(orderHistoryDetailController.order.value.isOrderForCustomer == true)
                          Column(
                            children: [
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text("Hoa hồng đặt hộ: ", style: TextStyle(color: Colors.grey[600]),),
                                  Spacer(),
                                  Text(
                                    "₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalCommissionOrderForCustomer ?? 0)}",
                                    style: TextStyle(color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Thành tiền: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalFinal ?? 0)}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    if (orderHistoryDetailController
                            .order.value.bonusAgencyHistory !=
                        null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: CachedNetworkImage(
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      imageUrl: orderHistoryDetailController
                                              .order
                                              .value
                                              .bonusAgencyHistory!
                                              .rewardImageUrl ??
                                          "",
                                      placeholder: (context, url) =>
                                          new SahaLoadingWidget(
                                        size: 20,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          SahaEmptyImage(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Quà tặng: ${orderHistoryDetailController.order.value.bonusAgencyHistory!.rewardName ?? " "}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("Đạt mức: "),
                                            Spacer(),
                                            Text(
                                                "₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.bonusAgencyHistory!.threshold ?? "")}"),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("Thưởng: "),
                                            Spacer(),
                                            Text(
                                                "₫${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.bonusAgencyHistory!.rewardValue ?? "")}"),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, bottom: 10),
                              child: Text(
                                orderHistoryDetailController
                                        .order
                                        .value
                                        .bonusAgencyHistory!
                                        .rewardDescription ??
                                    "",
                                maxLines: 4,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/money.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phương thức thanh toán: "),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  "${orderHistoryDetailController.order.value.paymentPartnerName}")
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                Text("Mã đơn hàng"),
                                Spacer(),
                                Text(
                                    "${orderHistoryDetailController.order.value.orderCode}"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Thời gian đặt hàng",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "${SahaDateUtils().getDDMMYY(orderHistoryDetailController.order.value.createdAt!)} ${SahaDateUtils().getHHMM(orderHistoryDetailController.order.value.createdAt!)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ...List.generate(
                              orderHistoryDetailController
                                  .listStateOrder.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          "${orderHistoryDetailController.listStateOrder[index].note}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${SahaDateUtils().getDDMMYY(orderHistoryDetailController.listStateOrder[index].createdAt!)} ${SahaDateUtils().getHHMM(orderHistoryDetailController.listStateOrder[index].createdAt!)}",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ChatCustomerScreen());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[500]!)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/chat.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Liên hệ Shop")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    orderHistoryDetailController.order.value.orderStatusCode ==
                            WAITING_FOR_PROGRESSING
                        ? InkWell(
                            onTap: () {
                              ChooseReasonCancelOrder.showChooseReasonCancel(
                                  (String reason, int index) {
                                orderHistoryDetailController.reason = reason;
                                orderHistoryDetailController.checkChooseReason(
                                    orderHistoryDetailController
                                        .listChoose[index],
                                    index);
                              }, () {
                                orderHistoryDetailController.cancelOrder();
                              });
                            },
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.grey[500]!)),
                              child: Center(child: Text("Huỷ đơn hàng")),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white,
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Tổng tiền: ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalFinal ?? 0)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground()),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Mã đơn hàng",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                        "${orderHistoryDetailController.order.value.orderCode ?? ""}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
