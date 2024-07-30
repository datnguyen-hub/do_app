import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../config_controller.dart';
import '../../repository/repository_customer.dart';
import '../../screen_can_edit/category_product_screen/category_product_screen.dart';
import '../../screen_can_edit/home/home_screen.dart';
import '../../screen_default/cart_screen/cart_screen.dart';
import '../../screen_default/profile_screen/profile_screen.dart';
import '../category_post_screen/category_post_screen_1.dart';
import '../community/community_screen.dart';

class NavigationController extends GetxController {
  var selectedIndexBottomBar = 2.obs;
  late CustomerConfigController configController;
  late DataAppCustomerController dataAppCustomerController;
  List<Widget> navigationHome = [];

  NavigationController() {
    configController = Get.find();
    dataAppCustomerController = Get.find();
    navigationHome = [
      CartLockScreen(
        showIconBack: false,
      ),
      dataAppCustomerController.badge.value.hasCommunity == true
          ? CommunityLockScreen()
          : CategoryPostScreen(
              isAutoBackIcon: false,
            ),
      HomeScreen(),
      CategoryProductScreen(
        categoryId: -1,
        isHideBack: true,
      ),
      ProfileScreen(),
    ];
  }

  Future<void> handleDynamicLink({required int id}) async {
    try {
      var res = await CustomerRepositoryManager.badgeRepository
          .handleDynamicLink(id: id);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
