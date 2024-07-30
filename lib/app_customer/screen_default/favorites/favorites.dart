import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/data/example/product.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import '../../components/product_item/product_item_loading_widget.dart';
import '../../screen_can_edit/product_item_widget/product_item_widget.dart';

import 'favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CheckCustomerLogin(child: FavoritesLoggedScreen());
  }
}

class FavoritesLoggedScreen extends StatefulWidget {
  FavoritesLoggedScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesLoggedScreen> {
  final FavoritesController favoritesController = FavoritesController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        favoritesController.getProducts(isLoadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sản phẩm yêu thích"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = favoritesController.isLoadingProduct.value;
      var list =
          isLoading ? EXAMPLE_LIST_PRODUCT : favoritesController.products;
      return list.isEmpty
          ? Center(child: Text("Chưa có sản phẩm yêu thích"))
          : Padding(
              padding: const EdgeInsets.all(2.5),
              child: RefreshIndicator(
                onRefresh: () async {
                  await favoritesController.getProducts(isRefresh: true);
                },
                child: Container(
                  height: Get.height,
                  child: isLoading
                      ? StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) =>
                              ProductItemLoadingWidget(),
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(1),
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
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(1),
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                ),
              ),
            );
    });
  }
}
