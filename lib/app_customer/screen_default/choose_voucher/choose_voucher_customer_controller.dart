import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen_default/cart_screen/cart_controller.dart';
import '../../repository/repository_customer.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/voucher.dart';

class ChooseCustomerController extends GetxController {
  var listVoucher = RxList<Voucher>();
  var listChooseVoucher = RxList<bool>();
  var voucherCodeChoose = "".obs;
  var codeVoucherEditingController = TextEditingController().obs;
  String? voucherCodeChooseInput;

  CartController cartController = Get.find();

  ChooseCustomerController({this.voucherCodeChooseInput}) {
    if (voucherCodeChooseInput != null) {
      voucherCodeChoose.value = voucherCodeChooseInput!;
    }
    getVoucherCustomer();
  }

  Future<void> getVoucherCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getVoucherCustomer();
      listVoucher(res!.data!);
      listVoucher.forEach((element) {
        listChooseVoucher.add(false);
      });
      var index = listVoucher
          .indexWhere((element) => element.code == voucherCodeChoose.value);
      if (index != -1) {
        listChooseVoucher[index] = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void enterCodeVoucher(BuildContext context) async {
    await cartController.addVoucherCart(voucherCodeChoose.value, (err) {
      if (
          // cartController.cartData.value.voucherDiscountAmount == 0
          err != 'success') {
        listChooseVoucher([]);
        listVoucher.forEach((element) {
          listChooseVoucher.add(false);
        });
        voucherCodeChoose.value = "";
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    "Bạn chưa đủ điều kiện sử dụng Voucher này !",
                    style: TextStyle(fontSize: 17),
                  ),
                  content: Text(
                    "Vui lòng xem điều kiện sử dụng Voucher, hoặc sử dụng Voucher khác !",
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Thoát",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ));
        cartController.voucherCodeChoose.value = "";
      } else {
        cartController.voucherCodeChoose.value =
            codeVoucherEditingController.value.text.toUpperCase();
        Get.back();
      }
    });
  }

  void checkConditionVoucher(BuildContext context) async {
    if (voucherCodeChoose.value.isEmpty) {
      cartController.voucherCodeChoose.value = "";
      cartController.refresh();
      Get.back();
    } else {
      await cartController.addVoucherCart(voucherCodeChoose.value, (err) {
        print("========> $err");
        if (err != 'success') {
          listChooseVoucher([]);
          listVoucher.forEach((element) {
            listChooseVoucher.add(false);
          });
          voucherCodeChoose.value = "";
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      "Bạn chưa đủ điều kiện sử dụng Voucher này !",
                      style: TextStyle(fontSize: 17),
                    ),
                    content: Text(
                      "Vui lòng xem điều kiện sử dụng Voucher, hoặc sử dụng Voucher khác !",
                      style: TextStyle(fontSize: 15),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Thoát",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ));
          cartController.voucherCodeChoose.value = "";
        } else {
          cartController.voucherCodeChoose.value = voucherCodeChoose.value;
          Get.back();
        }
      });
    }
  }

  void checkChooseVoucher(bool value, int index) {
    listChooseVoucher([]);
    listVoucher.forEach((element) {
      listChooseVoucher.add(false);
    });
    voucherCodeChoose.value = "";
    if (value == false) {
      listChooseVoucher[index] = true;
      voucherCodeChoose.value = listVoucher[index].code!;
    }
  }
}
