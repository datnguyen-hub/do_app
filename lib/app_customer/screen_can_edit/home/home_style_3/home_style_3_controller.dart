import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../../config_controller.dart';

class HomeStyle3Controller extends GetxController {
  var opacity = .0.obs;
  var changeHeight = 35.0.obs;
  var checkTouch = false.obs;
  CustomerConfigController configController = Get.find();
  void changeOpacitySearch(double va) {
    opacity.value = va;
  }

  void changeHeightAppbar(double va) {
    changeHeight.value = va;
  }

  DataAppCustomerController dataAppCustomerController = Get.find();
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
