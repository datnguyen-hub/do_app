import 'package:get/get.dart';

import '../../../components/toast/saha_alert.dart';
import '../../../model/order.dart';
import '../../../repository/repository_customer.dart';

class ProductReviewController extends GetxController {

  ProductReviewController({this.orderCode}){
    getOneOrderHistory();
  }
  var order = Order().obs;
  var isLoading = false.obs;
  String? orderCode;
  Future<void> getOneOrderHistory() async {
    isLoading.value = true;
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getOneOrderHistory(orderCode);
      order.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }


}
