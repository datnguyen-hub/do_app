import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/general_info_paymenrt_ctv.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../../remote/response-request/ctv/info_request.dart';
import '../../data_app_controller.dart';

class CtvWalletController extends GetxController {
  var indexWidget = 0.obs;
  var fullName = "".obs;
  var cmnd = "".obs;
  var dateRange = "".obs;
  var issuedBy = "".obs;
  var frontCard = "".obs;
  var backCard = "".obs;
  var bank = "".obs;
  var accountName = "".obs;
  var accountNumber = "".obs;
  var branch = "".obs;
  var isFullInfoPayment = false.obs;
  var generalInfoPaymentCtv = GeneralInfoPaymentCtv().obs;
  var isPaymentAuto = false.obs;
  DataAppCustomerController dataAppCustomerController = Get.find();

  CtvWalletController() {
    if (dataAppCustomerController.infoCustomer.value.isCollaborator == true &&
        dataAppCustomerController.infoCustomer.value.isCollaborator != null) {
      getInfoCTV();
      getGeneralInfoPaymentCtv();
    }
  }

  Future<void> updateInfoCTV() async {
    try {
      var data = await CustomerRepositoryManager.ctvCustomerRepository
          .updateInfoCTV(InfoPaymentRequest(
        paymentAuto: isPaymentAuto.value,
      ));
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void changeWidget(int index) {
    indexWidget.value = index;
  }

  Future<void> requestPayment() async {
    try {
      var data = await CustomerRepositoryManager.ctvCustomerRepository
          .requestPayment();
      getGeneralInfoPaymentCtv();
      SahaAlert.showSuccess(message: "Gửi yêu cầu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getGeneralInfoPaymentCtv() async {
    try {
      var data = await CustomerRepositoryManager.ctvCustomerRepository
          .getGeneralInfoPaymentCtv();
      generalInfoPaymentCtv.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getInfoCTV() async {
    try {
      var res =
          await CustomerRepositoryManager.ctvCustomerRepository.getInfoCTV();
      var data = res!.data;
      isPaymentAuto.value = data!.paymentAuto ?? false;
      fullName.value = data.firstAndLastName ?? "";
      cmnd.value = data.cmnd ?? "";
      dateRange.value = data.dateRange == null
          ? ""
          : DateFormat('dd-MM-yyyy').format(data.dateRange!);
      issuedBy.value = data.issuedBy ?? "";
      frontCard.value = data.frontCard ?? "";
      backCard.value = data.backCard ?? "";
      bank.value = data.bank ?? "";
      accountName.value = data.accountName ?? "";
      accountNumber.value = data.accountNumber ?? "";
      branch.value = data.branch ?? "";
      checkInfoPayment();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void checkInfoPayment() {
    print(fullName.value);
    print(cmnd.value);
    print(dateRange.value);
    print(issuedBy.value);
    print(frontCard.value);
    print(backCard.value);
    print(bank.value);
    print(accountName.value);
    print(branch.value);
    print(accountNumber.value);
    if (fullName.value != "" &&
        cmnd.value != "" &&
        dateRange.value != "" &&
        issuedBy.value != "" &&
        frontCard.value != "" &&
        backCard.value != "" &&
        bank.value != "" &&
        accountName.value != "" &&
        accountNumber.value != "" &&
        branch.value != "") {
      isFullInfoPayment.value = true;
    }
  }
}
