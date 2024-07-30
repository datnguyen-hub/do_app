import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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

class ProductItemWidgetStyle5 extends StatelessWidget {
  ProductItemWidgetStyle5({
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
  FocusNode _focusNode = FocusNode();

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
            padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.images!.length == 0
                              ? ""
                              : product.images![0].imageUrl ?? "",
                          height: 215,
                          width: Get.width,
                          fit: BoxFit.cover,
                          errorBuilder: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                      ),
                    ), //product.images[0].imageUrl
                    Stack(
                      children: [
                        Container(
                          height: dataAppCustomerController
                                          .badge.value.statusCollaborator ==
                                      1 ||
                                  dataAppCustomerController
                                          .badge.value.statusAgency ==
                                      1
                              ? 120
                              : 100,
                          width: width,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 50,
                                right: -80,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.08),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 300,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.05),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 10,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.06),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(
                                            product.name ?? '',
                                            enableInteractiveSelection: false,
                                            focusNode: _focusNode,
                                            // contextMenuBuilder:
                                            //     (context, editableTextState) {

                                            //   final TextEditingValue value =
                                            //       editableTextState
                                            //           .textEditingValue;
                                            //   final List<ContextMenuButtonItem>
                                            //       buttonItems = [];

                                            //   buttonItems.insert(
                                            //       0,
                                            //       ContextMenuButtonItem(
                                            //         label: 'Copy',
                                            //         onPressed: () {
                                            //           Clipboard.setData(
                                            //               ClipboardData(
                                            //                   text: product
                                            //                       .name));
                                            //           _focusNode.unfocus();
                                            //           ContextMenuController
                                            //               .removeAny();

                                            //         },
                                            //       ));

                                            //   return AdaptiveTextSelectionToolbar
                                            //       .buttonItems(
                                            //     anchors: editableTextState
                                            //         .contextMenuAnchors,
                                            //     buttonItems: buttonItems,
                                            //   );
                                            // },
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: dataAppCustomerController.badge.value
                                                  .statusCollaborator ==
                                              1 ||
                                          dataAppCustomerController
                                                  .badge.value.statusAgency ==
                                              1
                                      ? 70
                                      : 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      product.productDiscount == null
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Text(
                                                "${SahaStringUtils().convertToMoney(product.minPrice)}₫ - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                                                style: TextStyle(
                                                    decoration:
                                                        product.minPrice == 0
                                                            ? null
                                                            : TextDecoration
                                                                .lineThrough,
                                                    color:
                                                        product.productDiscount ==
                                                                null
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        product.productDiscount ==
                                                                null
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
                                          dataAppCustomerController.badge.value
                                                  .statusCollaborator ==
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                    child: Text(
                                                      priceRose(),
                                                      style: TextStyle(
                                                          color: Colors.pink,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                    child: Text(
                                                      "${textMoneyAgency()}",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                      ModalBottomOptionBuyProduct
                                          .showModelOption(
                                              textButton: "Thêm vào giỏ hàng",
                                              product: product,
                                              isOnlyAddToCart: false,
                                              onSubmit: (int quantity,
                                                  Product product,
                                                  List<DistributesSelected>
                                                      distributesSelected,
                                                  bool? buyNow) async {
                                                Get.back();
                                                await cartController
                                                    .addItemCart(
                                                        product.id,
                                                        quantity,
                                                        distributesSelected);
                                                dataAppCustomerController
                                                    .getBadge();
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          product.productDiscount != null
              ? Stack(
                  children: [
                    Positioned(
                      top: -5,
                      left: -13,
                      child: Stack(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SvgPicture.asset(
                                "packages/sahashop_customer/assets/icons/rectangle.svg",
                                color: Color(0xffd70c10),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15.5,
                            right: 4,
                            child: Text(
                              "-${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "nunito_bold",
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 0,
                      child: Container(
                        height: 5,
                        width: 4,
                        child: SvgPicture.asset(
                          "packages/sahashop_customer/assets/icons/levels.svg",
                          color: Color(0xffd70c10),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          if (product.hasInCombo == true ||
              product.hasInDiscount == true ||
              product.hasInBonusProduct == true)
            Positioned(
              bottom: dataAppCustomerController
                              .badge.value.statusCollaborator ==
                          1 ||
                      dataAppCustomerController.badge.value.statusAgency == 1
                  ? 130
                  : 110,
              left: 10,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (product.hasInCombo == true)
                        Container(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          height: 15,
                          child: Center(
                            child: Text(
                              "Combo",
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge!
                                      .color),
                            ),
                          ),
                        ),
                      if (product.hasInDiscount == true)
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
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
                      if (product.hasInBonusProduct == true)
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          height: 15,
                          child: Center(
                            child: Text(
                              "Thưởng SP",
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge!
                                      .color),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          if (product.isTopSale == true)
            Positioned(
              bottom: dataAppCustomerController
                              .badge.value.statusCollaborator ==
                          1 ||
                      dataAppCustomerController.badge.value.statusAgency == 1
                  ? 130
                  : 110,
              right: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600]!.withOpacity(0.5),
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
                  ),
                ],
              ),
            ),
          if (product.productDiscount != null)
            Positioned(
              top: 0,
              right: 1,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.lightBlue),
                child: Text(
                  "MỚI RA MẮT",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
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

class CustomToolTip extends StatelessWidget {
  String text;

  CustomToolTip({required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Tooltip(
          preferBelow: false,
          message: "Copy",
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            maxLines: 2,
          )),
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
      },
    );
  }
}
