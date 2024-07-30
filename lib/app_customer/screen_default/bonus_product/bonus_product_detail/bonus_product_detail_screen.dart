import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/bonus_product.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_container.dart';
import '../../../model/product.dart';
import '../../../screen_can_edit/product_screen/product_screen.dart';
import '../../../utils/string_utils.dart';
import '../../cart_screen/cart_controller.dart';
import '../../data_app_controller.dart';

class BonusProductDetailScreen extends StatelessWidget {
  BonusProduct bonusProduct;

  BonusProductDetailScreen({required this.bonusProduct});

  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chương trình thưởng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 5,
                right: 5,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                        bonusProduct.ladderReward == true
                            ? 'Mua sản phẩm sau:'
                            : 'Mua các sản phẩm sau:',
                        style: TextStyle(color: Colors.red, fontSize: 15)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (bonusProduct.ladderReward != true)
              Container(
                  width: Get.width,
                  child: Wrap(
                    children: [
                      ...bonusProduct.selectProducts!
                          .map(
                              (e) => productsApplyVouchers(product: e.product!, quantity: e.quantity))
                          .toList(),
                    ],
                  )),
            if ((bonusProduct.bonusProductsLadder ?? []).isNotEmpty &&
                bonusProduct.ladderReward == true)
              Container(
                width: Get.width,
                child: Wrap(
                  children: [
                    productsApplyVouchers(
                      product: bonusProduct.bonusProductsLadder![0].product!,
                    ),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 5,
                right: 5,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Text('Được tặng:',
                        style: TextStyle(fontSize: 15, color: Colors.red)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (bonusProduct.ladderReward != true)
              Container(
                  width: Get.width,
                  child: Wrap(
                    children: [
                      ...bonusProduct.bonusProducts!
                          .map((e) => productsApplyVouchers(
                              product: e.product!, quantity: e.quantity))
                          .toList(),
                    ],
                  )),
            if (bonusProduct.ladderReward == true)
              Container(
                  width: Get.width,
                  child: Wrap(
                    children: [
                      ...(bonusProduct.bonusProductsLadder ?? [])
                          .map((e) => itemListOffer(e))
                          .toList(),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  Widget itemListOffer(BonusProductsLadder listOffer) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Mua từ: ${listOffer.fromQuantity ?? 0} Sản phẩm Tặng",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${listOffer.product?.name ?? ""}"),
                    if (listOffer.boElementDistributeName != null)
                      Text(
                          "Phân loại: ${listOffer.boElementDistributeName ?? ""}${listOffer.boSubElementDistributeName == null ? "" : ","} ${listOffer.boSubElementDistributeName == null ? "" : listOffer.boSubElementDistributeName}"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Text(
                "SL: ${listOffer.boQuantity ?? 0}",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget productsApplyVouchers({required Product product, int? quantity}) {
    return SizedBox(
      width: (Get.width / 2),
      child: InkWell(
        onTap: () {
          Get.to(ProductScreen(
            product: product,
          ));
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 180,
                width: Get.width,
                fit: BoxFit.cover,
                imageUrl: product.images == null
                    ? ""
                    : product.images![0].imageUrl ?? "",
                placeholder: (context, url) => SahaLoadingContainer(),
                errorWidget: (context, url, error) => SahaEmptyImage(),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.all(6),
                child: Text(
                  product.name != null ? product.name ?? "" : "",
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (quantity != null)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Số lượng: $quantity'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String? textMoney(Product product) {
    if (product.productDiscount == null) {
      return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice)}₫"}";
    } else {
      return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice! - ((product.minPrice! * product.productDiscount!.value!) / 100))}₫"}";
    }
  }

  double? checkMinMaxPrice(double? price, Product product) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }
}
