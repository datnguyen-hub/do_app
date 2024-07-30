import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import '../../model/product.dart';
import '../data_app_controller.dart';

class ProductWatchMoreScreen extends StatelessWidget {
  final String title;
  final List<Product> listProduct;

  ProductWatchMoreScreen({required this.title, required this.listProduct});

  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: listProduct.length,
        itemBuilder: (BuildContext context, int index) => ProductItemWidget(
          height: dataAppCustomerController.infoCustomer.value.isCollaborator ==
                      true ||
                  dataAppCustomerController.infoCustomer.value.isAgency == true
              ? 330
              : 300,
          product: listProduct[index],
        ),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
    );
  }
}
