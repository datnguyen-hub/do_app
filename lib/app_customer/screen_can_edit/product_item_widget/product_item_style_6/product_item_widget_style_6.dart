import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

class ProductItemWidgetStyle6 extends StatelessWidget {
  ProductItemWidgetStyle6({
    Key? key,
    required this.product,
    this.width,
    this.height,
    this.showCart = true,
  }) : super(key: key);

  Product product;
  double? height;
  double? width;
  bool? showCart;
  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(
                    product: product,
                  )),
        );
      },
      child: Container(
        width: width,
        height: height ??
            (dataAppCustomerController.badge.value.statusCollaborator == 1 ||
                    dataAppCustomerController.badge.value.statusAgency == 1
                ? 320
                : 295),
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0a171439),
                offset: Offset(0, 20),
                blurRadius: 17.5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 156,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.images!.length == 0
                          ? ""
                          : product.images![0].imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey[200],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
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
                                      color: product.productDiscount == null
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: product.productDiscount == null
                                          ? 14
                                          : 12),
                                ),
                              ),
                        Container(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            textMoney()!,
                            style: TextStyle(
                                height: 1,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "  Hoa hồng",
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: 11,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ModalBottomOptionBuyProduct.showModelOption(
                          textButton: "Thêm vào giỏ hàng",
                          product: product,
                          isOnlyAddToCart: false,
                          onSubmit: (int quantity,
                              Product product,
                              List<DistributesSelected> distributesSelected,
                              bool? buyNow) async {
                            Get.back();
                            await cartController.addItemCart(
                                product.id, quantity, distributesSelected);
                            dataAppCustomerController.getBadge();
                            if (buyNow == true) {
                              Get.to(() => CartScreen());
                              Get.to(() => ConfirmScreen());
                            }
                          });
                    },
                    child: SvgPicture.asset(
                      "packages/sahashop_customer/assets/style_7/cart.svg",
                      width: 20,
                      height: 20,
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
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
