import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../screen_default/payment_method/config_payment_customer_controller.dart';
import '../../components//button/saha_button.dart';

class PaymentMethodCustomerScreen extends StatelessWidget {
  final Function? callback;
  final int? paymentPartnerId;
  PaymentMethodCustomerScreen({this.callback, this.paymentPartnerId}) {
    configPaymentCustomerController =
        ConfigPaymentCustomerController(paymentPartnerId: paymentPartnerId);
  }
  late ConfigPaymentCustomerController configPaymentCustomerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phương thức thanh toán"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              ...List.generate(
                configPaymentCustomerController.listNamePaymentMethod.length,
                (index) => configPaymentCustomerController
                            .listUsePaymentMethod[index] ==
                        true
                    ? InkWell(
                        onTap: () {
                          configPaymentCustomerController.checkChooseVoucher(
                              configPaymentCustomerController
                                  .listChoosePaymentMethod[index],
                              index);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              color: Colors.white,
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${configPaymentCustomerController.listNamePaymentMethod[index]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      configPaymentCustomerController
                                              .listChoosePaymentMethod[index]
                                          ? Icon(
                                              Icons.check_sharp,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground(),
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  ),
                                  if (configPaymentCustomerController
                                              .listDescriptionPaymentMethod[
                                          index] !=
                                      null)
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5),
                                        child: Text(
                                          "${configPaymentCustomerController.listDescriptionPaymentMethod[index]}",
                                          maxLines: 3,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Đồng ý",
              onPressed: () {
                callback!(
                  configPaymentCustomerController.namePaymentCurrent,
                  configPaymentCustomerController.paymentPartnerId,
                  configPaymentCustomerController.paymentMethodId,
                );
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
