import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/agency.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';


import '../../data_app_controller.dart';

class UpdateInfoAgencyController extends GetxController {
  var agencyReq = Agency().obs;
  var loadInit = false.obs;
  bool? isFromCheckStatus;
  var name = TextEditingController();
  var accountName = TextEditingController();
  var accountNumber = TextEditingController();
  var bank = TextEditingController();
  var branch = TextEditingController();
  var cmnd = TextEditingController();
  var issuedBy = TextEditingController();
  UpdateInfoAgencyController({this.isFromCheckStatus}) {
    if (isFromCheckStatus == true) {
      getCollaboratorInfo();
    }
  }
  Future<void> updateCollaboratorInfo() async {
    if (agencyReq.value.firstAndLastName == null ||
        agencyReq.value.firstAndLastName == "") {
      SahaAlert.showError(message: "Bạn chưa nhập họ tên");
      return;
    }
    if (agencyReq.value.accountName == null || agencyReq.value.accountName == "") {
      SahaAlert.showError(message: "Bạn chưa nhập tên tài khoản");
      return;
    }
    if (agencyReq.value.accountNumber == null ||
        agencyReq.value.accountNumber == "") {
      SahaAlert.showError(message: "Bạn chưa nhập số tài khoản");
      return;
    }
    if (agencyReq.value.bank == null || agencyReq.value.bank == "") {
      SahaAlert.showError(message: "Bạn chưa nhập ngân hàng");
      return;
    }
    if (agencyReq.value.cmnd == null || agencyReq.value.cmnd == "") {
      SahaAlert.showError(message: "Bạn chưa nhập số CMND");
      return;
    }
    try {
      var res = await CustomerRepositoryManager.agencyCustomerRepository
          .updateAgencyInfo(agency: agencyReq.value);
      Get.back(result: "Success");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  DataAppCustomerController dataAppCustomerController = Get.find();

  Future<void> registerAgency() async {
    try {
      var data = await CustomerRepositoryManager.agencyCustomerRepository
          .registerAgency(true);
      Future.delayed(Duration(milliseconds: 100), () async {
        await dataAppCustomerController.getInfoCustomer();
        await dataAppCustomerController.getBadge();
      });
      SahaAlert.showSuccess(message: "Đăng ký thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getCollaboratorInfo() async {
    loadInit.value = true;
    try {
      var res = await CustomerRepositoryManager.agencyCustomerRepository
          .getAgencyInfo();
      agencyReq.value = res!.data!;
      convertInfo();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertInfo() {
    name.text = agencyReq.value.firstAndLastName ?? '';
    accountName.text = agencyReq.value.accountName ?? '';
    accountNumber.text = agencyReq.value.accountNumber ?? '';
    bank.text = agencyReq.value.bank ?? '';
    cmnd.text = agencyReq.value.cmnd ?? '';
    issuedBy.text = '';
  }
}
