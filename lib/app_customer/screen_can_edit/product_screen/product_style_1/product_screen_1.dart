import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/components/text/text_money.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home/home_body.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/widget/review_product.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/chat_customer_screen/chat_user_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/combo_detail_screen/combo_detail_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/product_watch_more/product_watch_more_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../../../components/image/show_image.dart';
import '../../../screen_default/bonus_product/bonus_product_screen.dart';
import '../../../screen_default/confirm_screen/confirm_screen.dart';
import '../../../screen_default/product_qr/share_qr_screen.dart';
import '../bottom_bar_ctv.dart';
import '../buy_medicine.dart';
import '../product_controller.dart';
import '../widget/video_widget.dart';

class ProductScreen1 extends StatefulWidget {
  @override
  State<ProductScreen1> createState() => _ProductScreen1State();
}

class _ProductScreen1State extends State<ProductScreen1> {
  late ProductController productController;
  DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  void initState() {
    super.initState();
    productController = ProductController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(
                () => !productController.isLoadingProduct.value
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              CarouselSlider(
                                  options: CarouselOptions(
                                      height: Get.height * 0.45,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      onPageChanged: (index, reason) {
                                        productController
                                            .changeIndexImage(index);
                                      }),
                                  items: [
                                    if (productController
                                                .productShow.value.videoUrl !=
                                            null &&
                                        productController
                                                .productShow.value.videoUrl !=
                                            '')
                                      VideoProduct(
                                          linkVideo: productController
                                              .productShow.value.videoUrl,
                                          listImageUrl: (productController
                                                      .productShow
                                                      .value
                                                      .images ??
                                                  [])
                                              .map((e) => e.imageUrl ?? '')
                                              .toList()),
                                    ...(productController
                                                .productShow.value.images ??
                                            [])
                                        .map((item) => InkWell(
                                              onTap: () {
                                                ShowImage().seeImage(
                                                    listImageUrl:
                                                        (productController
                                                                    .productShow
                                                                    .value
                                                                    .images ??
                                                                [])
                                                            .map((e) =>
                                                                e.imageUrl ??
                                                                '')
                                                            .toList(),
                                                    index: (productController
                                                                .productShow
                                                                .value
                                                                .images ??
                                                            [])
                                                        .indexOf(item));
                                              },
                                              child: Container(
                                                child: Stack(
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () {
                                                        ShowImage
                                                            .seeImageWithVideo(
                                                                listImageUrl: (productController
                                                                            .productShow
                                                                            .value
                                                                            .images ??
                                                                        [])
                                                                    .map((e) =>
                                                                        e.imageUrl ??
                                                                        '')
                                                                    .toList(),
                                                                linkVideo:
                                                                    productController
                                                                        .productShow
                                                                        .value
                                                                        .videoUrl,
                                                                //durationInitVideo: controllerInit.value.position,
                                                                index: (productController
                                                                            .productShow
                                                                            .value
                                                                            .images ??
                                                                        [])
                                                                    .indexOf(
                                                                        item));
                                                      },
                                                      child: Image.network(
                                                        item.imageUrl ?? '',
                                                        fit: BoxFit.cover,
                                                        width: 1000.0,
                                                        height:
                                                            Get.height * 0.45,
                                                        errorBuilder: (context,
                                                                url, error) =>
                                                            SahaEmptyImage(),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0.0,
                                                      left: 0.0,
                                                      right: 0.0,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(
                                                                  200, 0, 0, 0),
                                                              Color.fromARGB(
                                                                  0, 0, 0, 0)
                                                            ],
                                                            begin: Alignment
                                                                .bottomCenter,
                                                            end: Alignment
                                                                .topCenter,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList()
                                  ]),
                              Positioned(
                                width: Get.width,
                                bottom: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: (productController
                                              .productShow.value.images ??
                                          [])
                                      .map((url) {
                                    int index = productController
                                        .productShow.value.images!
                                        .indexOf(url);
                                    return Obx(
                                      () => Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: productController
                                                      .currentImage.value ==
                                                  index
                                              ? Color.fromRGBO(0, 0, 0, 0.9)
                                              : Color.fromRGBO(0, 0, 0, 0.4),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          productController.productShow.value.id == null
                              ? Container(
                                  child: Text("Sản phẩm đã hết hàng"),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 10),
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Text(
                                              "Yêu thích",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        productController
                                                    .productShow.value.isNew ==
                                                true
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 10),
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                  child: Text(
                                                    "Sản phẩm mới",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        productController.productShow.value
                                                    .isTopSale ==
                                                true
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 10),
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                  child: Text(
                                                    "Bán chạy",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        productController.hasInCombo.value
                                            ? Container(
                                                height: 20,
                                                margin: const EdgeInsets.only(
                                                    top: 10.0, left: 10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: SahaColorUtils()
                                                          .colorPrimaryTextWithWhiteBackground(),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      productController
                                                                  .discountComboType
                                                                  .value ==
                                                              1
                                                          ? Text(
                                                              "Combo giảm ${productController.valueComboType.value}%",
                                                              style: TextStyle(
                                                                color: SahaColorUtils()
                                                                    .colorPrimaryTextWithWhiteBackground(),
                                                                fontSize: 12,
                                                              ),
                                                            )
                                                          : Row(
                                                              children: [
                                                                Text(
                                                                  "Combo giảm ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: SahaColorUtils()
                                                                        .colorPrimaryTextWithWhiteBackground(),
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SahaMoneyText(
                                                                  sizeText: 12,
                                                                  sizeVND: 10,
                                                                  price: productController
                                                                      .valueComboType
                                                                      .value
                                                                      .toDouble(),
                                                                  color: SahaColorUtils()
                                                                      .colorPrimaryTextWithWhiteBackground(),
                                                                ),
                                                              ],
                                                            ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    if (productController
                                            .bonusProduct.value.id !=
                                        null)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 15),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    BonusProductLockScreen(
                                                      product: productController
                                                          .productShow.value,
                                                    ));
                                              },
                                              child: Container(
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: SahaColorUtils()
                                                          .colorPrimaryTextWithWhiteBackground(),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Tặng thưởng sản phẩm",
                                                            style: TextStyle(
                                                              color: SahaColorUtils()
                                                                  .colorPrimaryTextWithWhiteBackground(),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, top: 10),
                                      child: Row(
                                        children: [
                                          if (dataAppCustomerController.webTheme
                                                  .value.isShowProductView ==
                                              true)
                                            Text(
                                              "Lượt xem: ${productController.productShow.value.view ?? 0}",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          if (dataAppCustomerController
                                                      .webTheme
                                                      .value
                                                      .isShowProductView ==
                                                  true &&
                                              dataAppCustomerController
                                                      .webTheme
                                                      .value
                                                      .isShowProductSold ==
                                                  true)
                                            Text(" - "),
                                          if (dataAppCustomerController.webTheme
                                                  .value.isShowProductSold ==
                                              true)
                                            Text(
                                                "Lượt mua: ${productController.productShow.value.sold ?? 0}",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SelectableText(
                                        "${productController.productShow.value.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              productController.productShow
                                                          .value.minPrice !=
                                                      productController
                                                          .productShow
                                                          .value
                                                          .maxPrice
                                                  ? Row(
                                                      children: [
                                                        SahaMoneyText(
                                                          price: checkMinMaxPrice(
                                                              productController
                                                                  .productShow
                                                                  .value
                                                                  .minPrice),
                                                          color: SahaColorUtils()
                                                              .colorPrimaryTextWithWhiteBackground(),
                                                        ),
                                                        Text(
                                                          " - ",
                                                          style: TextStyle(
                                                            color: SahaColorUtils()
                                                                .colorPrimaryTextWithWhiteBackground(),
                                                          ),
                                                        ),
                                                        SahaMoneyText(
                                                          price: checkMinMaxPrice(
                                                              productController
                                                                  .productShow
                                                                  .value
                                                                  .maxPrice),
                                                          color: SahaColorUtils()
                                                              .colorPrimaryTextWithWhiteBackground(),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        if (productController
                                                                .productShow
                                                                .value
                                                                .productDiscount !=
                                                            null)
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "₫${SahaStringUtils().convertToMoney(productController.productShow.value.minPrice ?? 0)}",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              Text(
                                                                " - ",
                                                                style:
                                                                    TextStyle(
                                                                  color: SahaColorUtils()
                                                                      .colorPrimaryTextWithWhiteBackground(),
                                                                ),
                                                              ),
                                                              Text(
                                                                "₫${SahaStringUtils().convertToMoney(productController.productShow.value.maxPrice ?? 0)}",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "-${SahaStringUtils().convertToMoney(productController.productShow.value.productDiscount?.value ?? 0)}%",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: SahaColorUtils()
                                                                        .colorPrimaryTextWithWhiteBackground()),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    )
                                                  : productController
                                                              .productShow
                                                              .value
                                                              .minPrice ==
                                                          0
                                                      ? Text(
                                                          "Giá: Liên hệ",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Theme.of(context)
                                                                        .primaryColor
                                                                        .computeLuminance() >
                                                                    0.5
                                                                ? Colors.black
                                                                : Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                          ),
                                                        )
                                                      : productController
                                                                  .productShow
                                                                  .value
                                                                  .productDiscount !=
                                                              null
                                                          ? Row(
                                                              children: [
                                                                SahaMoneyText(
                                                                  price: productController
                                                                          .productShow
                                                                          .value
                                                                          .productDiscount
                                                                          ?.discountPrice ??
                                                                      0,
                                                                  color: SahaColorUtils()
                                                                      .colorPrimaryTextWithWhiteBackground(),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  "₫${SahaStringUtils().convertToMoney(productController.productShow.value.maxPrice ?? 0)}",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  "-${SahaStringUtils().convertToMoney(productController.productShow.value.productDiscount?.value ?? 0)}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: SahaColorUtils()
                                                                          .colorPrimaryTextWithWhiteBackground()),
                                                                ),
                                                              ],
                                                            )
                                                          : SahaMoneyText(
                                                              price: productController
                                                                      .productShow
                                                                      .value
                                                                      .maxPrice ??
                                                                  0,
                                                              color: SahaColorUtils()
                                                                  .colorPrimaryTextWithWhiteBackground(),
                                                            ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (dataAppCustomerController
                                            .badge.value.statusCollaborator ==
                                        1)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0,
                                            top: 8,
                                            right: 8,
                                            bottom: 0),
                                        child: Row(
                                          children: [
                                            moneyRose(),
                                            Text(
                                              " (Hoa hồng)",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (dataAppCustomerController
                                            .badge.value.statusAgency ==
                                        1)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0,
                                            top: 8,
                                            right: 8,
                                            bottom: 0),
                                        child: Row(
                                          children: [
                                            productController.productShow.value
                                                        .minPriceBeforeOverride !=
                                                    productController
                                                        .productShow
                                                        .value
                                                        .maxPriceBeforeOverride
                                                ? Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5.0,
                                                                right: 5.0),
                                                        child: Text(
                                                          "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride) ?? 0))}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Text(
                                                        "-",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                        maxLines: 1,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5.0,
                                                                right: 5.0),
                                                        child: Text(
                                                          "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.maxPriceBeforeOverride) ?? 0)}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                    child: Text(
                                                      "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride ?? 0)!)}",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                            Text(
                                              " (Giá bán lẻ)",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (dataAppCustomerController
                                                .badge.value.statusAgency ==
                                            1 &&
                                        (productController.productShow.value
                                                    .percentAgency ??
                                                0) >
                                            0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            top: 8,
                                            right: 8,
                                            bottom: 0),
                                        child: Row(
                                          children: [
                                            productController.productShow.value
                                                        .minPriceBeforeOverride !=
                                                    productController
                                                        .productShow
                                                        .value
                                                        .maxPriceBeforeOverride
                                                ? Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 0,
                                                                right: 5.0),
                                                        child: Text(
                                                          "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride)!) * (productController.productShow.value.percentAgency! / 100))}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.pink,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Text(
                                                        "-",
                                                        style: TextStyle(
                                                            color: Colors.pink,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                        maxLines: 1,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 0,
                                                                right: 5.0),
                                                        child: Text(
                                                          "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.maxPriceBeforeOverride)!) * (productController.productShow.value.percentAgency! / 100))}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.pink,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5.0),
                                                    child: Text(
                                                      "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride!)! * (productController.productShow.value.percentAgency! / 100))}",
                                                      style: TextStyle(
                                                          color: Colors.pink,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                            Text(
                                              " (Hoa hồng giới thiệu)",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: productController
                                                            .averagedStars
                                                            .value ==
                                                        0
                                                    ? 5
                                                    : productController
                                                        .averagedStars.value,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 15.0,
                                                direction: Axis.horizontal,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              if (productController
                                                      .totalReview.value !=
                                                  0)
                                                Text(
                                                    "${productController.totalReview.value}"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 1,
                                                height: 13,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Top phổ biến"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: !(productController
                                                            .productShow
                                                            .value
                                                            .isFavorite ??
                                                        true)
                                                    ? InkWell(
                                                        onTap: () {
                                                          productController
                                                              .favoriteProduct(
                                                                  true);
                                                        },
                                                        child: SvgPicture.asset(
                                                          "packages/sahashop_customer/assets/icons/heart.svg",
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          productController
                                                              .favoriteProduct(
                                                                  false);
                                                        },
                                                        child: SvgPicture.asset(
                                                          "packages/sahashop_customer/assets/icons/heart_fill.svg",
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ChatCustomerScreen());
                                                },
                                                icon: Icon(
                                                  Icons.chat_outlined,
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground(),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Get.to(() => ShareQrScreen(
                                                        listImage: (productController
                                                                    .productShow
                                                                    .value
                                                                    .images ??
                                                                [])
                                                            .map((e) =>
                                                                e.imageUrl ??
                                                                '')
                                                            .toList(),
                                                        idProduct:
                                                            productController
                                                                    .productInput
                                                                    ?.id ??
                                                                0,
                                                      ));
                                                },
                                                icon: Icon(
                                                  Icons.share,
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground(),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 8,
                                      color: Colors.grey[200],
                                    ),
                                    productController.hasInCombo.value
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0,
                                                right: 10.0,
                                                left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    productController
                                                                .discountComboType
                                                                .value ==
                                                            1
                                                        ? Text(
                                                            "Mua đủ Combo giảm ${productController.valueComboType.value}%",
                                                          )
                                                        : Row(
                                                            children: [
                                                              Text(
                                                                "Mua đủ Combo giảm ",
                                                              ),
                                                              SahaMoneyText(
                                                                sizeText: 14,
                                                                sizeVND: 12,
                                                                price: productController
                                                                    .valueComboType
                                                                    .value
                                                                    .toDouble(),
                                                              ),
                                                            ],
                                                          ),
                                                    Row(
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                ComboDetailScreen(
                                                                  idProduct:
                                                                      productController
                                                                          .productShow
                                                                          .value
                                                                          .id,
                                                                ));
                                                          },
                                                          child: Text(
                                                              "Xem tất cả"),
                                                        ),
                                                        Container(
                                                            height: 10,
                                                            width: 10,
                                                            child: SvgPicture
                                                                .asset(
                                                              "packages/sahashop_customer/assets/icons/right_arrow.svg",
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: Get.width / 3 - 10,
                                                  width: Get.width,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: productController
                                                                .listProductCombo
                                                                .length >
                                                            3
                                                        ? 3
                                                        : productController
                                                            .listProductCombo
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Image.network(
                                                          productController
                                                                      .listProductCombo[
                                                                          index]
                                                                      .product!
                                                                      .images!
                                                                      .length !=
                                                                  0
                                                              ? productController
                                                                  .listProductCombo[
                                                                      index]
                                                                  .product!
                                                                  .images![0]
                                                                  .imageUrl!
                                                              : "",
                                                          fit: BoxFit.cover,
                                                          width: Get.width / 3 -
                                                              10,
                                                          height:
                                                              Get.width / 3 -
                                                                  10,
                                                          errorBuilder: (context,
                                                                  url, error) =>
                                                              SahaEmptyImage(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    productController.hasInCombo.value
                                        ? Container(
                                            height: 8,
                                            color: Colors.grey[200],
                                          )
                                        : Container(),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 10, left: 10),
                                      child: Text(
                                        "Chi tiết sản phẩm",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    productController.productShow.value
                                                    .attributes ==
                                                null ||
                                            productController.productShow.value
                                                .attributes!.isEmpty
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Column(
                                                children:
                                                    productController
                                                        .productShow
                                                        .value
                                                        .attributes!
                                                        .toList()
                                                        .map((attribute) => Row(
                                                              children: [
                                                                SizedBox(
                                                                    width: 20),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      attribute
                                                                          .name!,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey[600]),
                                                                    )),
                                                                Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                        attribute
                                                                            .value!)),
                                                              ],
                                                            ))
                                                        .toList(),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 10.0, top: 5.0),
                                      child: ExpandableNotifier(
                                        child: ScrollOnExpand(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expandable(
                                                collapsed: Column(
                                                  children: [
                                                    Divider(
                                                      height: 1,
                                                    ),
                                                    Container(
                                                      height: productController
                                                                  .productShow
                                                                  .value
                                                                  .description ==
                                                              null
                                                          ? 0
                                                          : 100,
                                                      child: IgnorePointer(
                                                        ignoring: false,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: HtmlWidget(
                                                            productController
                                                                    .productShow
                                                                    .value
                                                                    .description ??
                                                                " ",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                expanded: IgnorePointer(
                                                  ignoring: false,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Divider(
                                                          height: 1,
                                                        ),
                                                        Container(
                                                          child: HtmlWidget(
                                                            productController
                                                                    .productShow
                                                                    .value
                                                                    .description ??
                                                                " ",
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Builder(
                                                    builder: (context) {
                                                      var controller =
                                                          ExpandableController
                                                              .of(context,
                                                                  required:
                                                                      false)!;
                                                      return Container(
                                                        child: TextButton(
                                                          child: Text(
                                                            controller.expanded
                                                                ? "Thu gọn"
                                                                : "Xem thêm",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .deepPurple),
                                                          ),
                                                          onPressed: () {
                                                            controller.toggle();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      height: 8,
                                    ),
                                    ReviewProduct(
                                      idProduct:
                                          productController.productInput == null
                                              ? 0
                                              : productController
                                                  .productInput!.id,
                                      averagedStars: productController
                                                  .averagedStars.value ==
                                              0
                                          ? 5
                                          : productController
                                              .averagedStars.value,
                                      totalReview:
                                          productController.totalReview.value,
                                      listAllImage:
                                          productController.listAllImageReview,
                                      listReview: productController.listReview,
                                      listImageReviewOfCustomer:
                                          productController
                                              .listImageReviewOfCustomer,
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      height: 8,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: SectionTitle(
                                              title: "Sản phẩm tương tự",
                                              titleEnd: "Xem tất cả",
                                              pressTitleEnd: () {
                                                Get.to(() =>
                                                    ProductWatchMoreScreen(
                                                      title:
                                                          "Sản phẩm tương tự",
                                                      listProduct:
                                                          productController
                                                              .listProductSimilar,
                                                    ));
                                              }),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 300,
                                          alignment: Alignment.topLeft,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: productController
                                                  .listProductSimilar
                                                  .map((product) =>
                                                      ProductItemWidget(
                                                        width: 180,
                                                        product: product,
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    productController
                                                .listProductWatched.isEmpty ||
                                            productController.listProductWatched
                                                    .length ==
                                                0
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(height: 20),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: SectionTitle(
                                                    title: "Sản phẩm vừa xem",
                                                    titleEnd: "Xem tất cả",
                                                    pressTitleEnd: () {
                                                      Get.to(() =>
                                                          ProductWatchMoreScreen(
                                                            title:
                                                                "Sản phẩm vừa xem",
                                                            listProduct:
                                                                productController
                                                                    .listProductWatched,
                                                          ));
                                                    }),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                height: 300,
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: productController
                                                        .listProductWatched
                                                        .map((product) =>
                                                            ProductItemWidget(
                                                              width: 180,
                                                              product: product,
                                                            ))
                                                        .toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                )
                        ],
                      )
                    : Container(
                        width: Get.width,
                        height: Get.height,
                        child: Center(
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
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
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .color,
                        size: 20,
                      ),
                    ),
                  ),
                  Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => CartScreen());
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: Container(
                                height: 25,
                                width: 25,
                                child: SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/cart_icon.svg",
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleLarge!
                                        .color),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () =>
                            productController.cartController.listOrder.length !=
                                    0
                                ? Positioned(
                                    top: -3,
                                    right: 0,
                                    child: Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF4848),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1.5, color: Colors.white),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${productController.cartController.listOrder.length}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            height: 1,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                  top: productController.animateAddCart.value
                      ? 45
                      : Get.height - AppBar().preferredSize.height,
                  left: productController.animateAddCart.value
                      ? Get.width - 25
                      : 10,
                  height: productController.animateAddCart.value
                      ? 0
                      : Get.width * 0.5,
                  width: productController.animateAddCart.value
                      ? 0
                      : Get.width * 0.5,
                  child: productController.animateAddCart.value
                      ? Image.network(
                          productController.productShow.value.images!.length !=
                                  0
                              ? productController
                                  .productShow.value.images![0].imageUrl!
                              : "",
                          fit: BoxFit.cover,
                          width: 1000.0,
                          height: Get.height * 0.45,
                          errorBuilder: (context, url, error) =>
                              SahaEmptyImage(),
                        )
                      : Container(),
                  duration: Duration(milliseconds: 500)),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => dataAppCustomerController.badge.value.statusCollaborator == 1 ||
                  dataAppCustomerController.badge.value.statusAgency == 1
              ? BottomBarCtv(
                  productController: productController,
                )
              : productController.productShow.value.isMedicine == true
                  ? Container(
                      height: 65,
                      color: Colors.white,
                      child: Column(
                        children: [
                          BuyMedicine(),
                        ],
                      ))
                  : Container(
                      height: 65,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              height: 50,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ChatCustomerScreen());
                                                },
                                                child: Container(
                                                  height: 20,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: SvgPicture.asset(
                                                      "packages/sahashop_customer/assets/icons/chat.svg",
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleLarge!
                                                          .color,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.grey[700],
                                            width: 1,
                                            height: 30,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Obx(
                                              () => !productController
                                                      .animateAddCart.value
                                                  ? InkWell(
                                                      onTap: () {
                                                        if (productController
                                                                .isLoadingProduct
                                                                .value ==
                                                            false) {
                                                          ModalBottomOptionBuyProduct
                                                              .showModelOption(
                                                                  product:
                                                                      productController
                                                                          .productShow.value,
                                                                  isOnlyAddToCart:
                                                                      true,
                                                                  onSubmit: (int
                                                                          quantity,
                                                                      Product
                                                                          product,
                                                                      List<DistributesSelected>
                                                                          distributesSelected,
                                                                      bool?
                                                                          buyNow) async {
                                                                    await productController.addManyItemOrUpdate(
                                                                        quantity:
                                                                            quantity,
                                                                        buyNow:
                                                                            false,
                                                                        productId:
                                                                            product
                                                                                .id!,
                                                                        distributesSelected:
                                                                            distributesSelected);
                                                                    productController
                                                                        .animatedAddCard();
                                                                    dataAppCustomerController
                                                                        .getBadge();
                                                                  });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        child: SvgPicture.asset(
                                                          "packages/sahashop_customer/assets/icons/add_to_cart.svg",
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .titleLarge!
                                                              .color,
                                                        ),
                                                      ),
                                                    )
                                                  : IgnorePointer(
                                                      child: Container(
                                                        height: 25,
                                                        child: SvgPicture.asset(
                                                          "packages/sahashop_customer/assets/icons/add_to_cart.svg",
                                                          color: Theme.of(
                                                                  Get.context!)
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
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      if (productController
                                              .isLoadingProduct.value ==
                                          false) {
                                        ModalBottomOptionBuyProduct
                                            .showModelOption(
                                                product: productController
                                                    .productShow.value,
                                                isOnlyAddToCart: false,
                                                onSubmit: (int quantity,
                                                    Product product,
                                                    List<DistributesSelected>
                                                        distributesSelected,
                                                    bool? buyNow) async {
                                                  await productController
                                                      .addManyItemOrUpdate(
                                                          quantity: quantity,
                                                          buyNow: buyNow,
                                                          productId:
                                                              product.id!,
                                                          distributesSelected:
                                                              distributesSelected);
                                                  dataAppCustomerController
                                                      .getBadge();
                                                });
                                      }
                                    },
                                    child: Container(
                                        height: 50,
                                        color: Theme.of(context).primaryColor,
                                        child: Center(
                                            child: Text(
                                          "Mua ngay",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleLarge!
                                                  .color),
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
        ));
  }

  double? checkMinMaxPrice(double? price) {
    return productController.productShow.value.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) *
                (productController.productShow.value.productDiscount!.value! /
                    100)));
  }

  //print(productController.productShow.value.productDiscount!.value!);

  Widget moneyRose() {
    return productController.productShow.value.typeShareCollaboratorNumber == 0
        ? productController.productShow.value.minPrice !=
                productController.productShow.value.maxPrice
            ? Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.minPrice)!) * (productController.productShow.value.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    maxLines: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.maxPrice)!) * (productController.productShow.value.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  "đ ${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPrice)! * (productController.productShow.value.percentCollaborator! / 100))}",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  maxLines: 1,
                ),
              )
        : Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(
              "₫${SahaStringUtils().convertToMoney(productController.productShow.value.moneyAmountCollaborator ?? 0)}",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              maxLines: 1,
            ),
          );
  }

  Widget moneyRose1() {
    return productController.productShow.value.typeShareCollaboratorNumber == 0
        ? productController.productShow.value.minPrice !=
                productController.productShow.value.maxPrice
            ? Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.maxPrice)!) * (productController.productShow.value.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    maxLines: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.maxPrice)!) * (productController.productShow.value.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  "${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPrice ?? 0))}",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  maxLines: 1,
                ),
              )
        : Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(
              "₫${SahaStringUtils().convertToMoney(productController.productShow.value.moneyAmountCollaborator ?? 0)}",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              maxLines: 1,
            ),
          );
  }
}
