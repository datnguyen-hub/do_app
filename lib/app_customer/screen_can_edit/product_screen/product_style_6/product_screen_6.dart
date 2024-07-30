import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
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
import 'package:badges/badges.dart' as b;

import '../../../components/image/show_image.dart';
import '../../../screen_default/bonus_product/bonus_product_screen.dart';
import '../../../screen_default/confirm_screen/confirm_screen.dart';
import '../../../screen_default/product_qr/share_qr_screen.dart';
import '../bottom_bar_ctv.dart';
import '../buy_medicine.dart';
import '../product_controller.dart';
import '../widget/bonus_product.dart';
import '../widget/combo_product.dart';
import '../widget/description_product.dart';
import '../widget/price_product.dart';
import '../widget/video_widget.dart';

class ProductScreen6 extends StatefulWidget {
  @override
  State<ProductScreen6> createState() => _ProductScreen6State();
}

class _ProductScreen6State extends State<ProductScreen6> {
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
        body: Obx(
          () => productController.isLoadingProduct.value
              ? SahaLoadingFullScreen()
              : Stack(
                  children: [
                    SingleChildScrollView(
                        child: Stack(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 0.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.3), //color of shadow
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 7, // blur radius
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    )
                                  ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SelectableText(
                                        "${productController.productShow.value.name}",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PriceProduct(
                                            product: productController
                                                .productShow.value,
                                            dataAppCustomerController:
                                                dataAppCustomerController,
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.only(right: 10),
                                          child: !(productController.productShow
                                                      .value.isFavorite ??
                                                  true)
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
                                      ],
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 5,
                                          bottom: 5),
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
                                                itemSize: 18.0,
                                                direction: Axis.horizontal,
                                              ),
                                              if (productController
                                                      .totalReview.value !=
                                                  0)
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
                                                height: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[400]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              if (dataAppCustomerController
                                                      .webTheme
                                                      .value
                                                      .isShowProductView ==
                                                  true)
                                                Text(
                                                  "Đã xem ${productController.productShow.value.view ?? 0}",
                                                  style: TextStyle(height: 1.5),
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
                                                Text(
                                                  " - ",
                                                  style: TextStyle(height: 1.5),
                                                ),
                                              if (dataAppCustomerController
                                                      .webTheme
                                                      .value
                                                      .isShowProductSold ==
                                                  true)
                                                Text(
                                                  "Đã mua ${productController.productShow.value.sold ?? 0}",
                                                  style: TextStyle(height: 1.5),
                                                ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
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
                                                    idProduct: productController
                                                            .productInput?.id ??
                                                        0,
                                                  ));
                                            },
                                            child: SvgPicture.asset(
                                              "packages/sahashop_customer/assets/style_7/share.svg",
                                              height: 20,
                                              width: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'packages/sahashop_customer/assets/style_7/box.svg',
                                                height: 20,
                                                width: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Dễ dàng mua sắm',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'packages/sahashop_customer/assets/style_7/shield.svg',
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Chính hãng 100%',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )),
                                          // Expanded(
                                          //     child: Row(
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //       'packages/sahashop_customer/assets/style_7/car.svg',
                                          //       color: Theme.of(context)
                                          //           .primaryColor,
                                          //       height: 20,
                                          //       width: 20,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 5,
                                          //     ),
                                          //     Text(
                                          //       'Giao hàng miễn phí',
                                          //       style: TextStyle(fontSize: 12),
                                          //     ),
                                          //   ],
                                          // )),
                                        ],
                                      ),
                                    ),
                                    if (productController.hasInCombo.value)
                                      ComboProduct(
                                        productController: productController,
                                      ),
                                    if (productController
                                            .bonusProduct.value.id !=
                                        null)
                                      BonusProductWidget(
                                        bonusProduct: productController
                                            .bonusProduct.value,
                                        product:
                                            productController.productShow.value,
                                      ),
                                    if (dataAppCustomerController
                                                .badge.value.statusAgency !=
                                            1 &&
                                        dataAppCustomerController.badge.value
                                                .statusCollaborator !=
                                            1 &&
                                        productController.productShow.value
                                                .isProductRetailStep ==
                                            true)
                                      productRetail(productController
                                              .productShow
                                              .value
                                              .productRetailSteps ??
                                          []),
                                    DescriptionProduct(
                                      product:
                                          productController.productShow.value,
                                    ),
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
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
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
                                          height: dataAppCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .isCollaborator ==
                                                      true ||
                                                  dataAppCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .isAgency ==
                                                      true
                                              ? 330
                                              : 300,
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
                                                height: dataAppCustomerController
                                                                .infoCustomer
                                                                .value
                                                                .isCollaborator ==
                                                            true ||
                                                        dataAppCustomerController
                                                                .infoCustomer
                                                                .value
                                                                .isAgency ==
                                                            true
                                                    ? 330
                                                    : 300,
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
                                  ]),
                            )
                          ],
                        )
                      ],
                    )),
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
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge!
                                    .color,
                                size: 24,
                              ),
                            ),
                          ),
                          Spacer(),
                          b.Badge(
                            badgeStyle: b.BadgeStyle(
                              padding: EdgeInsets.all(4),
                            ),
                            position: b.BadgePosition.custom(
                              top: -3,
                              end: 0,
                            ),
                            badgeContent: Text(
                              '${productController.cartController.listOrder.length}',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            showBadge: productController
                                        .cartController.listOrder.length ==
                                    0
                                ? false
                                : true,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => CartScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(15)),
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
                                  productController.productShow.value.images!
                                              .length !=
                                          0
                                      ? productController.productShow.value
                                          .images![0].imageUrl!
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
                                                isOnlyAddToCart: false,
                                                product: productController
                                                    .productShow.value,
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

  Widget productRetail(List<ProductRetailStep> productRetailSteps) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Text("Mua từ")),
              Expanded(flex: 1, child: Text("Đến")),
              Expanded(flex: 2, child: Text("Đơn giá")),
            ],
          ),
          ...productRetailSteps.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text("${e.fromQuantity}")),
                    Expanded(flex: 1, child: Text("${e.toQuantity}")),
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${SahaStringUtils().convertToUnit(e.price)}đ/Sản phẩm")),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
