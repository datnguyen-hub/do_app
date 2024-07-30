import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/state_order.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class OrderHistoryDetailController extends GetxController {
  String? orderCode;
  var listChoose = RxList<bool>([false, false, false, false, false, false]);
  var reason = "";
  var isLoading = false.obs;
  var order = Order().obs;

  OrderHistoryDetailController({this.orderCode}) {
    getOneOrderHistory();
  }

  var listStateOrder = RxList<StateOrder>();

  Future<void> getStateHistoryCustomerOrder() async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getStateHistoryCustomerOrder(order.value.id);
      listStateOrder(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getOneOrderHistory() async {
    isLoading.value = true;
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getOneOrderHistory(orderCode);
      order.value = res!.data!;
      getStateHistoryCustomerOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> cancelOrder() async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .cancelOrder(orderCode, reason);
      Get.back(result: "CANCELLED");
    } catch (err) {}
  }

  void checkChooseReason(bool value, int index) {
    listChoose([false, false, false, false, false, false]);
    if (value == false) {
      listChoose[index] = true;
    }
  }
}
