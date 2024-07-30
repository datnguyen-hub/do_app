import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/order_completed_screen/order_completed_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/review/review_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../review/product_review/product_review_screen.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;
  final bool? checkReview;
  final Function? onTap;
  final Function? thenReview;

  const OrderItemWidget(
      {Key? key,
      required this.order,
      this.checkReview,
      this.onTap,
      this.thenReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: Row(
              children: [
                Spacer(),
                Text(
                  "${order.orderStatusName}",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: order.lineItemsAtTime!.length == 0
                        ? ""
                        : "${order.lineItemsAtTime![0].imageUrl}",
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${order.lineItemsAtTime!.isEmpty ? "Lỗi sản phẩm" : order.lineItemsAtTime![0].name}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                Text(
                                  " x ${order.lineItemsAtTime!.isEmpty ? "Lỗi sản phẩm" : order.lineItemsAtTime![0].quantity}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Spacer(),
                                if (order.lineItemsAtTime![0].beforePrice != order.lineItemsAtTime![0].itemPrice)
                                Text(
                                  "đ${SahaStringUtils().convertToMoney(order.lineItemsAtTime!.isEmpty ? 0.0 : order.lineItemsAtTime![0].beforePrice ?? 0)}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[600]),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "đ${SahaStringUtils().convertToMoney(order.lineItemsAtTime!.isEmpty ? 0.0 : order.lineItemsAtTime![0].itemPrice ?? 0)}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
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
          order.lineItemsAtTime!.length > 1
              ? Container(
                  width: Get.width,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "Xem thêm sản phẩm",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                )
              : Container(),
          Divider(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  "${order.lineItemsAtTime!.length} sản phẩm",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Spacer(),
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
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text("Thành tiền: "),
                    Text(
                      "đ${SahaStringUtils().convertToMoney(order.totalFinal)}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
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
              children: [
                order.orderStatusCode == WAITING_FOR_PROGRESSING ||
                        order.orderStatusCode == PACKING ||
                        order.orderStatusCode == SHIPPING
                    ? InkWell(
                        onTap: () {
                          Get.to(() => OrderCompletedScreen(
                                viewHistory: true,
                                orderCode: order.orderCode,
                              ));
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              "Thanh toán",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge!
                                      .color),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Spacer(),
                order.orderStatusCode != COMPLETED
                    ? Container(
                        height: 35,
                        width: 100,
                        child: Center(
                          child: Row(
                            children: [
                              Icon(Ionicons.eye_outline,
                                  size: 15,
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground()),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Xem",
                                  style: TextStyle(
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground())),
                            ],
                          ),
                        ),
                      )
                    : checkReview == false
                        ? InkWell(
                            onTap: () {
                              // Get.to(
                              //   () => ReviewScreen(
                              //     lineItemsAtTime: order.lineItemsAtTime!,
                              //     orderCode: order.orderCode,
                              //   ),
                              // )!
                              //     .then((isSentSuccess) {
                              //   if (isSentSuccess == true) {
                              //     if (thenReview != null) {
                              //       thenReview!();
                              //     }
                              //   }
                              // });
                              Get.to(()=>ProductReviewScreen(
                                orderCode: order.orderCode,
                              ));
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Đánh giá",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              CartController cartController = Get.find();
                              if (order.lineItemsAtTime != null) {
                                await Future.wait(
                                    order.lineItemsAtTime!.map((e) {
                                  if (e.id != null) {
                                    return cartController
                                        .addItemCart(e.id, 1, []);
                                  } else {
                                    return Future.value(null);
                                  }
                                }));
                              }
                              Get.to(() => CartScreen());
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Mua lại",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                ),
                              ),
                            ),
                          ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: Row(
              children: [
                Text(
                  "Mã đơn hàng ",
                ),
                Spacer(),
                Text(
                  "${order.orderCode}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
