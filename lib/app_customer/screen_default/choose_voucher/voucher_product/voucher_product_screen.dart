import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/model/voucher.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class VoucherProductScreen extends StatelessWidget {
  final Voucher? voucher;

  VoucherProductScreen({this.voucher});
// khai báo sẵn
  final bool? showCart = true;
  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
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
                    child: Text('Sản phẩm có thể áp dụng cho voucher này',
                        style: TextStyle()),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Wrap(
              children: [
                ...voucher!.products!
                    .map((e) => productsApplyVouchers(product: e))
                    .toList()
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget productsApplyVouchers({required Product product}) {
    return SizedBox(
      width: Get.width / 2,
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
              Container(
                padding: EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            product.minPrice == 0
                                ? "${product.price == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(product.price)}₫"} - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%"
                                : "${SahaStringUtils().convertToMoney(product.minPrice)}₫ - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                            style: TextStyle(
                                decoration: product.price == 0
                                    ? null
                                    : TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          child: Text(
                            textMoney(product)!,
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
                          Row(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hoa hồng",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    ),
                                    Text(
                                      "${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPrice, product)! * (product.percentCollaborator! / 100))}₫",
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                      ],
                    ),
                    if (showCart == true)
                      Padding(
                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: InkWell(
                            onTap: () {
                              ModalBottomOptionBuyProduct.showModelOption(
                                  textButton: "Thêm vào giỏ hàng",
                                  product: product,
                                  isOnlyAddToCart: true,
                                  onSubmit: (int quantity,
                                      Product product,
                                      List<DistributesSelected>
                                          distributesSelected,
                                      bool? buyNow) async {
                                    Get.back();
                                    await cartController.addItemCart(product.id,
                                        quantity, distributesSelected);
                                    dataAppCustomerController.getBadge();
                                  });
                            },
                            child: Container(
                              height: 17,
                              width: 17,
                              child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/shopping_bag.svg",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? textMoney(Product product) {
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

  double? checkMinMaxPrice(double? price, Product product) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }
}
