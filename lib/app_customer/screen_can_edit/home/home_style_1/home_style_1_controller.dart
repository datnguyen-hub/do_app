import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

class HomeStyle1Controller extends GetxController {
  DataAppCustomerController dataAppCustomerController = Get.find();
  CustomerConfigController configController = Get.find();
  var opacity = .0.obs;
  var isRefresh = false.obs;

  void changeOpacitySearch(double va) {
    opacity.value = va;
  }

  Future<void> refresh() async {
    await dataAppCustomerController.checkLogin();
    await dataAppCustomerController.getLayout();
    Get.find<CustomerConfigController>().getAppTheme();
    dataAppCustomerController.getBanner();
    dataAppCustomerController.getHomeButton();
    dataAppCustomerController.getAllCategory();
    dataAppCustomerController.getProductDiscount();
    dataAppCustomerController.getProductTopSale();
    dataAppCustomerController.getProductNews();
    dataAppCustomerController.getProductByCategory();
    dataAppCustomerController.getPostNew();
    dataAppCustomerController.getBannerAdsApp();
    isRefresh.value = !isRefresh.value;
  }
}
