import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../screen_default/cart_screen/cart_screen.dart';
import '../../../screen_default/confirm_screen/confirm_screen.dart';

class ProductItemWidgetStyle4 extends StatelessWidget {
  ProductItemWidgetStyle4({
    Key? key,
    required this.product,
    this.width,
    this.height,
    this.showCart = true,
  }) : super(key: key);

  Product product;
  double? width;
  double? height;
  bool? showCart;

  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ??
          (dataAppCustomerController.badge.value.statusCollaborator == 1 ||
                  dataAppCustomerController.badge.value.statusAgency == 1
              ? 320
              : 295),
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(right: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey.withOpacity(0.3))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              product: product,
                            )),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                          ),
                          child: Image.network(
                            product.images!.length == 0
                                ? ""
                                : product.images![0].imageUrl!,
                            height: 180,
                            width: Get.width,
                            fit: BoxFit.cover,
                            errorBuilder: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                        ),
                      ),
                    ), //product.images[0].imageUrl
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                ),
                              ),
                              height: 45,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          product.productDiscount == null
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 2, bottom: 2),
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: new LinearGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5)
                                        ],
                                        begin: const FractionalOffset(0.0, 0.0),
                                        end: const FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                  ),
                                  child: Text(
                                    "-${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "nunito_bold",
                                        color: Colors.white),
                                  ),
                                ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: dataAppCustomerController
                                          .badge.value.statusCollaborator ==
                                      1 ||
                                  dataAppCustomerController
                                          .badge.value.statusAgency ==
                                      1
                              ? 70
                              : 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              product.productDiscount == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Text(
                                        product.minPrice == 0
                                            ? "${product.price == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(product.price)}₫"} - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%"
                                            : "${SahaStringUtils().convertToMoney(product.minPrice)}₫ - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                                        style: TextStyle(
                                            decoration: product.price == 0
                                                ? null
                                                : TextDecoration.lineThrough,
                                            color: product.productDiscount ==
                                                    null
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                product.productDiscount == null
                                                    ? 14
                                                    : 10),
                                      ),
                                    ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  textMoney()!,
                                  style: TextStyle(
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  maxLines: 1,
                                ),
                              ),
                              if (product.percentCollaborator != null &&
                                  dataAppCustomerController
                                          .badge.value.statusCollaborator ==
                                      1)
                                Row(
                                  children: [
                                    Container(
                                      height: 35,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "  Hoa hồng",
                                            style: TextStyle(
                                                fontSize: 11,
                                                height: 1,
                                                color: Colors.grey),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: Text(
                                              priceRose(),
                                              style: TextStyle(
                                                  color: Colors.pink,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              if (dataAppCustomerController
                                      .badge.value.statusAgency ==
                                  1)
                                Row(
                                  children: [
                                    Container(
                                      height: 35,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "  Giá bán lẻ",
                                            style: TextStyle(
                                                fontSize: 11,
                                                height: 1,
                                                color: Colors.grey),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: Text(
                                              "${textMoneyAgency()}",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (showCart == true)
                          InkWell(
                            onTap: () {
                              ModalBottomOptionBuyProduct.showModelOption(
                                  textButton: "Thêm vào giỏ hàng",
                                  product: product,
                                  isOnlyAddToCart: false,
                                  onSubmit: (int quantity,
                                      Product product,
                                      List<DistributesSelected>
                                          distributesSelected,
                                      bool? buyNow) async {
                                    await cartController.addItemCart(product.id,
                                        quantity, distributesSelected);
                                    dataAppCustomerController.getBadge();
                                    Get.back();
                                    if (buyNow == true) {
                                      Get.to(() => CartScreen());
                                      Get.to(() => ConfirmScreen());
                                    }
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Ionicons.cart_outline,
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom:
                dataAppCustomerController.badge.value.statusCollaborator == 1 ||
                        dataAppCustomerController.badge.value.statusAgency == 1
                    ? 130
                    : 100,
            right: 12,
            child: Row(
              children: [
                if (product.hasInCombo == true ||
                    product.hasInDiscount == true ||
                    product.hasInBonusProduct == true)
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    height: 15,
                    child: Center(
                      child: Text(
                        "Khuyến mại",
                        style: TextStyle(
                            fontSize: 9,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleLarge!
                                .color),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 2,
                ),
                product.isTopSale == true
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        height: 15,
                        width: 45,
                        child: Center(
                          child: Text(
                            "Bán chạy",
                            style: TextStyle(
                                fontSize: 9,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge!
                                    .color),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  String? textMoney() {
    if (product.productDiscount == null) {
      return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice)}₫"}";
    } else {
      return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice! - ((product.minPrice! * product.productDiscount!.value!) / 100))}₫"}";
    }
  }

  String? textMoneyAgency() {
    if (product.productDiscount == null) {
      return "${product.minPriceBeforeOverride == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPriceBeforeOverride)}₫"}";
    } else {
      return "${product.minPriceBeforeOverride == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPriceBeforeOverride! - ((product.minPriceBeforeOverride! * product.productDiscount!.value!) / 100))}₫"}";
    }
  }

  double? checkMinMaxPrice(double? price) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }

  String priceRose() {
    return "${product.typeShareCollaboratorNumber == 0 ? SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPrice)! * (product.percentCollaborator! / 100)) : SahaStringUtils().convertToMoney(product.moneyAmountCollaborator ?? 0)}₫";
  }
}
