// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/list_product_rose/item/content_ctv.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/list_product_rose/product_ctv_screen/product_ctv_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/product_watch_more/product_watch_more_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class ProductCtvScreen extends StatelessWidget {
  late ProductCtvController productController;
  DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  Widget build(BuildContext context) {
    productController = ProductCtvController();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(
              () => productController.isLoadingProduct.value == false
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
                                items: productController
                                    .productShow.value.images!
                                    .map((item) => Container(
                                          child: Stack(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl: item.imageUrl!,
                                                fit: BoxFit.cover,
                                                width: 1000.0,
                                                height: Get.height * 0.45,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "packages/sahashop_customer/assets/saha_loading.png"),
                                              ),
                                              Positioned(
                                                bottom: 0.0,
                                                left: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            200, 0, 0, 0),
                                                        Color.fromARGB(
                                                            0, 0, 0, 0)
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList()),
                            Positioned(
                              width: Get.width,
                              bottom: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: productController
                                    .productShow.value.images!
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
                        Column(
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
                                      borderRadius: BorderRadius.circular(2),
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
                                productController.productShow.value.isNew! ==
                                        true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10),
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: Text(
                                            "Sản phẩm mới",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                productController
                                            .productShow.value.isTopSale! ==
                                        true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10),
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: Text(
                                            "Bán chạy",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
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
                                                BorderRadius.circular(2)),
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
                                                          style: TextStyle(
                                                            color: SahaColorUtils()
                                                                .colorPrimaryTextWithWhiteBackground(),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SahaMoneyText(
                                                          sizeText: 12,
                                                          sizeVND: 10,
                                                          price:
                                                              productController
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
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${productController.productShow.value.name}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  productController.productShow.value
                                          .distributes!.isEmpty
                                      ? Row(
                                          children: [
                                            SahaMoneyText(
                                              price: productController
                                                          .productShow
                                                          .value
                                                          .productDiscount ==
                                                      null
                                                  ? productController
                                                      .productShow.value.price
                                                  : productController
                                                      .productShow
                                                      .value
                                                      .productDiscount!
                                                      .discountPrice,
                                              color: Theme.of(context)
                                                          .primaryColor
                                                          .computeLuminance() >
                                                      0.5
                                                  ? Colors.black
                                                  : Theme.of(context)
                                                      .primaryColor,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            productController.productShow.value
                                                        .minPrice !=
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
                                                    ],
                                                  )
                                                : SahaMoneyText(
                                                    price: productController
                                                            .productShow
                                                            .value
                                                            .price ??
                                                        0,
                                                    color: SahaColorUtils()
                                                        .colorPrimaryTextWithWhiteBackground(),
                                                  ),
                                          ],
                                        ),
                                  if (productController
                                          .productShow.value.productDiscount !=
                                      null)
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        productController.productShow.value
                                                .distributes!.isEmpty
                                            ? Text(
                                                "${SahaStringUtils().convertToMoney(productController.productShow.value.price)}đ",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              )
                                            : Text("Giảm",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: SahaColorUtils()
                                                        .colorPrimaryTextWithWhiteBackground())),
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
                                ],
                              ),
                            ),
                            if (dataAppCustomerController
                                    .infoCustomer.value.isCollaborator ==
                                true)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, top: 8, right: 8, bottom: 0),
                                child: Row(
                                  children: [
                                    productController
                                                .productShow.value.minPrice !=
                                            productController
                                                .productShow.value.maxPrice
                                        ? Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: Text(
                                                  "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.minPrice)!) * (productController.productShow.value.percentCollaborator! / 100))}",
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
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                                maxLines: 1,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: Text(
                                                  "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(productController.productShow.value.maxPrice)!) * (productController.productShow.value.percentCollaborator! / 100))}",
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
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: Text(
                                              "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(productController.productShow.value.price!)! * (productController.productShow.value.percentCollaborator! / 100))}",
                                              style: TextStyle(
                                                  color: Colors.pink,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                              maxLines: 1,
                                            ),
                                          ),
                                    Text(
                                      " (Hoa hồng)",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
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
                                      if (productController.totalReview.value !=
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
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        child: !productController
                                                .productShow.value.isFavorite!
                                            ? InkWell(
                                                onTap: () {
                                                  productController
                                                      .favoriteProduct(true);
                                                },
                                                child: SvgPicture.asset(
                                                  "packages/sahashop_customer/assets/icons/heart.svg",
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  productController
                                                      .favoriteProduct(false);
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
                                          Get.to(() => ChatCustomerScreen());
                                        },
                                        icon: Icon(
                                          Icons.chat_outlined,
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
                                        bottom: 15.0, right: 10.0, left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            productController.discountComboType
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
                                                    Get.to(
                                                        () => ComboDetailScreen(
                                                              idProduct:
                                                                  productController
                                                                      .productShow
                                                                      .value
                                                                      .id,
                                                            ));
                                                  },
                                                  child: Text("Xem tất cả"),
                                                ),
                                                Container(
                                                    height: 10,
                                                    width: 10,
                                                    child: SvgPicture.asset(
                                                      "packages/sahashop_customer/assets/icons/right_arrow.svg",
                                                      color: Theme.of(context)
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
                                            scrollDirection: Axis.horizontal,
                                            itemCount: productController
                                                        .listProductCombo
                                                        .length >
                                                    3
                                                ? 3
                                                : productController
                                                    .listProductCombo.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: CachedNetworkImage(
                                                  imageUrl: productController
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
                                                  width: Get.width / 3 - 10,
                                                  height: Get.width / 3 - 10,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "packages/sahashop_customer/assets/saha_loading.png"),
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
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                            productController.productShow.value.attributes ==
                                        null ||
                                    productController
                                        .productShow.value.attributes!.isEmpty
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
                                                                  .grey[600]),
                                                        )),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            attribute.value!)),
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
                                              child: HtmlWidget(
                                                productController.productShow
                                                        .value.description ??
                                                    " ",
                                              ),
                                            ),
                                          ],
                                        ),
                                        expanded: IgnorePointer(
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
                                                    style: Theme.of(context)
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
                              idProduct: productController.productInput == null
                                  ? 0
                                  : productController.productInput!.id,
                              averagedStars:
                                  productController.averagedStars.value == 0
                                      ? 5
                                      : productController.averagedStars.value,
                              totalReview: productController.totalReview.value,
                              listAllImage:
                                  productController.listAllImageReview,
                              listReview: productController.listReview,
                              listImageReviewOfCustomer:
                                  productController.listImageReviewOfCustomer,
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
                                        Get.to(() => ProductWatchMoreScreen(
                                              title: "Sản phẩm tương tự",
                                              listProduct: productController
                                                  .listProductSimilar,
                                            ));
                                      }),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 251,
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: productController
                                          .listProductSimilar
                                          .map((product) => ProductItemWidget(
                                                width: 180,
                                                product: product,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            productController.listProductWatched.isEmpty ||
                                    productController
                                            .listProductWatched.length ==
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
                                                    title: "Sản phẩm vừa xem",
                                                    listProduct:
                                                        productController
                                                            .listProductWatched,
                                                  ));
                                            }),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 251,
                                        alignment: Alignment.topLeft,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
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
                      color:
                          Theme.of(context).primaryTextTheme.titleLarge!.color,
                      size: 20,
                    ),
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
                    ? CachedNetworkImage(
                        imageUrl: productController
                                    .productShow.value.images!.length !=
                                0
                            ? productController
                                .productShow.value.images![0].imageUrl!
                            : "",
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: Get.height * 0.45,
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      )
                    : Container(),
                duration: Duration(milliseconds: 500)),
          )
        ],
      ),
      bottomNavigationBar: Container(
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
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChatCustomerScreen());
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/chat.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {
                        Get.to(() => ContentCtv(
                              productShow: productController.productShow.value,
                            ));
                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.25),
                          ),
                          child: Center(
                              child: Text(
                            "ĐĂNG BÁN",
                            style: TextStyle(
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ))),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        ModalBottomOptionBuyProduct.showModelOption(
                            product: productController.productShow.value,
                            isOnlyAddToCart: false,
                            onSubmit: (int quantity,
                                Product product,
                                List<DistributesSelected> distributesSelected,
                                bool? buyNow) {
                              productController.addManyItemOrUpdate(
                                  quantity: quantity,
                                  buyNow: buyNow,
                                  productId: product.id!,
                                  lineItemId: null,
                                  distributesSelected: distributesSelected);
                            });
                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                              child: Text(
                            "MUA NGAY",
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
}
