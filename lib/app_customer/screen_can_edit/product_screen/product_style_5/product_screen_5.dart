import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
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
import 'package:video_player/video_player.dart';

import '../../../components/image/show_image.dart';
import '../../../screen_default/bonus_product/bonus_product_screen.dart';
import '../../../screen_default/confirm_screen/confirm_screen.dart';
import '../../../screen_default/product_qr/share_qr_screen.dart';
import '../bottom_bar_ctv.dart';
import '../buy_medicine.dart';
import '../product_controller.dart';
import '../widget/video_widget.dart';

// ignore: must_be_immutable
class ProductScreen5 extends StatefulWidget {
  ProductScreen5({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductScreen5> createState() => _ProductScreen5State();
}

class _ProductScreen5State extends State<ProductScreen5> {
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
                                      productController.changeIndexImage(index);
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
                                                    .productShow.value.images ??
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
                                                              e.imageUrl ?? '')
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
                                                      height: Get.height * 0.45,
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
                                                      decoration: BoxDecoration(
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
                            productController.productShow.value.id == null
                                ? Container()
                                : Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                                        (productController.productShow.value
                                                        .isNew ??
                                                    false) ==
                                                true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
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
                                        (productController.productShow.value
                                                        .isTopSale ??
                                                    false) ==
                                                true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
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
                                        // Padding(
                                        //   padding: const EdgeInsets.all(10.0),
                                        //   child: Text(
                                        //     'Lượt xem: ${productController.productShow.value.view}',
                                        //     style: TextStyle(
                                        //         fontSize: 14,
                                        //         color: Colors.red,
                                        //         fontWeight: FontWeight.bold),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                            if (productController.productShow.value.images !=
                                null)
                              Positioned(
                                bottom: 0,
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 2, bottom: 2),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "${productController.currentImage.value + 1}/${productController.productShow.value.images!.length}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
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
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SelectableText(
                                            "${productController.productShow.value.name}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              child: !productController
                                                      .productShow
                                                      .value
                                                      .isFavorite!
                                                  ? InkWell(
                                                      onTap: () {
                                                        productController
                                                            .favoriteProduct(
                                                                true);
                                                      },
                                                      child: SvgPicture.asset(
                                                        "packages/sahashop_customer/assets/icons/heart.svg",
                                                        color: Colors.black87,
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
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    () => ChatCustomerScreen());
                                              },
                                              child: Icon(
                                                Ionicons.chatbox_outline,
                                                color: SahaColorUtils()
                                                    .colorPrimaryTextWithWhiteBackground(),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Get.to(() => ShareQrScreen(
                                                      listImage:
                                                          (productController
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: productController
                                                      .averagedStars.value ==
                                                  0
                                              ? 5
                                              : productController
                                                  .averagedStars.value,
                                          itemBuilder: (context, index) => Icon(
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
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Top phổ biến"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "-${SahaStringUtils().convertToMoney(productController.productShow.value.productDiscount?.value ?? 0)}%",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground()),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, top: 15),
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
                                      
                                        if (dataAppCustomerController.webTheme
                                                    .value.isShowProductView ==
                                                true &&
                                            dataAppCustomerController.webTheme
                                                    .value.isShowProductSold ==
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
                                  if (productController.bonusProduct.value.id !=
                                      null)
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0, top: 15),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(
                                                  () => BonusProductLockScreen(
                                                        product:
                                                            productController
                                                                .productShow
                                                                .value,
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
                                                      BorderRadius.circular(2)),
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
                                        left: 10.0, right: 10.0, top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        productController.productShow.value
                                                    .minPrice !=
                                                productController
                                                    .productShow.value.maxPrice
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
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13),
                                                        ),
                                                        Text(
                                                          " - ",
                                                          style: TextStyle(
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
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              )
                                            : productController.productShow
                                                        .value.minPrice ==
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
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      productController
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
                                                                      .minPrice ??
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
                                          left: 5, top: 8, right: 8, bottom: 8),
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
                                          bottom: 8),
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
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      child: Text(
                                                        "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride)!)}",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      child: Text(
                                                        "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.maxPriceBeforeOverride)!)}",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                    "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride!))}",
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
                                                color: Colors.blue),
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
                                          left: 8, right: 8, bottom: 8),
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
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5.0),
                                                      child: Text(
                                                        "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.minPriceBeforeOverride)!) * (productController.productShow.value.percentAgency! / 100))}",
                                                        style: TextStyle(
                                                            color: Colors.pink,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5.0),
                                                      child: Text(
                                                        "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.maxPriceBeforeOverride)!) * (productController.productShow.value.percentAgency! / 100))}",
                                                        style: TextStyle(
                                                            color: Colors.pink,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0, right: 5.0),
                                                  child: Text(
                                                    "₫${productController.productShow.value.typeShareCollaboratorNumber == 0 ? SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.minPrice)! * (productController.productShow.value.percentCollaborator! / 100)) : SahaStringUtils().convertToMoney(productController.productShow.value.moneyAmountCollaborator ?? 0)}",
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
                                  dataAppCustomerController.badge.value
                                                  .statusCollaborator ==
                                              1 ||
                                          dataAppCustomerController
                                                  .badge.value.statusAgency ==
                                              1
                                      ? BottomBarCtv(
                                          productController: productController,
                                        )
                                      : productController.productShow.value
                                                  .isMedicine ==
                                              true
                                          ? BuyMedicine()
                                          : Container(
                                              height: 50,
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: InkWell(
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
                                                                      false,
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
                                                                            buyNow,
                                                                        productId:
                                                                            product
                                                                                .id!,
                                                                        distributesSelected:
                                                                            distributesSelected);
                                                                    dataAppCustomerController
                                                                        .getBadge();
                                                                  });
                                                        }
                                                      },
                                                      child: Container(
                                                          height: 50,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.15),
                                                                spreadRadius: 2,
                                                                blurRadius: 2,
                                                                offset: Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Mua ngay",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: SahaColorUtils()
                                                                    .colorPrimaryTextWithWhiteBackground()),
                                                          ))),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: InkWell(
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
                                                        height: 50,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topRight,
                                                            end: Alignment
                                                                .bottomLeft,
                                                            colors: [
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                            ],
                                                          ),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.6)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.15),
                                                              spreadRadius: 2,
                                                              blurRadius: 2,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                  Ionicons
                                                                      .cart_outline,
                                                                  size: 20,
                                                                  color: SahaColorUtils()
                                                                      .colorTextWithPrimaryColor()),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                "Thêm vào \ngiỏ hàng",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: SahaColorUtils()
                                                                        .colorTextWithPrimaryColor()),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Row(
                                      children: [
                                        productController.hasInCombo.value
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => ComboDetailScreen(
                                                            idProduct:
                                                                productController
                                                                    .productShow
                                                                    .value
                                                                    .id,
                                                          ));
                                                },
                                                child: Container(
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: SahaColorUtils()
                                                              .colorPrimaryTextWithWhiteBackground()),
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
                                                                style:
                                                                    TextStyle(
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
                                                                    sizeText:
                                                                        12,
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
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
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
                                                        child:
                                                            Text("Xem tất cả"),
                                                      ),
                                                      Container(
                                                          height: 10,
                                                          width: 10,
                                                          child:
                                                              SvgPicture.asset(
                                                            "packages/sahashop_customer/assets/icons/right_arrow.svg",
                                                            color: SahaColorUtils()
                                                                .colorPrimaryTextWithWhiteBackground(),
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
                                                          const EdgeInsets.only(
                                                              right: 5),
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
                                                        width:
                                                            Get.width / 3 - 10,
                                                        height:
                                                            Get.width / 3 - 10,
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
                                  productController.listProductSimilar.length ==
                                          0
                                      ? Container()
                                      : Column(
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
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                  SizedBox(height: 10),
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
                                              children: productController
                                                  .productShow.value.attributes!
                                                  .toList()
                                                  .map((attribute) => Row(
                                                        children: [
                                                          SizedBox(width: 20),
                                                          Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                attribute.name!,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
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
                                                        ExpandableController.of(
                                                            context,
                                                            required: false)!;
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
                                    height: 8,
                                    color: Colors.grey[200],
                                  ),
                                  ReviewProduct(
                                    idProduct: productController.productInput ==
                                            null
                                        ? 0
                                        : productController.productInput!.id,
                                    averagedStars: productController
                                                .averagedStars.value ==
                                            0
                                        ? 5
                                        : productController.averagedStars.value,
                                    totalReview:
                                        productController.totalReview.value,
                                    listAllImage:
                                        productController.listAllImageReview,
                                    listReview: productController.listReview,
                                    listImageReviewOfCustomer: productController
                                        .listImageReviewOfCustomer,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  productController.listProductWatched.length ==
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
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Icon(Icons.arrow_back_ios_outlined,
                        size: 20, color: Colors.white),
                  ),
                ),
                Spacer(),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CartScreen());
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: SvgPicture.asset(
                          "packages/sahashop_customer/assets/icons/cart_icon.svg",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Obx(
                      () =>
                          productController.cartController.listOrder.length != 0
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
                        productController.productShow.value.images!.length != 0
                            ? productController
                                .productShow.value.images![0].imageUrl!
                            : "",
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: Get.height * 0.45,
                        errorBuilder: (context, url, error) => SahaEmptyImage(),
                      )
                    : Container(),
                duration: Duration(milliseconds: 500)),
          )
        ],
      ),
    );
  }

  double? checkMinMaxPrice(double? price) {
    return productController.productShow.value.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) *
                (productController.productShow.value.productDiscount!.value! /
                    100)));
  }

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
}
