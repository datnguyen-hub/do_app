import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/input_model.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/list_product_rose/product_ctv_screen/product_ctv_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class ProductItemCtv extends StatelessWidget {
  ProductItemCtv({
    Key? key,
    required this.product,
    this.width,
  }) : super(key: key);

  Product product;
  double? width;

  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
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
                      dataAppCustomerController.inputModelProduct =
                          InputModelProduct(product: product);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCtvScreen()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            height: 180,
                            width: Get.width,
                            fit: BoxFit.cover,
                            imageUrl: product.images!.length == 0
                                ? ""
                                : product.images![0].imageUrl!,
                            placeholder: (context, url) =>
                                SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                        ), //product.images[0].imageUrl
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name ?? "",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                      ),
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
                            Expanded(
                              child: Container(
                                height: 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Text(
                                        product.productDiscount == null
                                            ? "${SahaStringUtils().convertToMoney(product.price)}₫"
                                            : "${SahaStringUtils().convertToMoney(product.productDiscount!.discountPrice)}₫",
                                        style: TextStyle(
                                            color: SahaColorUtils()
                                                .colorPrimaryTextWithWhiteBackground(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                        maxLines: 1,
                                      ),
                                    ),
                                    if (product.percentCollaborator != null)
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
                                                      color: Colors.grey),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  child: Text(
                                                    "${SahaStringUtils().convertToMoney(product.price! * (product.percentCollaborator! / 100))}₫",
                                                    style: TextStyle(
                                                        color: Colors.pink,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: Container(
                            //     padding: const EdgeInsets.all(7),
                            //     decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Theme.of(context).primaryColor),
                            //     child: InkWell(
                            //       onTap: () {
                            //         ModalBottomOptionBuyProduct.showModelOption(
                            //             textButton: "Thêm vào giỏ hàng",
                            //             product: product,
                            //             onSubmit: (int quantity,
                            //                 Product product,
                            //                 List<DistributesSelected>
                            //                 distributesSelected) {
                            //               cartController.addItemCart(
                            //                   product.id, quantity, distributesSelected);
                            //               dataAppCustomerController.getBadge();
                            //               Get.back();
                            //             });
                            //       },
                            //       child: Container(
                            //         height: 15,
                            //         width: 15,
                            //         child: SvgPicture.asset(
                            //           "packages/sahashop_customer/assets/icons/cart_icon.svg",
                            //           color: Theme.of(context)
                            //               .primaryTextTheme
                            //               .headline6!
                            //               .color,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
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
                                right: 10.5,
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
                                right: 11,
                                child: Text(
                                  "${product.productDiscount!.value} %",
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
                            top: 16,
                            right: 5,
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
                  bottom: 120,
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
}
