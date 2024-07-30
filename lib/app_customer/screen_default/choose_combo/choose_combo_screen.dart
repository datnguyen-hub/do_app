import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/model/combo.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/choose_combo/choose_combo_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class ChooseComboScreen extends StatelessWidget {
  ChooseComboController chooseComboController = ChooseComboController();
  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Combo"),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: chooseComboController.listCombo
                .map((e) => itemCombo(e))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget itemCombo(Combo combo) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: Get.width,
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * 0.6,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          combo.name!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${SahaDateUtils().getDDMMYY(combo.startTime!)} ${SahaDateUtils().getHHMM(combo.startTime!)} - ${SahaDateUtils().getDDMMYY(combo.endTime!)} ${SahaDateUtils().getHHMM(combo.endTime!)}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        width: 55,
                        height: 55,
                        child: SvgPicture.asset(
                          "assets/icons/gift_box.svg",
                          color: Theme.of(Get.context!).primaryColor,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  combo.discountType == 1
                      ? Text(
                          "Giảm ${SahaStringUtils().convertToMoney(combo.valueDiscount ?? 0)}%",
                          style: TextStyle(
                              color: Theme.of(Get.context!).primaryColor,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          "Giảm đ${SahaStringUtils().convertToMoney(combo.valueDiscount ?? 0)}",
                          style: TextStyle(
                              color: Theme.of(Get.context!).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (combo.productsCombo != null)
                ...combo.productsCombo!
                    .map((e) => e.product!)
                    .toList()
                    .map((e) => itemProduct(e))
                    .toList(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  var index = 0;
                  bool isChoose = false;
                  combo.productsCombo!.forEach((e) async {
                    if (e.product?.distributes != null &&
                        e.product!.distributes!.isNotEmpty) {
                      isChoose = true;
                      await ModalBottomOptionBuyProduct.showModelOption(
                          textButton: "Thêm vào giỏ hàng",
                          product: e.product!,
                          quantity: e.quantity,
                          isOnlyAddToCart: true,
                          onSubmit: (int quantity,
                              Product product,
                              List<DistributesSelected> distributesSelected,
                              bool? buyNow) async {
                            index = index + 1;
                            await cartController.addItemCart(
                                product.id, quantity, distributesSelected);
                            Get.back();
                            if (index == combo.productsCombo!.length) {
                              Get.to(() => CartScreen());
                            }
                          });
                    } else {
                      cartController
                          .addItemCart(e.product!.id, e.quantity ?? 1, []);
                      index = index + 1;
                      if (index == combo.productsCombo!.length &&
                          isChoose == false) {
                        Get.to(() => CartScreen());
                      }

                      print(index);
                    }
                  });
                  // if (index == combo.productsCombo!.length && isChoose == true) {
                  //   Get.to(() => CartScreen());
                  // }
                  dataAppCustomerController.getBadge();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Mua ngay",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget itemProduct(
    Product product,
  ) {
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

    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl:
                        product.images != null && product.images!.isNotEmpty
                            ? (product.images![0].imageUrl ?? "")
                            : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
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
                        product.productDiscount == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  product.minPrice == 0
                                      ? "${product.minPrice == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(product.minPrice)}₫"}"
                                      : "${SahaStringUtils().convertToMoney(product.minPrice)}₫",
                                  style: TextStyle(
                                      decoration: product.minPrice == 0
                                          ? null
                                          : TextDecoration.lineThrough,
                                      color: product.productDiscount == null
                                          ? Theme.of(Get.context!).primaryColor
                                          : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: product.productDiscount == null
                                          ? 14
                                          : 10),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
