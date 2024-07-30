import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen_default/shipment_screen/shipment_customer_controller.dart';
import '../../components//button/saha_button.dart';
import '../../components//loading/loading_shimmer.dart';
import '../../components//text/text_money.dart';
import '../../model/info_address_customer.dart';
import '../../model/shipment_method.dart';

class ShipmentCustomerScreen extends StatelessWidget {
  final InfoAddressCustomer? infoAddressCustomer;
  final int? branchId;
  final Function? callback;
  final ShipmentMethod? shipmentMethodInput;

  ShipmentCustomerScreen(
      {this.infoAddressCustomer, this.callback, this.shipmentMethodInput,this.branchId}) {
    shipmentCustomerController = ShipmentCustomerController(
        infoAddressCustomer: infoAddressCustomer,
        branchId: branchId,
        shipmentCurrentInput: shipmentMethodInput);
  }

  late ShipmentCustomerController shipmentCustomerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phương thức vận chuyển"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => shipmentCustomerController.isLoadingShipmentMethod.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : Column(
                  children: [
                    Obx(
                      () => Column(
                        children: [
                          ...List.generate(
                            shipmentCustomerController.listShipment.length,
                            (index) => InkWell(
                              onTap: () {
                                shipmentCustomerController
                                        .shipmentMethodChoose.value =
                                    shipmentCustomerController
                                        .listShipment[index];
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                          shipmentCustomerController
                                                          .listShipment[index]
                                                          .name ==
                                                      shipmentCustomerController
                                                          .shipmentMethodChoose
                                                          .value
                                                          .name &&
                                                  shipmentCustomerController
                                                          .listShipment[index]
                                                          .partnerId ==
                                                      shipmentCustomerController
                                                          .shipmentMethodChoose
                                                          .value
                                                          .partnerId
                                              ? Container(
                                                  height: 9,
                                                  width: 9,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "${shipmentCustomerController.listShipment[index].name}"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: SahaMoneyText(
                                                  price: (shipmentCustomerController
                                                      .listShipment[index].fee ?? 0)
                                                      .toDouble(),
                                                  sizeVND: 14,
                                                  sizeText: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            shipmentCustomerController
                                                .listShipment[index].description ?? '',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            //addTokenShipment.tokenEditingController.value.text == ""
            false
                ? SahaButtonFullParent(
                    text: "Bật",
                  )
                : SahaButtonFullParent(
                    text: "Đồng ý",
                    onPressed: () {
                      callback!(shipmentCustomerController
                          .shipmentMethodChoose.value);
                      Get.back();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
