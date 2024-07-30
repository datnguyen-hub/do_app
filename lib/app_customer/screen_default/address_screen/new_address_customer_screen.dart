
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import '../../screen_default/address_screen/choose_address_customer_screen/choose_address_customer_screen.dart';
import '../../screen_default/address_screen/new_address_customer_controller.dart';
import '../../components//button/saha_button.dart';
import '../../model/location_address.dart';
import 'choose_address_customer_screen/choose_address_customer_controller.dart';

class NewAddressCustomerScreen extends StatefulWidget {
  @override
  _NewAddressCustomerScreenState createState() =>
      _NewAddressCustomerScreenState();
}

class _NewAddressCustomerScreenState extends State<NewAddressCustomerScreen> {
  late NewAddressCustomerController newAddressCustomerController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    newAddressCustomerController = new NewAddressCustomerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Địa chỉ mới"),
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
                        controller: newAddressCustomerController
                            .nameTextEditingController,
                        style: TextStyle(fontSize: 14),
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
                            hintText: "Điền Họ và tên"),
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
                        controller: newAddressCustomerController
                            .phoneTextEditingController,
                        validator: (value) {
                          if (value!.length != 10) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Điền Số điện thoại"),
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
                        controller: newAddressCustomerController
                            .emailTextEditingController,
                        validator: (value) {
                          if ((value?.length ?? 0) > 0) {
                            if (GetUtils.isEmail(value ?? "")) {
                              return null;
                            } else {
                              return 'Email không hợp lệ';
                            }
                          } else {
                            return null;
                          }
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
                          newAddressCustomerController.locationProvince.value =
                              location;
                          newAddressCustomerController.locationDistrict.value =
                              new LocationAddress();
                          newAddressCustomerController.locationWard.value =
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
                              "${newAddressCustomerController.locationProvince.value.name ?? "Điền Tỉnh/Thành phố"}")),
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
              Obx(
                () => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ChooseAddressCustomerScreen(
                              typeAddress: TypeAddress.District,
                              idProvince: newAddressCustomerController
                                      .locationProvince.value.id ??
                                  0,
                              callback: (LocationAddress location) {
                                newAddressCustomerController
                                    .locationDistrict.value = location;
                                newAddressCustomerController
                                    .locationWard.value = new LocationAddress();
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
                                Obx(() => Text(
                                    "${newAddressCustomerController.locationDistrict.value.name ?? "Chưa chọn Quận/Huyện"}")),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (newAddressCustomerController
                            .locationProvince.value.id ==
                        null)
                      Positioned.fill(
                          child: Container(
                        color: Colors.grey[200]!.withOpacity(0.5),
                      ))
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Obx(
                () => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ChooseAddressCustomerScreen(
                              typeAddress: TypeAddress.Wards,
                              idDistrict: newAddressCustomerController
                                      .locationDistrict.value.id ??
                                  0,
                              callback: (LocationAddress location) {
                                newAddressCustomerController
                                    .locationWard.value = location;
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
                                      "${newAddressCustomerController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (newAddressCustomerController
                            .locationDistrict.value.id ==
                        null)
                      Positioned.fill(
                          child: Container(
                        color: Colors.grey[200]!.withOpacity(0.5),
                      ))
                  ],
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
                          child: TextFormField(
                            controller: newAddressCustomerController
                                .addressDetailTextEditingController,
                            validator: (value) {
                              if (value!.length <= 0) {
                                return 'Chưa nhập địa chỉ cụ thể';
                              }
                              return null;
                            },
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
                        value: newAddressCustomerController.isDefault.value,
                        onChanged: (bool val) {
                          newAddressCustomerController.isDefault.value = val;
                        },
                      ),
                    )
                  ],
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
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "LƯU",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (newAddressCustomerController.locationWard.value.id ==
                      null) {
                    SahaAlert.showError(message: "Địa chỉ không hợp lệ");
                  } else {
                    if (newAddressCustomerController.isLoadingCreate.value ==
                        false) {
                      newAddressCustomerController.createAddressCustomer();
                    }
                  }
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
