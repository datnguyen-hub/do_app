import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_shimmer.dart';
import 'package:sahashop_customer/app_customer/model/info_address_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/address_screen/config_address_customer/config_address_sreen.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import '../new_address_customer_screen.dart';
import 'all_address_customer_controller.dart';

class AllAddressCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: AllAddressCustomerLoggedScreen());
  }
}

// ignore: must_be_immutable
class AllAddressCustomerLoggedScreen extends StatefulWidget {
  @override
  State<AllAddressCustomerLoggedScreen> createState() =>
      _AllAddressCustomerLoggedScreenState();
}

class _AllAddressCustomerLoggedScreenState
    extends State<AllAddressCustomerLoggedScreen> {
  late AllAddressCustomerController allAddressCustomerController;

  bool isChoose = true;

  @override
  void initState() {
    allAddressCustomerController = AllAddressCustomerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Địa chỉ của tôi"),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => SahaSimmer(
              isLoading: allAddressCustomerController.isLoadingAddress.value,
              child: Column(
                children: [
                  ...List.generate(
                      allAddressCustomerController
                          .listInfoAddressCustomer.length,
                      (index) => addressSave(
                          context,
                          allAddressCustomerController
                              .listInfoAddressCustomer[index])),
                  InkWell(
                    onTap: () {
                      Get.to(() => NewAddressCustomerScreen())!.then((value) =>
                          {
                            allAddressCustomerController.getAllAddressCustomer()
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
        ));
  }

  Widget addressSave(
      BuildContext context, InfoAddressCustomer infoAddressCustomer) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => ConfigAddressCustomerScreen(
                      infoAddressCustomer: infoAddressCustomer,
                    ))!
                .then((value) =>
                    {allAddressCustomerController.getAllAddressCustomer()});

            print(
                "${infoAddressCustomer.wards} ${infoAddressCustomer.district} ${infoAddressCustomer.province}");
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
                        "${infoAddressCustomer.name ?? "Chưa có tên"}",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${infoAddressCustomer.email ?? "Chưa có email"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        "${infoAddressCustomer.phone ?? "Chưa có số điện thoại"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        "${infoAddressCustomer.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        "${infoAddressCustomer.wardsName ?? "Chưa có Phường/Xã"}, ${infoAddressCustomer.districtName ?? "Chưa có Quận/Huyện"}, ${infoAddressCustomer.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                infoAddressCustomer.isDefault!
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "[Mặc định]",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/pin.svg",
                              color: isChoose
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[500],
                            ),
                          ),
                        ],
                      )
                    : Container()
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
