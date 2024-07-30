import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/info_request.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ConfigPaymentAgencyController extends GetxController {
  var indexWidget = 0.obs;
  var isPaymentAuto = false.obs;
  var frontCard = "".obs;
  var backCard = "".obs;

  DateTime? dateRange;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController cmndTextEditingController = TextEditingController();
  TextEditingController dateRangeTextEditingController =
      TextEditingController();
  TextEditingController issuedByTextEditingController = TextEditingController();

  TextEditingController bankTextEditingController = TextEditingController();
  TextEditingController childBankTextEditingController =
      TextEditingController();
  TextEditingController nameOwnTextEditingController = TextEditingController();
  TextEditingController stkTextEditingController = TextEditingController();

  ConfigPaymentAgencyController() {
    getInfoAgency();
  }

  void changeWidget(int index) {
    indexWidget.value = index;
  }

  void checkInfoPayment() {
    if (nameTextEditingController.text != "" &&
        cmndTextEditingController.text != "" &&
        cmndTextEditingController.text != "" &&
        issuedByTextEditingController.text != "" &&
        frontCard.value != "" &&
        backCard.value != "" &&
        bankTextEditingController.text != "" &&
        nameOwnTextEditingController.text != "" &&
        stkTextEditingController.text != "" &&
        childBankTextEditingController.text != "") {
      updateInfoAgency();
    } else {
      SahaAlert.showError(
          message: "Quý khách cần nhập đầy đủ thông tin CMND và TKNH");
    }
  }

  Future<void> updateInfoAgency() async {
    try {
      var data = await CustomerRepositoryManager.agencyCustomerRepository
          .updateInfoAgency(InfoPaymentAgencyRequest(
        paymentAuto: isPaymentAuto.value,
        firstAndLastName: nameTextEditingController.text,
        cmnd: cmndTextEditingController.text,
        dateRange: dateRange,
        issuedBy: issuedByTextEditingController.text,
        frontCard: frontCard.value,
        backCard: backCard.value,
        bank: bankTextEditingController.text,
        accountName: nameOwnTextEditingController.text,
        accountNumber: stkTextEditingController.text,
        branch: childBankTextEditingController.text,
      ));
      Get.back();
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getInfoAgency() async {
    try {
      var res =
          await CustomerRepositoryManager.agencyCustomerRepository.getInfoAgency();
      var data = res!.data;
      isPaymentAuto.value = data!.paymentAuto!;
      nameTextEditingController.text = data.firstAndLastName ?? "";
      cmndTextEditingController.text = data.cmnd ?? "";
      dateRangeTextEditingController.text = data.dateRange == null
          ? ""
          : DateFormat('dd-MM-yyyy').format(data.dateRange!);
      dateRange = data.dateRange;
      issuedByTextEditingController.text = data.issuedBy ?? "";

      frontCard.value = data.frontCard ?? "";
      backCard.value = data.backCard ?? "";
      bankTextEditingController.text = data.bank ?? "";
      nameOwnTextEditingController.text = data.accountName ?? "";
      stkTextEditingController.text = data.accountNumber ?? "";
      childBankTextEditingController.text = data.branch ?? "";
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
