import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/choose_voucher/voucher_product/voucher_product_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../components/empty/saha_empty_voucher.dart';
import '../../screen_default/choose_voucher/choose_voucher_customer_controller.dart';
import '../../screen_default/choose_voucher/detail_voucher_screen/detail_voucher_screen.dart';
import '../../components//button/saha_button.dart';
import '../../utils/date_utils.dart';
import '../../utils/string_utils.dart';

// ignore: must_be_immutable
class ChooseVoucherCustomerScreen extends StatelessWidget {
  bool? isWatch;

  late ChooseCustomerController chooseCustomerController;
  String? voucherCodeChooseInput;
  ChooseVoucherCustomerScreen({this.voucherCodeChooseInput, this.isWatch}) {
    chooseCustomerController = ChooseCustomerController(
        voucherCodeChooseInput: voucherCodeChooseInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ví Voucher"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: Get.width,
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: Get.width * 0.7,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground())),
                      child: Center(
                        child: TextField(
                          controller: chooseCustomerController
                              .codeVoucherEditingController.value,
                          style: TextStyle(fontSize: 14),
                          onChanged: (v) {
                            chooseCustomerController.voucherCodeChoose.value = v;
                            chooseCustomerController
                                .codeVoucherEditingController
                                .refresh();
                          },
                          autofocus: false,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập mã Voucher"),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          chooseCustomerController
                              .codeVoucherEditingController.value.text = "";
                          chooseCustomerController.codeVoucherEditingController
                              .refresh();
                        },
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[600]),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey[200],
                            size: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Obx(
                  () => chooseCustomerController
                              .codeVoucherEditingController.value.text ==
                          ""
                      ? Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey[300]),
                          child: Center(
                            child: Text(
                              "Áp dụng",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge!
                                      .color),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            chooseCustomerController.enterCodeVoucher(context);
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child: Text(
                                "Áp dụng",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleLarge!
                                        .color),
                              ),
                            ),
                          ),
                        ),
                )),
              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => chooseCustomerController.listVoucher.isEmpty
                    ? SahaEmptyVoucher(
                        width: 50,
                        height: 50,
                      )
                    : 
                    
                    Column(
                        children: [
                          ...List.generate(
                            chooseCustomerController.listVoucher.length,
                            (index) { 
                              print("Ngan xau $index");
                               print("Ngan xinh is ${chooseCustomerController.listVoucher.length}");
                              return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[300]!)),
                                    child: Row(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                border: Border.all(
                                                    color: Colors.grey[500]!),
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                  width: 80,
                                                  child: chooseCustomerController
                                                      .listVoucher[
                                                  index]
                                                      .discountFor ==
                                                      1
                                                      ? Text(
                                                    "Miễn phí vận chuyển",
                                                    textAlign:
                                                    TextAlign.center,
                                                    style: TextStyle(
                                                      color: Theme.of(
                                                          context)
                                                          .primaryTextTheme
                                                          .titleLarge!
                                                          .color,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    maxLines: 4,
                                                  )
                                                      :  chooseCustomerController
                                                              .listVoucher[
                                                                  index]
                                                              .voucherType ==
                                                          1
                                                      ? chooseCustomerController
                                                                  .listVoucher[
                                                                      index]
                                                                  .discountType ==
                                                              1
                                                          ? Text(
                                                              "Mã: ${chooseCustomerController.listVoucher[index].code} giảm ${chooseCustomerController.listVoucher[index].valueDiscount} %",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleLarge!
                                                                    .color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 4,
                                                            )
                                                          : Text(
                                                              "Mã: ${chooseCustomerController.listVoucher[index].code} giảm ${SahaStringUtils().convertToMoney(chooseCustomerController.listVoucher[index].valueDiscount)}đ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleLarge!
                                                                    .color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 4,
                                                            )
                                                      : chooseCustomerController
                                                                  .listVoucher[
                                                                      index]
                                                                  .discountType ==
                                                              1
                                                          ? Text(
                                                              "Mã: ${chooseCustomerController.listVoucher[index].code} giảm ${chooseCustomerController.listVoucher[index].valueDiscount} %",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleLarge!
                                                                    .color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 4,
                                                            )
                                                          : Text(
                                                              "Mã: ${chooseCustomerController.listVoucher[index].code} giảm ${SahaStringUtils().convertToMoney(chooseCustomerController.listVoucher[index].valueDiscount)}đ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleLarge!
                                                                    .color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 4,
                                                            ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              height: 8,
                                              width: 8,
                                              top: 5,
                                              left: -4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              height: 8,
                                              width: 8,
                                              top: 20,
                                              left: -4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              height: 8,
                                              width: 8,
                                              top: 35,
                                              left: -4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              height: 8,
                                              width: 8,
                                              top: 50,
                                              left: -4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              height: 8,
                                              width: 8,
                                              top: 65,
                                              left: -4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              height: 8,
                                              width: 8,
                                              top: 80,
                                              left: -4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        chooseCustomerController
                                                            .checkChooseVoucher(
                                                                chooseCustomerController
                                                                        .listChooseVoucher[
                                                                    index],
                                                                index);
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${chooseCustomerController.listVoucher[index].name}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                            maxLines: 2,
                                                          ),
                                                            Text(
                                                            "Còn lại ${(chooseCustomerController.listVoucher[index].amount ?? 0) - (chooseCustomerController.listVoucher[index].used ?? 0)} mã",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                            maxLines: 2,
                                                          ),
                                                          if ((chooseCustomerController.listVoucher[index].shipDiscountValue ?? 0) != 0)
                                                            Text(
                                                              "Tối đa: ${SahaStringUtils().convertToMoney(chooseCustomerController.listVoucher[index].shipDiscountValue ?? 0)}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                              maxLines: 2,
                                                            ),
                                                          chooseCustomerController
                                                                      .listVoucher[
                                                                          index]
                                                                      .voucherType ==
                                                                  1
                                                              ? Text(
                                                                  "Giảm giá cho các sản phẩm sau:",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                  maxLines: 2,
                                                                )
                                                              : Text(
                                                                  "Giảm giá cho toàn bộ các sản phẩm",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                  maxLines: 2,
                                                                ),
                                                          chooseCustomerController
                                                                      .listVoucher[
                                                                          index]
                                                                      .voucherType ==
                                                                  1
                                                              ? Text(
                                                                  // "${chooseCustomerController.listVoucher[index].products?[0].name ?? ""}, vv...",
                                                                  "",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                  maxLines: 1,
                                                                )
                                                              : Container(),
                                                          Text(
                                                            "HSD: ${SahaDateUtils().getDDMMYY(chooseCustomerController.listVoucher[index].endTime!)}",
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  if (isWatch != true)
                                                    GestureDetector(
                                                      onTap: () {
                                                        chooseCustomerController
                                                            .checkChooseVoucher(
                                                                chooseCustomerController
                                                                        .listChooseVoucher[
                                                                    index],
                                                                index);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                          color: chooseCustomerController
                                                                      .listChooseVoucher[
                                                                  index]
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Colors.white,
                                                        ),
                                                        child: chooseCustomerController
                                                                    .listChooseVoucher[
                                                                index]
                                                            ? Icon(
                                                                Icons.check,
                                                                size: 15.0,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleLarge!
                                                                    .color,
                                                              )
                                                            : Container(),
                                                      ),
                                                    ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isWatch == true)
                                  Positioned(
                                    bottom: 90,
                                    right: 15,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => VoucherProductScreen(
                                              voucher: chooseCustomerController
                                                  .listVoucher[index],
                                            ));
                                        // print("SOMETHING");
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Dùng ngay",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.deepOrange),
                                          ),
                                          Icon(Icons.chevron_right_rounded,
                                              color: Colors.deepOrange),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (isWatch != true)
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => DetailVoucherScreen(
                                              voucher: chooseCustomerController
                                                  .listVoucher[index],
                                            ));
                                      },
                                      child: Text(
                                        "Điều kiện",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.red),
                                      ),
                                    ),
                                  )
                              ],
                            );}
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWatch == true
          ? Container(
              height: 1,
            )
          : Container(
              height: 65,
              color: Colors.white,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    text: "Đồng ý",
                    onPressed: () {
                      chooseCustomerController.checkConditionVoucher(context);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
    );
  }
}
