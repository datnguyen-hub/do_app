import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import '../../components//toast/saha_alert.dart';

class ConfigPaymentCustomerController extends GetxController {
  var listNamePaymentMethod = RxList<String?>();
  var listDescriptionPaymentMethod = RxList<String?>();
  var listUsePaymentMethod = RxList<bool?>();
  var listPaymentMethodId = RxList<int>();
  var listIdPaymentPartnerMethod = RxList<int>();
  Map<String, dynamic>? listConfig = Map<String, dynamic>();
  var listTextEditingController = RxList<List<TextEditingController>>();
  var listChoosePaymentMethod = RxList<bool>();
  String? namePaymentCurrent = "";
  int? paymentMethodId = 0;
  int? paymentPartnerId = 0;

  ConfigPaymentCustomerController({this.paymentPartnerId}) {
    getPaymentMethod();
  }

  Future<void> getPaymentMethod() async {
    try {
      var res =
          await CustomerRepositoryManager.paymentRepository.getPaymentMethod();
      res!.data!.forEach((element) {
        listNamePaymentMethod.add(element["name"]);
        listDescriptionPaymentMethod.add(element["description"]);
        listUsePaymentMethod.add(element["use"]);
        listPaymentMethodId.add(element["payment_method_id"]);
        listIdPaymentPartnerMethod.add(element["id"]);
        listConfig = element["config"];
      });

      listNamePaymentMethod.forEach((element) {
        listChoosePaymentMethod.add(false);
      });

      var index = listIdPaymentPartnerMethod
          .indexWhere((element) => element == paymentPartnerId);
      if (index != -1) {
        listChoosePaymentMethod[index] = true;
        namePaymentCurrent = listNamePaymentMethod[index];
        paymentPartnerId = listIdPaymentPartnerMethod[index];
        paymentMethodId = listPaymentMethodId[index];
      }
    } catch (err) {
      print(err);
      SahaAlert.showError(message: err.toString());
    }
  }

  void checkChooseVoucher(bool value, int index) {
    listChoosePaymentMethod([]);
    listNamePaymentMethod.forEach((element) {
      listChoosePaymentMethod.add(false);
    });

    if (value == false) {
      listChoosePaymentMethod[index] = true;
      namePaymentCurrent = listNamePaymentMethod[index];
      paymentPartnerId = listIdPaymentPartnerMethod[index];
      paymentMethodId = listPaymentMethodId[index];
    }
  }

  void resetData() {
    listNamePaymentMethod([]);
    listUsePaymentMethod([]);
    listIdPaymentPartnerMethod([]);
    listPaymentMethodId([]);
    listTextEditingController([]);
    getPaymentMethod();
  }
}
