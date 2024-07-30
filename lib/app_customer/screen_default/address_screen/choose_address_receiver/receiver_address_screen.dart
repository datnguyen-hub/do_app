import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_shimmer.dart';
import 'package:sahashop_customer/app_customer/model/info_address_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/address_screen/all_address_customer/all_address_customer_screen.dart';
import '../new_address_customer_screen.dart';
import 'receiver_address_controller.dart';

// ignore: must_be_immutable
class ReceiverAddressCustomerScreen extends StatefulWidget {
  final InfoAddressCustomer? infoAddressCustomers;
  final Function? callback;

  ReceiverAddressCustomerScreen(
      {Key? key, this.infoAddressCustomers, this.callback});
 

  @override
  State<ReceiverAddressCustomerScreen> createState() => _ReceiverAddressCustomerScreenState();
}

class _ReceiverAddressCustomerScreenState extends State<ReceiverAddressCustomerScreen> {

  late ReceiverAddressCustomerController chooseAddressCustomerController;
  
  @override
  void initState() {
    chooseAddressCustomerController = ReceiverAddressCustomerController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.infoAddressCustomers?.id != null) {
          if (chooseAddressCustomerController.listInfoAddressCustomer
              .where((e) => widget.infoAddressCustomers!.id == e.id)
              .isNotEmpty) {
            var address = chooseAddressCustomerController
                .listInfoAddressCustomer
                .where((e) => widget.infoAddressCustomers!.id == e.id)
                .toList()[0];
            widget.callback!(address);
          } else {
            widget.callback!(InfoAddressCustomer());
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chọn địa chỉ nhận hàng"),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => AllAddressCustomerScreen())!.then((value) =>
                    {chooseAddressCustomerController.getAllAddressCustomer()});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Sửa",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => SahaSimmer(
              isLoading: chooseAddressCustomerController.isLoadingAddress.value,
              child: Column(
                children: [
                  ...List.generate(
                      chooseAddressCustomerController
                          .listInfoAddressCustomer.length,
                      (index) => addressSave(context, index)),
                  InkWell(
                    onTap: () {
                      Get.to(() => NewAddressCustomerScreen())!.then((value) =>
                          {
                            chooseAddressCustomerController
                                .getAllAddressCustomer()
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Thêm địa chỉ mới"),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 35,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget addressSave(BuildContext context, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print(chooseAddressCustomerController
                .listInfoAddressCustomer[index].provinceName);
            widget.callback!(
                chooseAddressCustomerController.listInfoAddressCustomer[index]);
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${chooseAddressCustomerController.listInfoAddressCustomer[index].name ?? "Chưa có tên"}",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${chooseAddressCustomerController.listInfoAddressCustomer[index].email ?? "Chưa có email"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        "${chooseAddressCustomerController.listInfoAddressCustomer[index].phone ?? "Chưa có số điện thoại"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        "${chooseAddressCustomerController.listInfoAddressCustomer[index].addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        "${chooseAddressCustomerController.listInfoAddressCustomer[index].districtName ?? "Chưa có Quận/Huyện"}, ${chooseAddressCustomerController.listInfoAddressCustomer[index].wardsName ?? "Chưa có Phường/Xã"}, ${chooseAddressCustomerController.listInfoAddressCustomer[index].provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    widget.infoAddressCustomers == null
                        ? Container()
                        : widget.infoAddressCustomers!.id ==
                                chooseAddressCustomerController
                                    .listInfoAddressCustomer[index].id
                            ? Icon(Icons.check_outlined,
                                color: Theme.of(context).primaryColor)
                            : Container(),
                    Container(
                      padding: EdgeInsets.all(6),
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/pin.svg",
                        color: chooseAddressCustomerController
                                .listInfoAddressCustomer[index].isDefault!
                            ? Theme.of(context).primaryColor
                            : Colors.grey[500],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
