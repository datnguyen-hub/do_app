import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/loading/loading_full_screen.dart';
import '../../model/bonus_product.dart';
import '../../model/product.dart';
import '../../utils/date_utils.dart';
import '../login/check_login/check_login.dart';
import 'bonus_product_controller.dart';
import 'bonus_product_detail/bonus_product_detail_screen.dart';

class BonusProductLockScreen extends StatelessWidget {
  Product? product;

  BonusProductLockScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: BonusProductScreen(product: product));
  }
}

class BonusProductScreen extends StatefulWidget {
  Product? product;

  BonusProductScreen({this.product});
  @override
  State<BonusProductScreen> createState() => _BonusProductScreenState();
}

class _BonusProductScreenState extends State<BonusProductScreen> {
  late BonusProductController bonusProductController;

  @override
  void initState() {
    bonusProductController = BonusProductController(product: widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thưởng sản phẩm"),
      ),
      body: Obx(
            () => bonusProductController.isLoading.value
            ? SahaLoadingFullScreen()
            : bonusProductController.listBonus.isEmpty
            ? Center(
          child: Text("Không có chương trình thưởng nào"),
        )
            : SingleChildScrollView(
          child: Column(
            children: bonusProductController.listBonus
                .map((e) => itemProduct(e))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget itemProduct(BonusProduct bonusProduct) {
    return InkWell(
      onTap: () {
        Get.to(() => BonusProductDetailScreen(
          bonusProduct: bonusProduct,
        ));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(Get.context!).primaryColor,
                          border: Border.all(color: Colors.grey[500]!),
                        ),
                        child: Center(
                          child: SizedBox(
                              width: 80,
                              child: Text(
                                "${bonusProduct.name ?? ""}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(Get.context!)
                                      .primaryTextTheme
                                      .titleLarge!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                              )),
                        ),
                      ),
                      Positioned(
                        height: 8,
                        width: 8,
                        top: 5,
                        left: -4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 8,
                        width: 8,
                        top: 20,
                        left: -4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 8,
                        width: 8,
                        top: 35,
                        left: -4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 8,
                        width: 8,
                        top: 50,
                        left: -4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 8,
                        width: 8,
                        top: 65,
                        left: -4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 8,
                        width: 8,
                        top: 80,
                        left: -4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${bonusProduct.name}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "HSD: ${SahaDateUtils().getDDMMYY(bonusProduct.endTime!)}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
