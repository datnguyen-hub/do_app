import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config_controller.dart';
import '../../screen_default/data_app_controller.dart';

import '../repository_widget_config.dart';
import 'input_model_products.dart';

class CategoryProductScreen extends StatelessWidget {
  final bool autoSearch;
  final bool isCtv;
  final bool? isHideBack;
  final int? categoryId;
  final FILTER_PRODUCTS? filterProducts;

  CategoryProductScreen(
      {Key? key,
      this.filterProducts,
      this.categoryId,
      this.autoSearch = false,
      this.isCtv = false,
      this.isHideBack})
      : super(key: key);
  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    dataAppCustomerController.inputModelProducts = InputModelProducts(
      categoryId: categoryId,
      filterProducts: filterProducts,
    );

    var productsScreen;
    if (configController.configApp.categoryPageType! <
        RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN.length) {
      productsScreen = RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN[
          configController.configApp.categoryPageType!];
    } else {
      productsScreen =
          RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN[0];
    }
    productsScreen.autoSearch = autoSearch;
    productsScreen.isHideBack = isHideBack;
    return productsScreen;
  }
}
