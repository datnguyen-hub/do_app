import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/data/example/product.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import '../../components/product_item/product_item_loading_widget.dart';
import '../../screen_can_edit/product_item_widget/product_item_widget.dart';

import 'bought_products_controller.dart';

class BoughtProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: BoughtProductsLoggedScreen());
  }
}

class BoughtProductsLoggedScreen extends StatefulWidget {
  BoughtProductsLoggedScreen({Key? key}) : super(key: key);

  @override
  _BoughtProductsScreenState createState() => _BoughtProductsScreenState();
}

class _BoughtProductsScreenState extends State<BoughtProductsLoggedScreen> {
  final BoughtProductsController boughtProductsController =
      BoughtProductsController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        boughtProductsController.getProducts(isLoadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Sản phẩm vừa mua"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return RefreshIndicator(
      onRefresh: () async {
        await boughtProductsController.getProducts(isRefresh: true);
      },
      child: Obx(() {
        var isLoading = boughtProductsController.isLoadingProduct.value;
        var list = isLoading
            ? EXAMPLE_LIST_PRODUCT
            : boughtProductsController.products;
        return Container(
          height: Get.height,
          padding: const EdgeInsets.all(2.5),
          child: isLoading
              ? StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) =>
                      ProductItemLoadingWidget(),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                )
              : StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 2,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ProductItemWidget(
                    product: list[index],
                  ),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
        );
      }),
    );
  }
}
