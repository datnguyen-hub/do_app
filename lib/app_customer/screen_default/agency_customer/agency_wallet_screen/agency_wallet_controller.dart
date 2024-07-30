import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/general_info_payment_agency.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../data_app_controller.dart';

class AgencyWalletController extends GetxController {
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
  var nameAgency = "".obs;
  var isFullInfoPayment = false.obs;
  var generalInfoPaymentAgency = GeneralInfoPaymentAgency().obs;
  var tabIndex = 0.obs;
  var type = 0.obs;
  DataAppCustomerController dataAppCustomerController = Get.find();

  AgencyWalletController() {
    if (dataAppCustomerController.infoCustomer.value.isAgency == true &&
        dataAppCustomerController.infoCustomer.value.isAgency != null) {
      getInfoAgency();
      getGeneralInfoPaymentAgency();
    }
  }

  void changeWidget(int index) {
    indexWidget.value = index;
  }

  Future<void> requestPaymentAgency() async {
    try {
      var data = await CustomerRepositoryManager.agencyCustomerRepository
          .requestPaymentAgency();
      getGeneralInfoPaymentAgency();
      SahaAlert.showSuccess(message: "Gửi yêu cầu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getGeneralInfoPaymentAgency() async {
    try {
      var data = await CustomerRepositoryManager.agencyCustomerRepository
          .getGeneralInfoPaymentAgency();
      generalInfoPaymentAgency.value = data!.data!;

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getInfoAgency() async {
    try {
      var res = await CustomerRepositoryManager.agencyCustomerRepository
          .getInfoAgency();
      var data = res!.data;
      fullName.value = data!.firstAndLastName ?? "";
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
      nameAgency.value = data.agencyType?.name ?? "";
      // checkInfoPayment();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void checkInfoPayment() {
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
