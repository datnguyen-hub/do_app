import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/update_info_collaborator/udpate_info_collaborator_controller.dart';

import '../../../components/button/saha_button.dart';
import '../../../components/text_field/text_field_no_border.dart';
import '../../../components/widget/image_picker_single/image_picker_single.dart';

class UpdateInfoCollaboratorScreen extends StatelessWidget {
  UpdateInfoCollaboratorScreen({super.key, this.isFromCheckStatus}) {
    controller =
        UpdateInfoCollaboratorController(isFromCheckStatus: isFromCheckStatus);
  }
  final _formKey = GlobalKey<FormState>();
  late UpdateInfoCollaboratorController controller;

  bool? isFromCheckStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Đăng ký cộng tác viên",
          ),
        ),
        body: Form(
          key: _formKey,
          child: Obx(
            () => controller.loadInit.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        SahaTextFieldNoBorder(
                          withAsterisk: true,
                          controller: controller.name,
                          onChanged: (v) {
                            controller.ctvReq.value.firstAndLastName = v!;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     SahaAlert.showError(message: "Chưa nhập họ tên");
                          //     return 'Không được để trống';
                          //   }
                          //   return null;
                          // },
                          labelText: "Họ và tên",
                          hintText: "Nhập họ và tên",
                        ),
                        Divider(),
                        SahaTextFieldNoBorder(
                          withAsterisk: true,
                          controller: controller.accountName,
                          onChanged: (v) {
                            controller.ctvReq.value.accountName = v!;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     SahaAlert.showError(message: "Chưa nhập họ tên");
                          //     return 'Không được để trống';
                          //   }
                          //   return null;
                          // },
                          labelText: "Tên tài khoản",
                          hintText: "Nhập tên tài khoản",
                        ),
                        Divider(),
                        SahaTextFieldNoBorder(
                          withAsterisk: true,
                          controller: controller.accountNumber,
                          onChanged: (v) {
                            controller.ctvReq.value.accountNumber = v!;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     SahaAlert.showError(message: "Chưa nhập số tài khoản");
                          //     return 'Không được để trống';
                          //   }
                          //   return null;
                          // },
                          labelText: "Số tài khoản",
                          hintText: "Nhập số tài khoản",
                        ),
                        Divider(),
                        SahaTextFieldNoBorder(
                          withAsterisk: true,

                          controller: controller.bank,
                          onChanged: (v) {
                            controller.ctvReq.value.bank = v!;
                          },
                          // validator: (value) {
                          //   if (value!.length == 0) {
                          //     return 'Không được để trống';
                          //   }
                          //   return null;
                          // },
                          labelText: "Ngân hàng",
                          hintText: "Nhập ngân hàng",
                        ),
                        Divider(),
                        SahaTextFieldNoBorder(
                          withAsterisk: false,

                          controller: controller.branch,
                          onChanged: (v) {
                            controller.ctvReq.value.branch = v!;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     SahaAlert.showError(message: "Chưa nhập số CMND/CCCD");
                          //     return 'Không được để trống';
                          //   }
                          //   return null;
                          // },
                          labelText: "Chi nhánh",
                          hintText: "Nhập chi nhánh",
                        ),
                        // SahaDivide(),
                        // SahaTextFieldNoBorder(
                        //   withAsterisk: true,
                        //   controller: addressTextEditingController,
                        //   onChanged: (v) {
                        //     renterCallback.value.address = v;
                        //   },
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       SahaAlert.showError(message: "Chưa nhập địa chỉ");
                        //       return 'Không được để trống';
                        //     }
                        //     return null;
                        //   },
                        //   labelText: "Địa chỉ",
                        //   hintText: "Nhập địa chỉ,thành phố, quận huyện, phường xã",
                        // ),
                        Divider(),
                        SahaTextFieldNoBorder(
                          withAsterisk: true,
                          textInputType: TextInputType.number,
                          controller: controller.cmnd,
                          onChanged: (v) {
                            controller.ctvReq.value.cmnd = v!;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     SahaAlert.showError(message: "Chưa nhập số CMND/CCCD");
                          //     return 'Không được để trống';
                          //   }
                          //   return null;
                          // },
                          labelText: "CMND/CCCD:",
                          hintText: "Nhập số CMND/CCCD",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text("CMND/CCCD mặt trước"),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Obx(
                                    () => ImagePickerSingle(
                                      type: '',
                                      width: Get.width / 3,
                                      height: Get.width / 4,
                                      linkLogo:
                                          controller.ctvReq.value.frontCard,
                                      onChange: (link) {
                                        print(link);
                                        controller.ctvReq.value.frontCard =
                                            link;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("CMND/CCCD mặt sau"),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Obx(
                                    () => ImagePickerSingle(
                                      type: '',
                                      width: Get.width / 3,
                                      height: Get.width / 4,
                                      linkLogo:
                                          controller.ctvReq.value.backCard,
                                      onChange: (link) {
                                        print(link);
                                        controller.ctvReq.value.backCard = link;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: "Đăng ký",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isFromCheckStatus == true) {
                      await controller.updateCollaboratorInfo();
                      controller.registerCtv();
                      print("fuckckckckckcckckckckc");
                    } else {
                      controller.updateCollaboratorInfo();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
