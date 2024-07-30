import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/components/text_field/sahashopTextField.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/branches.dart';
import 'package:sahashop_customer/app_customer/screen_default/confirm_screen/choose_branches/choose_branches_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../model/order.dart';
import '../../screen_default/data_app_controller.dart';
import '../../components/empty/saha_empty_image.dart';
import '../../screen_default/address_screen/choose_address_receiver/receiver_address_screen.dart';
import '../../screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import '../../screen_default/confirm_screen/confirm_controller.dart';
import '../../screen_default/payment_method/payment_method_customer_screen.dart';
import '../../screen_default/shipment_screen/shipment_customer_screen.dart';
import '../../model/info_address_customer.dart';
import '../../model/shipment_method.dart';
import '../../utils/string_utils.dart';

// ignore: must_be_immutable
class ConfirmScreen extends StatelessWidget {
  ConfirmController confirmController = Get.put(ConfirmController());
  DataAppCustomerController dataAppCustomerController = Get.find();
  final dataKey = new GlobalKey();
  final dataKeyPayment = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Xác nhận đơn hàng"),
        ),
        body: Obx(
          ()=>confirmController.loadingData.value ? SahaLoadingFullScreen(): SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  key: dataKey,
                  height: 5,
                ),
                Obx(
                  () => Column(
                    children: [
                      confirmController.infoAddressCustomer.value?.id != null
                          ? Card(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ReceiverAddressCustomerScreen(
                                            infoAddressCustomers:
                                                confirmController
                                                    .infoAddressCustomer.value,
                                            callback: (InfoAddressCustomer
                                                infoAddressCustomer) {
                                              confirmController
                                                  .infoAddressCustomer
                                                  .value = infoAddressCustomer;
                                            },
                                          ))!
                                      .then((value) => {
                                            confirmController.cartController
                                                .chargeShipmentFee(idAddressCustomer:
                                                    confirmController
                                                        .infoAddressCustomer
                                                        .value!
                                                        .id,branchId: confirmController.branchChoose.value.id),
                                          });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                              "packages/sahashop_customer/assets/icons/location.svg",
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Địa chỉ nhận hàng :"),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "${confirmController.infoAddressCustomer.value!.name ?? "Chưa có tên"}  | ${confirmController.infoAddressCustomer.value!.phone ?? "Chưa có số điện thoại"}",
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "${confirmController.infoAddressCustomer.value!.email ?? "Chưa có Email"}",
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "${confirmController.infoAddressCustomer.value!.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "${confirmController.infoAddressCustomer.value!.wardsName ?? "Chưa có Phường/Xã"}, ${confirmController.infoAddressCustomer.value!.districtName ?? "Chưa có Quận/Huyện"}, ${confirmController.infoAddressCustomer.value!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 13),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Card(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ReceiverAddressCustomerScreen(
                                            infoAddressCustomers:
                                                confirmController
                                                    .infoAddressCustomer.value,
                                            callback: (InfoAddressCustomer
                                                infoAddressCustomer) {
                                              confirmController
                                                  .infoAddressCustomer
                                                  .value = infoAddressCustomer;
                                            },
                                          ))!
                                      .then((value) => {
                                            confirmController.cartController
                                                .chargeShipmentFee(idAddressCustomer:
                                                    confirmController
                                                        .infoAddressCustomer
                                                        .value!
                                                        .id,branchId: confirmController.branchChoose.value.id)
                                          });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF5F6F9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                                "packages/sahashop_customer/assets/icons/location.svg",
                                                color: SahaColorUtils()
                                                    .colorPrimaryTextWithWhiteBackground()),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Địa chỉ nhận hàng :"),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "Chưa chọn địa chỉ nhận hàng (nhấn để chọn)",
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Obx(
                  ()=>dataAppCustomerController.badge.value.allowBranchPaymentOrder == true ? Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,15,15,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CHI NHÁNH",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                           
                            InkWell(
                              onTap: (){
                               
                                Get.to(()=>ChooseBranchesScreen(
                                  onChooose: (Branches branch) async {
                                    confirmController.branchChoose.value = branch;
                                    confirmController.loadingData.value = true;
                                     await confirmController.cartController
                                    .chargeShipmentFee(idAddressCustomer: confirmController
                                        .infoAddressCustomer.value!.id,branchId: confirmController.branchChoose.value.id);
                                        confirmController.loadingData.value = false;
                                  },
                                  listBranches: confirmController.listBranches,
                                ));
                              },
                                child: Text(
                              "Thay đổi",
                              style: TextStyle(color: Colors.blue),
                            ))
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Obx(
                          () => confirmController.isLoadingBranches.value
                              ? const SizedBox()
                              : confirmController.branchChoose.value.id == null
                                  ? Text("Bạn chưa chọn chi nhánh nào")
                                  : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          confirmController.branchChoose.value.name ??
                                              "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        if (confirmController
                                                .branchChoose.value.addressDetail !=
                                            null)
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text("${confirmController.branchChoose.value.addressDetail ?? ''} ${confirmController.branchChoose.value.wardsName ?? ''} ${confirmController.branchChoose.value.districtName ?? ''} ${confirmController.branchChoose.value.provinceName ?? ''}")
                                            ],
                                          ),
                                      ],
                                    ),
                        )
                      ],
                    ),
                  ) : const SizedBox()
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/cart_icon.svg",
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Các mặt hàng đã đặt :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  confirmController.cartController.listOrder.length,
                  (index) => itemProduct(
                      confirmController.cartController.listOrder[index]),
                ),
                // Obx(
                //   () =>
                InkWell(
                  onTap: () {
                    if (confirmController.infoAddressCustomer.value?.id != 0) {
                      Get.to(() => ShipmentCustomerScreen(
                        branchId: confirmController.branchChoose.value.id,
                            infoAddressCustomer:
                                confirmController.infoAddressCustomer.value,
                            callback: (ShipmentMethod shipmentMethod) {
                              confirmController.cartController
                                  .shipmentMethodCurrent.value = shipmentMethod;
                              print(shipmentMethod.fee);
        
                              confirmController.cartController.getItemCart();
                            },
                            shipmentMethodInput: confirmController
                                .cartController.shipmentMethodCurrent.value,
                          ));
                    } else {
                      Get.to(() => ReceiverAddressCustomerScreen(
                                infoAddressCustomers:
                                    confirmController.infoAddressCustomer.value,
                                callback:
                                    (InfoAddressCustomer infoAddressCustomer) {
                                  confirmController.infoAddressCustomer.value =
                                      infoAddressCustomer;
                                },
                              ))!
                          .then((value) => {
                                confirmController.cartController
                                    .chargeShipmentFee(idAddressCustomer: confirmController
                                        .infoAddressCustomer.value!.id,branchId: confirmController.branchChoose.value.id)
                              });
                    }
                  },
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.green)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Đơn vị vận chuyển ( Nhấn để chọn )',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.green),
                              ),
                            ],
                          ),
                          Divider(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  confirmController
                                              .cartController
                                              .shipmentMethodCurrent
                                              .value
                                              .shipType ==
                                          0
                                      ? Text(
                                          'Vận chuyển nhanh',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          'Vận chuyển siêu tốc',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${confirmController.cartController.shipmentMethodCurrent.value.name ?? "Chưa chọn đơn vị vẩn chuyển"} (Tạm tính)"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Nhận hàng sau 1 - 2 ngày nội thành",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      '${SahaStringUtils().convertToMoney(confirmController.cartController.shipmentMethodCurrent.value.fee)}đ'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //),
                Divider(
                  height: 1,
                ),
                Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng số tiền (${confirmController.cartController.listOrder.length} sản phẩm) : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Text(
                            "${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.totalBeforeDiscount ?? 0)}"),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ChooseVoucherCustomerScreen());
                  },
                  child: Container(
                    key: dataKeyPayment,
                    height: 55,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/receipt.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Shop Voucher : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Spacer(),
                        Obx(
                          () => confirmController
                                      .cartController.voucherCodeChoose.value ==
                                  ""
                              ? Text("Chọn hoặc nhập mã")
                              : Text(
                                  "Mã: ${confirmController.cartController.voucherCodeChoose.value}",
                                  style: TextStyle(fontSize: 13),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground(),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
                confirmController.paymentMethodName.value != ""
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        height: 55,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => PaymentMethodCustomerScreen(
                                  paymentPartnerId:
                                      confirmController.paymentPartnerId.value,
                                  callback: (String paymentMethodName,
                                      int paymentPartnerId, int paymentMethodId) {
                                    confirmController.paymentMethodName.value =
                                        paymentMethodName;
                                    confirmController.paymentPartnerId.value =
                                        paymentPartnerId;
                                    confirmController.paymentMethodId.value =
                                        paymentMethodId;
                                    print(
                                        "================>${confirmController.paymentMethodId.value}");
                                  },
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/icons/money.svg",
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Phương thức thanh toán',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Obx(
                                  () => Container(
                                      width: 120,
                                      child: confirmController
                                                  .paymentMethodName.value ==
                                              ""
                                          ? Text(
                                              "Chọn phương thức thanh toán",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          : Text(
                                              "${confirmController.paymentMethodName.value}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Get.to(() => PaymentMethodCustomerScreen(
                                paymentPartnerId:
                                    confirmController.paymentPartnerId.value,
                                callback: (String paymentMethodName,
                                    int paymentPartnerId, int paymentMethodId) {
                                  confirmController.paymentMethodName.value =
                                      paymentMethodName;
                                  confirmController.paymentPartnerId.value =
                                      paymentPartnerId;
                                  confirmController.paymentMethodId.value =
                                      paymentMethodId;
                                },
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/money.svg",
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Phương thức thanh toán',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Obx(
                                () => Container(
                                  width: 120,
                                  child:
                                      confirmController.paymentMethodName.value ==
                                              ""
                                          ? Text(
                                              "Chọn phương thức thanh toán",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground()),
                                            )
                                          : Text(
                                              "${confirmController.paymentMethodName.value}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground()),
                                            ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => dataAppCustomerController
                                  .badge.value.allowUsePointOrder ==
                              true &&
                          confirmController.cartController.cartData.value
                                  .totalPointsCanUse !=
                              0 &&
                          confirmController.cartController.cartData.value
                                  .totalPointsCanUse !=
                              null
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/money.svg",
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Dùng ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.bonusPointsAmountCanUse ?? 0)} xu ",
                                style: TextStyle(fontSize: 13),
                              ),
                              Spacer(),
                              Text(
                                  "[-${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.bonusPointsAmountUsed ?? 0)}₫] "),
                              CupertinoSwitch(
                                value: confirmController
                                    .cartController.cartData.value.isUsePoints!,
                                onChanged: (bool value) {
                                  confirmController.cartController.cartData.value
                                          .isUsePoints =
                                      !confirmController.cartController.cartData
                                          .value.isUsePoints!;
                                  confirmController.cartController.addVoucherCart(
                                      confirmController
                                          .cartController.voucherCodeChoose.value,
                                      (err) {});
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                Divider(
                  height: 1,
                ),
                Obx(() => dataAppCustomerController.badge.value.statusAgency == 1
                    ? Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/drop_shipping.svg",
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground(),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Đặt hộ",
                                  style: TextStyle(fontSize: 13, height: 1.7),
                                ),
                                Spacer(),
                                CupertinoSwitch(
                                  value: confirmController.cartController.cartData
                                          .value.isOrderForCustomer ??
                                      false,
                                  onChanged: (bool value) {
                                    confirmController.cartController.cartData
                                        .value.isOrderForCustomer = value;
                                    confirmController.cartController.cartData
                                        .refresh();
                                  },
                                )
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      )
                    : const SizedBox()),
        
                Obx(
                  () => confirmController
                              .cartController.balanceCollaboratorCanUse.value >
                          0
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/fair_trade.svg",
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Dùng số dư cộng tác viên ",
                                style: TextStyle(fontSize: 13),
                              ),
                              Spacer(),
                              Text(
                                  "[-${SahaStringUtils().convertToMoney(confirmController.cartController.balanceCollaboratorCanUse.value)}₫] "),
                              CupertinoSwitch(
                                value: confirmController.cartController
                                    .isUseBalanceCollaborator.value,
                                onChanged: (bool value) {
                                  confirmController.cartController
                                          .isUseBalanceCollaborator.value =
                                      !confirmController.cartController
                                          .isUseBalanceCollaborator.value;
                                  confirmController.cartController.addVoucherCart(
                                      confirmController
                                          .cartController.voucherCodeChoose.value,
                                      (err) {});
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/bill_icon.svg",
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Xuất hoá đơn công ty ",
                          style: TextStyle(fontSize: 13),
                        ),
                        Spacer(),
                        CupertinoSwitch(
                          value: confirmController.isExportBill.value,
                          onChanged: (bool value) {
                            confirmController.isExportBill.value = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => confirmController.isExportBill.value == true
                      ? Column(
                          children: [
                            SahaTextField(
                              labelText: "Tên công ty",
                              hintText: "Nhập tên công ty",
                              controller: confirmController.companyName,
                            ),
                            SahaTextField(
                              labelText: "Mã số thuế",
                              hintText: "Nhập mã số thuế",
                              controller: confirmController.taxCode,
                            ),
                            SahaTextField(
                              labelText: "Địa chỉ công ty",
                              hintText: "Nhập địa chỉ công ty",
                              controller: confirmController.companyAddress,
                            ),
                            SahaTextField(
                              labelText: "Email nhận hoá đơn",
                              hintText: "Nhập email nhận hoá đơn",
                              controller: confirmController.companyEmail,
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                'Tin nhắn : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: confirmController
                                      .noteCustomerEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Lưu ý cho người bán ...",
                                  ),
                                  style: TextStyle(fontSize: 14),
                                  minLines: 1,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => confirmController
                              .cartController.balanceAgencyCanUse.value >
                          0
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/home.svg",
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Dùng số dư đại lý ",
                                style: TextStyle(fontSize: 13),
                              ),
                              Spacer(),
                              Text(
                                  "[-${SahaStringUtils().convertToMoney(confirmController.cartController.balanceAgencyCanUse.value)}₫] "),
                              CupertinoSwitch(
                                value: confirmController
                                    .cartController.isUseBalanceAgency.value,
                                onChanged: (bool value) {
                                  confirmController.cartController
                                          .isUseBalanceAgency.value =
                                      !confirmController.cartController
                                          .isUseBalanceAgency.value;
                                  confirmController.cartController.addVoucherCart(
                                      confirmController
                                          .cartController.voucherCodeChoose.value,
                                      (err) {});
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tạm tính :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  "${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.totalBeforeDiscount ?? 0)}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        confirmController.cartController.cartData.value
                                    .productDiscountAmount ==
                                0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Giảm giá sản phẩm :',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                    Text(
                                        "- ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.productDiscountAmount)}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[800])),
                                  ],
                                ),
                              ),
                        confirmController.cartController.cartData.value
                                    .comboDiscountAmount ==
                                0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Giảm giá combo :',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                    Text(
                                        "- ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.comboDiscountAmount)}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[800])),
                                  ],
                                ),
                              ),
                        confirmController.cartController.cartData.value
                                    .voucherDiscountAmount ==
                                0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Giảm giá voucher :',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                    Text(
                                        "- ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.voucherDiscountAmount)}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[800])),
                                  ],
                                ),
                              ),
                        confirmController
                                    .cartController.cartData.value.isUsePoints ==
                                false
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Giảm giá Xu :',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                    Text(
                                        "- ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.bonusPointsAmountUsed)}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[800])),
                                  ],
                                ),
                              ),
                        Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng tiền hàng :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  "${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.totalAfterDiscount)}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        if (confirmController.cartController.cartData.value.vat !=
                                null &&
                            confirmController.cartController.cartData.value.vat !=
                                0)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('VAT :',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                                Text(
                                    "${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.vat)}",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng tiền vận chuyển :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  "+ ${SahaStringUtils().convertToMoney(confirmController.cartController.shipmentMethodCurrent.value.fee!.toDouble())}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        if ((confirmController.cartController.cartData.value
                                    .shipDiscountAmount ??
                                0) !=
                            0)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Giảm giá vận chuyển:',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                                Text(
                                    "- ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.shipDiscountAmount ?? 0)}",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        if (dataAppCustomerController.badge.value.statusAgency ==
                            1)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tiền hoa hồng đặt hộ :',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                                Text(
                                    "+ ${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.totalCommissionOrderForCustomer)}",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tổng thanh toán :',
                              ),
                              Text(
                                  "${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.totalFinal)}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey[200],
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/doc.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                                "Nhấn 'Đặt hàng' đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản ${StoreInfo().name} "),
                          )
                        ],
                      ),
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
        bottomNavigationBar: Obx(
          () => Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 0.1), // Shadow position
              ),
            ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Tổng thanh toán"),
                    Text(
                      "${SahaStringUtils().convertToMoney(confirmController.cartController.cartData.value.totalFinal ?? 0)}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (confirmController.infoAddressCustomer.value?.id == 0) {
                      Scrollable.ensureVisible(dataKey.currentContext!,
                          duration: Duration(milliseconds: 500));
                      SahaAlert.showError(message: 'Chưa chọn địa chỉ');
                    } else {
                      if (confirmController.paymentMethodName.value == "") {
                        Scrollable.ensureVisible(dataKeyPayment.currentContext!,
                            duration: Duration(milliseconds: 500));
                        SahaAlert.showError(
                            message: 'Chưa chọn phương thức thanh toán');
                      } else {
                        if (confirmController.loading.value == false && confirmController.loadingData.value == false) {
                          await confirmController.createOrders();
                          dataAppCustomerController.getBadge();
                        }
                      }
                    }
                  },
                  child: Obx(
                    () => Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: (confirmController.loading.value || confirmController.loadingData.value)
                              ? Colors.grey[300]
                              : Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey[200]!)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Đặt hàng",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge!
                                    .color,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget itemProduct(LineItem lineItem) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: lineItem.product!.images!.length == 0
                            ? ""
                            : lineItem.product!.images![0].imageUrl!,
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lineItem.product!.name ?? "Lỗi sản phẩm",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      if (lineItem.distributesSelected != null &&
                          lineItem.distributesSelected!.isNotEmpty)
                        SizedBox(
                          height: 5,
                        ),
                      if (lineItem.distributesSelected != null &&
                          lineItem.distributesSelected!.isNotEmpty)
                        Text(
                          'Phân loại: ${lineItem.distributesSelected![0].value ?? ""}${lineItem.distributesSelected![0].subElement == null ? "" : ","} ${lineItem.distributesSelected![0].subElement ?? ""}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${SahaStringUtils().convertToMoney(lineItem.itemPrice)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground()),
                            ),
                          ),
                          Text(" x${lineItem.quantity}   ",
                              style:
                                  Theme.of(Get.context!).textTheme.bodyLarge),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
