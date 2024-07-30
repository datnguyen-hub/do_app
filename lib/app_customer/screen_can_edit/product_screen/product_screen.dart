import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../config_controller.dart';
import '../repository_widget_config.dart';
import 'input_model.dart';

class ProductScreen extends StatelessWidget {
  final Product? product;
  final int? productId;

  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  ProductScreen({Key? key, this.product, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataAppCustomerController.inputModelProduct =
        InputModelProduct(product: product, productId: productId);
    if (configController.configApp.productPageType! <
        RepositoryWidgetCustomer().LIST_PRODUCT_SCREEN.length) {
      return RepositoryWidgetCustomer()
          .LIST_PRODUCT_SCREEN[configController.configApp.productPageType!];
    } else {
      return RepositoryWidgetCustomer().LIST_PRODUCT_SCREEN[0];
    }
  }
}
