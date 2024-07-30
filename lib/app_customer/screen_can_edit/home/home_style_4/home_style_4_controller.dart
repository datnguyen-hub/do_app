import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../../config_controller.dart';

class HomeStyle4Controller extends GetxController {
  var isTouch = false.obs;
  DataAppCustomerController dataAppCustomerController = Get.find();
  CustomerConfigController configController = Get.find();
  var isRefresh = false.obs;
  Future<void> refresh() async {
    await dataAppCustomerController.checkLogin();
    await dataAppCustomerController.getLayout();
    Get.find<CustomerConfigController>().getAppTheme();
    dataAppCustomerController.getBanner();
    dataAppCustomerController.getHomeButton();
    dataAppCustomerController.getAllCategory();
    dataAppCustomerController.getBadge();
    dataAppCustomerController.getProductDiscount();
    dataAppCustomerController.getProductTopSale();
    dataAppCustomerController.getProductNews();
    dataAppCustomerController.getProductByCategory();
    dataAppCustomerController.getPostNew();
    dataAppCustomerController.getBannerAdsApp();
    isRefresh.value = !isRefresh.value;
  }
}
