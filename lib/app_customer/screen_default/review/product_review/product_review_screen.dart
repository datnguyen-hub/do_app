import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/review/product_review/product_review_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/review/product_review/review_product/review_product_screen.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../model/order.dart';

class ProductReviewScreen extends StatelessWidget {
  ProductReviewScreen({super.key, this.orderCode}) {
    controller = ProductReviewController(orderCode: orderCode);
  }
  late ProductReviewController controller;
  final String? orderCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...(controller.order.value.lineItems ?? [])
                        .map((e) => itemProduct(e))
                  ],
                ),
              ),
      ),
    );
  }

  Widget itemProduct(LineItem item) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              (item.product?.images ?? []).isEmpty
                  ? ""
                  : item.product?.images![0].imageUrl ?? '',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SahaEmptyImage(
                  height: 100,
                  width: 100,
                );
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.name ?? "Chưa có thông tin",
                  style: TextStyle(
                      color: Theme.of(Get.context!).primaryColor, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(()=>ProductScreen(
                                  product: item.product,
                                ));




                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Xem thông tin",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if(controller.order.value.reviewed == false)
                    InkWell(
                      onTap: () {
                        Get.to(()=>ReviewProductScreen(product: item.product!,orderCode: orderCode!,))!.then((value) => controller.getOneOrderHistory());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Đánh giá",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
