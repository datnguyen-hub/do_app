import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class ProductItemWidgetSale extends StatelessWidget {
  ProductItemWidgetSale({
    Key? key,
    required this.product,
    this.width,
    this.showCart = true,
  }) : super(key: key);

  Product product;
  double? width;
  bool? showCart;

  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dataAppCustomerController.badge.value.statusCollaborator == 1
          ? 200
          : 170,
      width: width,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[100]!)),
              child: Stack(
                children: [
                  InkWell(
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
                          child: CachedNetworkImage(
                            width: Get.width,
                            fit: BoxFit.cover,
                            imageUrl: product.images!.length == 0
                                ? ""
                                : product.images![0].imageUrl ?? "",
                            placeholder: (context, url) =>
                                SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                        ), //product.images[0].imageUrl
                        SizedBox(height: 5),
                        Container(
                          height: dataAppCustomerController
                                      .badge.value.statusCollaborator ==
                                  1
                              ? 85
                              : 45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
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
                                Container(
                                  height: 35,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Hoa hồng",
                                        style: TextStyle(
                                            height: 1,
                                            fontSize: 11,
                                            color: Colors.grey),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Text(
                                          "${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPrice)! * (product.percentCollaborator! / 100))}₫",
                                          style: TextStyle(
                                              color: Colors.pink,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (dataAppCustomerController
                                      .badge.value.statusCollaborator !=
                                  1)
                                SizedBox(height: 5),
                              if (dataAppCustomerController
                                      .webTheme.value.isShowProductView ==
                                  true)
                                Container(
                                  width: Get.width / 5,
                                  padding: EdgeInsets.only(
                                      top: 1, left: 10, right: 10, bottom: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Đã xem: ${product.sold ?? 0}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              if (dataAppCustomerController
                                      .badge.value.statusCollaborator !=
                                  1)
                                SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  product.productDiscount == null
                      ? Container()
                      : Positioned(
                          top: -4,
                          right: -9.75,
                          child: Stack(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/tag_ribbon.svg",
                                  color: Color(0xfffdd100),
                                ),
                              ),
                              Positioned(
                                top: 23,
                                right: 11.5,
                                child: Text(
                                  "GIẢM",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Positioned(
                                top: 7,
                                right: 14.5,
                                child: Text(
                                  "${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffd5800)),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          product.isNew == true
              ? Stack(
                  children: [
                    Positioned(
                      top: -5,
                      left: -13,
                      child: Stack(
                        clipBehavior: Clip.none,
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
                            top: 15,
                            right: 4,
                            child: Text(
                              "New",
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
          product.isTopSale == true
              ? Positioned(
                  bottom: dataAppCustomerController
                              .badge.value.statusCollaborator ==
                          1
                      ? 150
                      : 85,
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
                )
              : Container(),
        ],
      ),
    );
  }

  String? textMoney() {
    if (product.minPrice == 0) {
      if (product.productDiscount == null) {
        return "${product.price == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.price)}₫"}";
      } else {
        return "${product.productDiscount!.discountPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.productDiscount!.discountPrice)}₫"}";
      }
    } else {
      if (product.productDiscount == null) {
        return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice)}₫"}";
      } else {
        return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice! - ((product.minPrice! * product.productDiscount!.value!) / 100))}₫"}";
      }
    }
  }

  double? checkMinMaxPrice(double? price) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }
}
