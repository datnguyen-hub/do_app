import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config_controller.dart';
import '../../screen_default/data_app_controller.dart';
import '../repository_widget_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    dataAppCustomerController.getProductByCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (configController.configApp.homePageType != null &&
        configController.configApp.homePageType! <
            RepositoryWidgetCustomer().LIST_HOME_SCREEN.length) {
      return RepositoryWidgetCustomer()
          .LIST_HOME_SCREEN[configController.configApp.homePageType!];
    } else {
      return RepositoryWidgetCustomer().LIST_HOME_SCREEN[0];
    }
  }
}
