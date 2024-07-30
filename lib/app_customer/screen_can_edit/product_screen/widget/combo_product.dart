import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/text/text_money.dart';
import '../../../screen_default/combo_detail_screen/combo_detail_screen.dart';
import '../product_controller.dart';

class ComboProduct extends StatelessWidget {
  ProductController productController;

  ComboProduct({required this.productController});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Get.to(() => ComboDetailScreen(
              idProduct: productController.productShow.value.id,
            ));
      },
      child: Column(
        children: [
          Container(
            height: 8,
            color: Colors.grey[100],
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 15.0, right: 10.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        'packages/sahashop_customer/assets/style_7/combo.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    productController.discountComboType.value == 1
                        ? Text(
                            "Mua đủ Combo giảm ${productController.valueComboType.value}%",
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor),
                          )
                        : Row(
                            children: [
                              Text(
                                "Mua đủ Combo giảm ",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor),
                              ),
                              SahaMoneyText(
                                sizeText: 14,
                                sizeVND: 12,
                                price: productController.valueComboType.value
                                    .toDouble(),
                              ),
                            ],
                          ),
                    Spacer(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => ComboDetailScreen(
                                  idProduct:
                                      productController.productShow.value.id,
                                ));
                          },
                          child: Text("Xem tất cả"),
                        ),
                        Container(
                            height: 10,
                            width: 10,
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/right_arrow.svg",
                              color: Theme.of(context).primaryColor,
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
                    itemCount: productController.listProductCombo.length > 3
                        ? 3
                        : productController.listProductCombo.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.network(
                          productController.listProductCombo[index].product!
                                      .images!.length !=
                                  0
                              ? productController.listProductCombo[index]
                                  .product!.images![0].imageUrl!
                              : "",
                          fit: BoxFit.cover,
                          width: Get.width / 3 - 10,
                          height: Get.width / 3 - 10,
                          errorBuilder: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[100],
          ),
        ],
      ),
    );
  }
}
