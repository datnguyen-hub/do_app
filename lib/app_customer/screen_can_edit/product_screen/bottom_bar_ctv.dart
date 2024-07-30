import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/list_product_rose/item/content_ctv.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

import 'buy_medicine.dart';

class BottomBarCtv extends StatelessWidget {
  ProductController productController;
  BottomBarCtv({required this.productController});
  DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.isLoadingProduct.value
          ? const SizedBox()
          : productController.productShow.value.isMedicine == true
              ? BuyMedicine()
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
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    ModalBottomOptionBuyProduct.showModelOption(
                                        product:
                                            productController.productShow.value,
                                        isOnlyAddToCart: true,
                                        onSubmit: (int quantity,
                                            Product product,
                                            List<DistributesSelected>
                                                distributesSelected,
                                            bool? buyNow) async {
                                          await productController
                                              .addManyItemOrUpdate(
                                                  quantity: quantity,
                                                  buyNow: false,
                                                  productId: product.id!,
                                                  distributesSelected:
                                                      distributesSelected);
                                          productController.animatedAddCard();
                                          dataAppCustomerController.getBadge();
                                        });
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/style_7/cart_plus.svg",
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
                                  if (productController
                                          .isLoadingProduct.value ==
                                      false) {
                                    Get.to(() => ContentCtv(
                                          productShow: productController
                                              .productShow.value,
                                        ));
                                  }
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
                                  if (productController
                                          .isLoadingProduct.value ==
                                      false) {
                                    ModalBottomOptionBuyProduct.showModelOption(
                                        product:
                                            productController.productShow.value,
                                        isOnlyAddToCart: false,
                                        onSubmit: (int quantity,
                                            Product product,
                                            List<DistributesSelected>
                                                distributesSelected,
                                            bool? buyNow) {
                                          productController.addManyItemOrUpdate(
                                              quantity: quantity,
                                              buyNow: buyNow,
                                              productId: product.id!,
                                              lineItemId: null,
                                              distributesSelected:
                                                  distributesSelected);
                                        });
                                  }
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
}
