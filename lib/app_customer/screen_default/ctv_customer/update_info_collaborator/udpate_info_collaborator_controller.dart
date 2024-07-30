import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../../model/ctv.dart';
import '../../data_app_controller.dart';

class UpdateInfoCollaboratorController extends GetxController {
  var ctvReq = Ctv().obs;
  var loadInit = false.obs;
  bool? isFromCheckStatus;
  var name = TextEditingController();
  var accountName = TextEditingController();
  var accountNumber = TextEditingController();
  var bank = TextEditingController();
  var branch = TextEditingController();
  var cmnd = TextEditingController();
  var issuedBy = TextEditingController();
  UpdateInfoCollaboratorController({this.isFromCheckStatus}) {
    if (isFromCheckStatus == true) {
      getCollaboratorInfo();
    }
  }
  Future<void> updateCollaboratorInfo() async {
    if (ctvReq.value.firstAndLastName == null ||
        ctvReq.value.firstAndLastName == "") {
      SahaAlert.showError(message: "Bạn chưa nhập họ tên");
      return;
    }
    if (ctvReq.value.accountName == null || ctvReq.value.accountName == "") {
      SahaAlert.showError(message: "Bạn chưa nhập tên tài khoản");
      return;
    }
    if (ctvReq.value.accountNumber == null ||
        ctvReq.value.accountNumber == "") {
      SahaAlert.showError(message: "Bạn chưa nhập số tài khoản");
      return;
    }
    if (ctvReq.value.bank == null || ctvReq.value.bank == "") {
      SahaAlert.showError(message: "Bạn chưa nhập ngân hàng");
      return;
    }
    if (ctvReq.value.cmnd == null || ctvReq.value.cmnd == "") {
      SahaAlert.showError(message: "Bạn chưa nhập số CMND");
      return;
    }
    try {
      var res = await CustomerRepositoryManager.ctvCustomerRepository
          .updateCollaboratorInfo(ctv: ctvReq.value);
      Get.back(result: "Success");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  DataAppCustomerController dataAppCustomerController = Get.find();

  Future<void> registerCtv() async {
    try {
      var data = await CustomerRepositoryManager.ctvCustomerRepository
          .registerCtv(true);
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
      var res = await CustomerRepositoryManager.ctvCustomerRepository
          .getCollaboratorInfo();
      ctvReq.value = res!.data!;
      convertInfo();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertInfo() {
    name.text = ctvReq.value.firstAndLastName ?? '';
    accountName.text = ctvReq.value.accountName ?? '';
    accountNumber.text = ctvReq.value.accountNumber ?? '';
    bank.text = ctvReq.value.bank ?? '';
    cmnd.text = ctvReq.value.cmnd ?? '';
    issuedBy.text = '';
  }
}
