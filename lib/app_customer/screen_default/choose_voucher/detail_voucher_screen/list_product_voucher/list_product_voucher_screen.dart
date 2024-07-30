
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';

import 'package:sahashop_customer/app_customer/model/product.dart';

import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/choose_voucher/detail_voucher_screen/list_product_voucher/list_product_voucher_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';


import '../../../../screen_can_edit/product_item_widget/product_item_widget.dart';

class ListProductVoucerScreen extends StatelessWidget {
  ListProductVoucerScreen({super.key, required this.voucherId}) {
    controller = ListProductVoucherController(voucherId: voucherId);
  }
  final int voucherId;

  final bool? showCart = true;
  late final ListProductVoucherController controller;
  RefreshController refreshController = RefreshController();
  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách sản phẩm")),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : controller.listProductVoucher.isEmpty
                ? const Center(
                    child: Text('Không có sản phẩm nào nào'),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => controller.isLoading.value
                              ? const CupertinoActivityIndicator()
                              : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await controller.getAllProductVoucher(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await controller.getAllProductVoucher();
                      refreshController.loadComplete();
                    },
                    child: ListView.builder(
                      
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: (controller.listProductVoucher.length / 2).ceil(),
                        itemBuilder: (BuildContext context, int index) {
                           var length = controller.listProductVoucher.length;
                            var index1 = index * 2;
                            return itemProduct(
                                motelPost1: controller.listProductVoucher[index1],
                                motelPost2: length <= (index1 + 1)
                                    ? null
                                    : controller.listProductVoucher[index1 + 1]);
                          
                        }),
                  ),
      ),
    );
  }

 Widget itemProduct({
    required Product motelPost1,
    required Product? motelPost2,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Row(
        children: [
          ProductItemWidget(
            product: motelPost1,
            height:
                dataAppCustomerController.infoCustomer.value.isCollaborator ==
                            true ||
                        dataAppCustomerController.infoCustomer.value.isAgency ==
                            true
                    ? 330
                    : 300,
            width: (Get.width - 10) / 2,
            showCart: false,
          ),
          if (motelPost2 != null)
            ProductItemWidget(
              product: motelPost2,
              height: dataAppCustomerController
                              .infoCustomer.value.isCollaborator ==
                          true ||
                      dataAppCustomerController.infoCustomer.value.isAgency ==
                          true
                  ? 330
                  : 300,
              width: (Get.width - 10) / 2,
              showCart: false,
            ),
        ],
      ),
    );
  }

  double? checkMinMaxPrice(double? price, Product product) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }
}
