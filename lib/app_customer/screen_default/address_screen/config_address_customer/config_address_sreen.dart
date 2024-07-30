import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/model/info_address_customer.dart';
import 'package:sahashop_customer/app_customer/model/location_address.dart';
import 'package:sahashop_customer/app_customer/screen_default/address_screen/choose_address_customer_screen/choose_address_customer_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/address_screen/choose_address_customer_screen/choose_address_customer_screen.dart';

import 'config_address_customer_controller.dart';

class ConfigAddressCustomerScreen extends StatefulWidget {
  final InfoAddressCustomer? infoAddressCustomer;

  ConfigAddressCustomerScreen({this.infoAddressCustomer}) {}

  @override
  State<ConfigAddressCustomerScreen> createState() =>
      _ConfigAddressCustomerScreenState();
}

class _ConfigAddressCustomerScreenState
    extends State<ConfigAddressCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late ConfigAddressCustomerController configAddressCustomerController;

  @override
  void initState() {
    configAddressCustomerController = ConfigAddressCustomerController(
      infoAddressCustomer: widget.infoAddressCustomer,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa địa chỉ"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Họ và tên"),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        controller: configAddressCustomerController
                            .nameTextEditingController.value,
                        textAlign: TextAlign.end,
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Chưa nhập họ và tên';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Số điện thoại"),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value!.length < 10) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                        controller: configAddressCustomerController
                            .phoneTextEditingController.value,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email"),
                    Expanded(
                      child: TextFormField(
                        controller: configAddressCustomerController
                            .emailTextEditingController.value,
                        validator: (values) {
                          print(values!.length);
                          var value = values.toString().replaceAll(" ", "");
                          if (value.length > 1 && value != "") {
                            print(value);
                            print(GetUtils.isEmail(value));
                            if (GetUtils.isEmail(value)) {
                              return null;
                            } else {
                              return 'Email không hợp lệ';
                            }
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Điền Email"),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseAddressCustomerScreen(
                        typeAddress: TypeAddress.Province,
                        callback: (LocationAddress location) {
                          configAddressCustomerController
                              .locationProvince.value = location;
                          configAddressCustomerController
                              .locationDistrict.value = new LocationAddress();
                          configAddressCustomerController.locationWard.value =
                              new LocationAddress();
                        },
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tỉnh/Thành phố"),
                      Row(
                        children: [
                          Obx(() => Text(
                              "${configAddressCustomerController.locationProvince.value.name ?? "Chưa chọn Tỉnh/Thành phố"}")),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseAddressCustomerScreen(
                        typeAddress: TypeAddress.District,
                        idProvince: configAddressCustomerController
                            .locationProvince.value.id,
                        callback: (LocationAddress location) {
                          configAddressCustomerController
                              .locationDistrict.value = location;
                          configAddressCustomerController.locationWard.value =
                              new LocationAddress();
                        },
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quận/Huyện"),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                                "${configAddressCustomerController.locationDistrict.value.name ?? "Chưa chọn Quận/Huyện"}"),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseAddressCustomerScreen(
                        typeAddress: TypeAddress.Wards,
                        idDistrict: configAddressCustomerController
                            .locationDistrict.value.id,
                        callback: (LocationAddress location) {
                          configAddressCustomerController.locationWard.value =
                              location;
                        },
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Phường/Xã"),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                                "${configAddressCustomerController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Địa chỉ cụ thể"),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Số nhà, tên tòa nhà, tên đường, tên khu vực",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width * 0.9,
                          child: TextField(
                            controller: configAddressCustomerController
                                .addressDetailTextEditingController.value,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập địa chỉ cụ thể",
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 12,
                color: Colors.grey[200],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Đặt làm địa chỉ mặc định"),
                    Obx(
                      () => CupertinoSwitch(
                        value: configAddressCustomerController.isDefault.value,
                        onChanged: (bool val) {
                          configAddressCustomerController.isDefault.value = val;
                        },
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   height: 12,
              //   color: Colors.grey[200],
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     padding: EdgeInsets.all(10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               padding: EdgeInsets.all(6),
              //               height: 40,
              //               width: 40,
              //               child: SvgPicture.asset("packages/sahashop_customer/assets/icons/pin.svg",
              //                   color: Theme.of(context).primaryColor),
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text("Chọn vị trí trên bản đồ"),
              //                 SizedBox(
              //                   height: 3,
              //                 ),
              //                 Text(
              //                   "Giúp đơn hàng được giao nhanh nhất",
              //                   style: TextStyle(
              //                     color: Colors.grey[700],
              //                     fontSize: 12,
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ],
              //         ),
              //         Icon(Icons.arrow_forward_ios_rounded),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                height: 12,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {
                  configAddressCustomerController.deleteAddressCustomer();
                },
                child: Container(
                  padding: EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Xóa Địa chỉ",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 12,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        child: Column(
          children: [
            Obx(
              () =>
                  configAddressCustomerController.isLoadingUpdate.value == false
                      ? SahaButtonFullParent(
                          text: "LƯU",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (configAddressCustomerController
                                      .isLoadingUpdate.value ==
                                  false) {
                                configAddressCustomerController
                                    .updateAddressCustomer();
                              }
                            }
                          },
                          color: Theme.of(context).primaryColor,
                        )
                      : IgnorePointer(
                          child: SahaButtonFullParent(
                            text: "Lưu",
                            textColor: Colors.grey[600],
                            onPressed: () {},
                            color: Colors.grey[300],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
