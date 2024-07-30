import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../model/bonus_product.dart';
import '../../../screen_default/bonus_product/bonus_product_screen.dart';
import '../../../utils/color_utils.dart';

class BonusProductWidget extends StatelessWidget {
  BonusProduct bonusProduct;
  Product product;

  BonusProductWidget({required this.bonusProduct, required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Get.to(() => BonusProductLockScreen(
              product: product,
            ));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'packages/sahashop_customer/assets/style_7/combo.svg',
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Tặng thưởng sản phẩm',
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...(bonusProduct.bonusProducts ?? []).map((e) => SizedBox(
                        width: Get.width / 2.7,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[200]!)),
                          child: Column(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(
                                (e.product!.images ?? []).isEmpty
                                    ? ""
                                    : product.images![0].imageUrl!,
                                height: 120,
                                width: double.infinity,
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
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${SahaStringUtils().convertToMoney(e.product!.price)}đ',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e.product!.name!,
                                style: TextStyle(fontSize: 13),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ]),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
