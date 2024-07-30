import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class OrderDetailBottomDetail {
  static void show(CartController cartController) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: Get.context!,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tạm tính"),
                        Text(
                            "${SahaStringUtils().convertToMoney(cartController.cartData.value.totalBeforeDiscount ?? 0)} đ"),
                      ],
                    ),
                  ),
                  if ((cartController.cartData.value.productDiscountAmount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Sản phẩm"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(cartController.cartData.value.productDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((cartController.cartData.value.voucherDiscountAmount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Voucher"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(cartController.cartData.value.voucherDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((cartController.cartData.value.comboDiscountAmount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Combo"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(cartController.cartData.value.comboDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if (cartController.cartData.value.isUsePoints == true)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá xu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(cartController.cartData.value.bonusPointsAmountUsed ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if (cartController.isUseBalanceCollaborator.value == true)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sử dụng số dư cộng tác viên"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(cartController.balanceCollaboratorUsed.value)} đ"),
                        ],
                      ),
                    ),
                  if (cartController.isUseBalanceCollaborator.value == true)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sử dụng số dư cộng tác viên"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(cartController.balanceAgencyUsed.value)} đ"),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng giảm"),
                        Text(
                            "- ${SahaStringUtils().convertToMoney(cartController.cartData.value.productDiscountAmount! + cartController.cartData.value.voucherDiscountAmount! + cartController.cartData.value.comboDiscountAmount! + cartController.cartData.value.bonusPointsAmountUsed!)} đ"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền"),
                        Text(
                            "${SahaStringUtils().convertToMoney(cartController.cartData.value.totalAfterDiscount ?? 0)} đ"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  SahaButtonFullParent(
                    text: "Đóng",
                    textColor:
                        Theme.of(context).primaryTextTheme.titleLarge!.color,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                ],
              ),
              Positioned(
                  height: 45,
                  width: 45,
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ))
            ],
          );
        });
  }
}
