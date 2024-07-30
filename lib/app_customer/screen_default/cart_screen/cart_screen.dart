import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_cart.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/widget/item_bonus.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../screen_can_edit/category_product_screen/category_product_screen.dart';
import '../../screen_default/cart_screen/cart_controller.dart';
import '../../screen_default/data_app_controller.dart';
import '../../screen_default/combo_detail_screen/combo_detail_screen.dart';
import '../../screen_default/confirm_screen/confirm_screen.dart';
import '../../components//text/text_money.dart';
import '../../utils/string_utils.dart';

import 'widget/bottom_detail.dart';
import 'widget/item_product.dart';
class CartLockScreen extends StatelessWidget {
  bool? showIconBack;
  CartLockScreen({this.showIconBack});
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
        child: CartScreen(isAutoBackIcon: showIconBack));
  }
}
// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  bool? isAutoBackIcon;
  CartScreen({Key? key, this.isAutoBackIcon}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dataAppCustomerController.isLogin.value == true) {
        cartController.getAllAddressCustomer();
        cartController.refresh();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.isAutoBackIcon ?? true,
        title: Column(
          children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 18),
            ),
            Obx(
              () => Text(
                "${cartController.listOrder.length} sản phẩm",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => cartController.isLoadingRefresh.value == true
            ? SahaLoadingFullScreen()
            : cartController.listOrder.isEmpty
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => CategoryProductScreen());
                      },
                      child: SahaEmptyCart(
                        width: 50,
                        height: 50,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    color: Colors.indigo,
                    onRefresh: () async {
                      await cartController.refresh();
                    },
                    child: Column(
                      children: [
                        ...List.generate(
                          cartController.listCombo.length,
                          (index) => InkWell(
                            onTap: () {
                              Get.to(() => ComboDetailScreen(
                                  idProduct: cartController.listCombo[index]
                                      .productsCombo![0].product!.id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 10,
                                  bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "Combo ${cartController.listCombo[index].name}",
                                                style: TextStyle(
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground(),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                 
                                    ],
                                  ),
                                  Row(
                                    children: [
                                           cartController.enoughCondition[index] ==
                                              true
                                          ? cartController
                                                      .enoughConditionCB[index] ==
                                                  true
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "Đã giảm ",
                                                      style:
                                                          TextStyle(fontSize: 13),
                                                    ),
                                                    cartController
                                                                .listCombo[index]
                                                                .discountType ==
                                                            0
                                                        ? SahaMoneyText(
                                                            price: cartController
                                                                .listCombo[index]
                                                                .valueDiscount!
                                                                .toDouble(),
                                                            sizeText: 12,
                                                            sizeVND: 10,
                                                          )
                                                        : Text(
                                                            "${cartController.listCombo[index].valueDiscount!.toDouble()}%",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                  ],
                                                )
                                              : Text(
                                                  "Mua thêm để giảm giá !",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red),
                                                )
                                          : Text(
                                              "Mua thêm để giảm giá !",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1.7,
                                                  color: Colors.red),
                                            ),
                                      Spacer(),
                                      Text(
                                        "Mua thêm",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 13,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              if (cartController
                                          .cartData.value.stepBonusAgency !=
                                      null &&
                                  cartController.cartData.value
                                      .stepBonusAgency!.stepBonus!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ItemBonus(
                                    isExpanded: false,
                                    dataConfigBonus: cartController
                                        .cartData.value.stepBonusAgency,
                                    stepBonus: (cartController.cartData.value
                                                .stepBonusAgency!.stepBonus!
                                                .where(
                                                    (e) => e.active == true)
                                                .toList())
                                            .isNotEmpty
                                        ? cartController.cartData.value
                                            .stepBonusAgency!.stepBonus!
                                            .where((e) => e.active == true)
                                            .toList()[0]
                                        : null,
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListView.builder(
                                    itemCount:
                                        cartController.listOrder.length,
                                    itemBuilder: (context, index) =>
                                        ItemProductInCartWidget(
                                      lineItem:
                                          cartController.listOrder[index],
                                      onDismissed: () {
                                        cartController.updateItemCart(
                                            cartController
                                                .listOrder[index].id,
                                            cartController.listOrder[index]
                                                .product!.id!,
                                            0,
                                            cartController.listOrder[index]
                                                    .distributesSelected ??
                                                [],
                                            cartController
                                                .listOrder[index].note);
                                        dataAppCustomerController.getBadge();
                                      },
                                      onDecreaseItem: () {
                                        cartController.decreaseItem(
                                            index,
                                            cartController.listOrder[index]
                                                .distributesSelected);
                                      },
                                      onIncreaseItem: () {
                                        cartController.increaseItem(
                                            index,
                                            cartController.listOrder[index]
                                                .distributesSelected);
                                      },
                                      onUpdateProduct:
                                          (quantity, distributesSelected) {
                                        cartController.updateItemCart(
                                            cartController
                                                .listOrder[index].id,
                                            cartController.listOrder[index]
                                                .product!.id!,
                                            quantity,
                                            distributesSelected,
                                            cartController
                                                .listOrder[index].note);
                                      },
                                      quantity: cartController
                                          .listQuantityProduct[index],
                                      onNote: (int cartItemId, String? note) {
                                        cartController.updateItemCart(
                                            cartController
                                                .listOrder[index].id,
                                            cartController.listOrder[index]
                                                .product!.id!,
                                            cartController.listOrder[index]
                                                    .quantity ??
                                                0,
                                            cartController.listOrder[index]
                                                    .distributesSelected ??
                                                [],
                                            note);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // InkWell(
              //   onTap: () {
              //     Get.to(() => ChooseVoucherCustomerScreen(
              //           voucherCodeChooseInput:
              //               cartController.voucherCodeChoose.value,
              //         ));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       children: [
              //         Container(
              //           padding: EdgeInsets.all(4),
              //           height: 30,
              //           width: 30,
              //           child: SvgPicture.asset(
              //             "packages/sahashop_customer/assets/icons/receipt.svg",
              //             color: SahaColorUtils()
              //                 .colorPrimaryTextWithWhiteBackground(),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text("Voucher"),
              //         Spacer(),
              //         Obx(
              //           () => cartController.voucherCodeChoose.value == ""
              //               ? Text("Chọn hoặc nhập mã")
              //               : Text(
              //                   "Mã: ${cartController.voucherCodeChoose.value} - đ${SahaStringUtils().convertToMoney(cartController.cartData.value.usedVoucher?.discountFor != 1 ? (cartController.cartData.value.voucherDiscountAmount ?? 0) : (cartController.cartData.value.shipDiscountAmount ?? 0))}",
              //                   style: TextStyle(fontSize: 13),
              //                 ),
              //         ),
              //         const SizedBox(width: 10),
              //         Icon(
              //           Icons.arrow_forward_ios,
              //           size: 12,
              //           color: SahaColorUtils()
              //               .colorPrimaryTextWithWhiteBackground(),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Divider(
                height: 1,
              ),
              Obx(
                () => dataAppCustomerController
                                .badge.value.allowUsePointOrder ==
                            true &&
                        cartController.cartData.value.totalPointsCanUse !=
                            0 &&
                        cartController.cartData.value.totalPointsCanUse !=
                            null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                            Text(
                              "Dùng ${SahaStringUtils().convertToMoney(cartController.cartData.value.totalPointsCanUse)} xu ",
                              style: TextStyle(fontSize: 13),
                            ),
                            Spacer(),
                            Obx(
                              () => Text(
                                  "[-${SahaStringUtils().convertToMoney(cartController.cartData.value.bonusPointsAmountUsed ?? 0)}₫] "),
                            ),
                            CupertinoSwitch(
                              value:
                                  cartController.cartData.value.isUsePoints!,
                              onChanged: (bool value) {
                                cartController.cartData.value.isUsePoints =
                                    !cartController
                                        .cartData.value.isUsePoints!;
                                cartController.addVoucherCart(
                                    cartController.voucherCodeChoose.value,
                                    (err) {
                                  print(err);
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
              Divider(
                height: 1,
              ),
              Obx(() => dataAppCustomerController.badge.value.statusAgency ==
                      1
                  ? Padding(
                     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                // decoration: BoxDecoration(
                                //   color: Color(0xFFF5F6F9),
                                //   shape: BoxShape.circle,
                                // ),
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/drop_shipping.svg",
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Đặt hộ",
                                style: TextStyle(fontSize: 13, height: 1.7),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                value: cartController
                                        .cartData.value.isOrderForCustomer ??
                                    false,
                                onChanged: (bool value) {
                                  cartController.cartData.value
                                      .isOrderForCustomer = value;
                                  cartController.cartData.refresh();
                                  cartController.addVoucherCart(
                                      cartController.voucherCodeChoose.value,
                                      (err) {
                                    print(err);
                                  });
                                },
                              )
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                  )
                  : const SizedBox()),
              Obx(
                () => cartController.balanceCollaboratorCanUse.value > 0 &&
                        dataAppCustomerController
                                .badge.value.statusCollaborator ==
                            1
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                                "packages/sahashop_customer/assets/icons/fair_trade.svg",
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "Dùng số dư cộng tác viên ",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Text(
                                "[-${SahaStringUtils().convertToMoney(cartController.balanceCollaboratorCanUse.value)}₫] "),
                            CupertinoSwitch(
                              value: cartController
                                  .isUseBalanceCollaborator.value,
                              onChanged: (bool value) {
                                cartController
                                        .isUseBalanceCollaborator.value =
                                    !cartController
                                        .isUseBalanceCollaborator.value;
                                cartController.addVoucherCart(
                                  cartController.voucherCodeChoose.value,
                                  (err) {},
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Divider(
                height: 1,
              ),
              Obx(
                () => cartController.balanceAgencyCanUse.value > 0 &&
                        dataAppCustomerController.badge.value.statusAgency ==
                            1
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                                "packages/sahashop_customer/assets/icons/home.svg",
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "Dùng số dư đại lý ",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Text(
                                "[-${SahaStringUtils().convertToMoney(cartController.balanceAgencyCanUse.value)}₫] "),
                            CupertinoSwitch(
                              value: cartController.isUseBalanceAgency.value,
                              onChanged: (bool value) {
                                cartController.isUseBalanceAgency.value =
                                    !cartController.isUseBalanceAgency.value;
                                cartController.addVoucherCart(
                                  cartController.voucherCodeChoose.value,
                                  (err) {},
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        OrderDetailBottomDetail.show(cartController);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Tổng cộng: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                () => Text(
                                  "${SahaStringUtils().convertToMoney(cartController.cartData.value.totalAfterDiscount)} đ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Container(
                              padding: EdgeInsets.all(3),
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                children: [
                                  Text(
                                    "Khuyến mãi: ${SahaStringUtils().convertToMoney(cartController.cartData.value.totalBeforeDiscount! - cartController.cartData.value.totalAfterDiscount!)} đ",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => cartController.listOrder.length != 0
                          ? InkWell(
                              onTap: () {
                                if (cartController.listOrder.length != 0) {
                                  Get.to(() => ConfirmScreen());
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    border:
                                        Border.all(color: Colors.grey[200]!)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Đặt hàng ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleLarge!
                                              .color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(
                                      () => Text(
                                        "(${cartController.listOrder.length})",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleLarge!
                                              .color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Đặt hàng ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Obx(
                                    () => Text(
                                      "(${cartController.listOrder.length})",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    )
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
