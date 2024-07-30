import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/const/order_constant.dart';
import 'package:sahashop_customer/app_customer/model/branches.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/appflyer.dart';

import '../../components//toast/saha_alert.dart';
import '../../model/info_address_customer.dart';
import '../../model/shipment_method.dart';
import '../../remote/response-request/orders/order_request.dart';
import '../../repository/repository_customer.dart';
import '../../screen_default/cart_screen/cart_controller.dart';
import '../../screen_default/order_completed_screen/order_completed_screen.dart';
import '../../utils/customer_info.dart';
import '../order_history/order_history_screen.dart';

class ConfirmController extends GetxController {
  var isLoadingOrder = false.obs;
  var isLoadingBranches = false.obs;
  Rx<InfoAddressCustomer?> infoAddressCustomer = InfoAddressCustomer().obs;
  var isLoadingAddress = false.obs;
  var listShipmentFast = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;
  var paymentMethodId = 0.obs;
  var paymentPartnerId = 0.obs;
  var paymentMethodName = "".obs;
  var opacityCurrent = 1.0.obs;
  var loading = false.obs;
  var isExportBill = false.obs;
  var listBranches = RxList<Branches>();
  TextEditingController noteCustomerEditingController = TextEditingController();
  int partnerShipperId = 0;
  int shipperType = 0;
  int totalShippingFee = 0;
  DataAppCustomerController dataAppCustomerController = Get.find();
  var branchChoose = Branches().obs;
  var loadingData = false.obs;

  CartController cartController = Get.find();

  ////export bill
  var companyName = TextEditingController();
  var taxCode = TextEditingController();
  var companyAddress = TextEditingController();
  var companyEmail = TextEditingController();

  ConfirmController() {
    getData();
    initDefaultPaymentMethod();
  }
  void getData() async {
    await getAllBranches();
    getAllAddressCustomer();
  }

  void initDefaultPaymentMethod() async {
    var res =
        await CustomerRepositoryManager.paymentRepository.getPaymentMethod();

    if (res!.data != null && res.data!.length > 0) {
      var itemFirst = res.data![0];
      paymentMethodName.value = itemFirst['name'];
      paymentPartnerId.value = itemFirst['id'];
      paymentMethodId.value = itemFirst['payment_method_id'];
    }
  }

  Future<void> getAllAddressCustomer() async {
    isLoadingAddress.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .getAllAddressCustomer();
      infoAddressCustomer.value =
          res!.data!.isEmpty ? InfoAddressCustomer() : res.data![0];
      res.data!.forEach((element) {
        if (element.isDefault!) {
          infoAddressCustomer.value = element;
        }
      });
      cartController.chargeShipmentFee(
          idAddressCustomer: infoAddressCustomer.value!.id,branchId: branchChoose.value.id);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  Future<void> createOrders() async {
    loading.value = true;
    if (infoAddressCustomer.value?.id == null) {
      SahaAlert.showError(message: "Chưa chọn địa chỉ nhận ");
      loading.value = false;
      return;
    }
    if (branchChoose.value.id == null &&
        dataAppCustomerController.badge.value.allowBranchPaymentOrder == true) {
      SahaAlert.showError(message: "Chưa chọn chi nhánh ");
      loading.value = false;
      return;
    }
    isLoadingOrder.value = true;
    var orderRequest = OrderRequest(
        orderFrom: ORDER_FROM_APP,
        branchId: branchChoose.value.id,
        paymentMethodId: paymentMethodId.value,
        paymentPartnerId: paymentPartnerId.value,
        partnerShipperId: cartController.shipmentMethodCurrent.value.partnerId,
        shipperType: cartController.shipmentMethodCurrent.value.shipType,
        totalShippingFee: cartController.shipmentMethodCurrent.value.fee,
        customerAddressId: infoAddressCustomer.value!.id,
        customerNote: isExportBill.value == false
            ? noteCustomerEditingController.text
            : "${companyName.text}\n${taxCode.text}\n${companyAddress.text}\n${companyEmail.text}",
        collaboratorId: CustomerInfo().getCollaboratorByCustomerId() ??
            (dataAppCustomerController.infoCustomer.value.isCollaborator ==
                        true &&
                    dataAppCustomerController.badge.value.statusCollaborator ==
                        1
                ? dataAppCustomerController.infoCustomer.value.id
                : null),
        agencyByCustomerId:
            dataAppCustomerController.infoCustomer.value.isAgency == true &&
                    dataAppCustomerController.badge.value.statusAgency == 1
                ? dataAppCustomerController.infoCustomer.value.id
                : null,
        codeVoucher: cartController.voucherCodeChoose.value == ""
            ? null
            : cartController.voucherCodeChoose.value,
        isUsedPiont: cartController.cartData.value.isUsePoints,
        isUseBalanceCollaborator: cartController.isUseBalanceCollaborator.value,
        isUseBalanceAgency: cartController.isUseBalanceAgency.value,
        isOrderForCustomer: cartController.cartData.value.isOrderForCustomer);
    try {
      var resultOrder = await CustomerRepositoryManager.orderCustomerRepository
          .createOrder(orderRequest);
      cartController.voucherCodeChoose.value = "";
      isLoadingOrder.value = false;
      if (AppFlyer().isUseAppFlyer == true) {
        print("Anh nhớ em nhiều lắm");
        AppFlyer().logEvent("Tạo đơn hàng",
            {"af_content_id": "1", "af_currency": "USD", "af_revenue": "100"});
      }
      Get.back();
      Get.back();
      Get.to(() => OrderHistoryScreen(
            initPage: 0,
          ));
      Get.to(() => OrderCompletedScreen(
            orderCode: resultOrder!.data!.orderCode!,
          ));
      cartController.getItemCart();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;

    loading.value = false;
  }

  Future<void> getAllBranches() async {
    try {
      isLoadingBranches.value = true;
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getAllBranches();
      listBranches.value = res!.data!;
      if (dataAppCustomerController.badge.value.allowBranchPaymentOrder ==
              true &&
          dataAppCustomerController
                  .badge.value.autoChooseDefaultBranchPaymentOrder ==
              true) {
        var index = listBranches
            .indexWhere((element) => element.isDefaultOrderOnline == true);
        if (index != -1) {
          branchChoose.value = listBranches[index];
        } else {
          if (listBranches.isNotEmpty) {
            branchChoose.value = listBranches[0];
          }
        }
      }
      isLoadingBranches.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getAllShippingCompany() async {
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .getAllShippingCompany(infoAddressCustomer.value?.id);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getTypeShip({required int companyId}) async {
    try {
      var res = await CustomerRepositoryManager.shipmentRepository.getTypeShip(
          idAddressCustomer: infoAddressCustomer.value?.id,
          idCompany: companyId);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
