import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/combo.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ChooseComboController extends GetxController {
  var listCombo = RxList<Combo>();

  ChooseComboController () {
    getComboCustomer();
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      listCombo(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
