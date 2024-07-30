import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../components/dialog/dialog.dart';
import '../../../components/text_field/rice_text_field.dart';

class ItemProductInCartWidget extends StatelessWidget {
  final LineItem lineItem;
  final int? quantity;
  final Function? onDismissed;
  final Function? onDecreaseItem;
  final Function? onIncreaseItem;
  final Function? onNote;
  final Function(int quantity, List<DistributesSelected> distributesSelected)?
      onUpdateProduct;

  ItemProductInCartWidget(
      {Key? key,
      required this.lineItem,
      this.onDismissed,
      this.onDecreaseItem,
      this.onIncreaseItem,
      this.quantity,
      this.onUpdateProduct,
      this.onNote})
      : super(key: key);

  bool canDecrease = true;
  bool canIncrease = true;
  TextEditingController note = TextEditingController();

  int? checkQuantytiItem() {
    if (lineItem.distributesSelected != null &&
        lineItem.product!.distributes!.isNotEmpty) {
      var distribute = lineItem.product!.distributes![0];
      var select = lineItem.distributesSelected![0];
      if (select.subElement != null) {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          var indexSub = distribute
              .elementDistributes![indexElement].subElementDistribute!
              .indexWhere((e) => e.name == select.subElement);
          if (indexSub != -1) {
            return distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].stock;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          return distribute.elementDistributes![indexElement].stock;
        } else {
          return null;
        }
      }
    }
    return null;
  }

  void checkCanCrease() {
    var product = lineItem.product!;

    var max = checkQuantytiItem() ??
        (product.quantityInStock == null || product.quantityInStock! < 0
            ? -1
            : product.quantityInStock);

    if (quantity == 1)
      canDecrease = false;
    else
      canDecrease = true;

    if (product.checkInventory == true) {
      if (quantity! + 1 > max! && max != -1)
        canIncrease = false;
      else
        canIncrease = true;
    } else {
      canIncrease = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var product = lineItem.product!;
    note.text = lineItem.note ?? '';

    checkCanCrease();
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: lineItem.isBonus == true
                  ? EdgeInsets.only(bottom: 0)
                  : EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  onDismissed!();
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                          "packages/sahashop_customer/assets/icons/trash.svg"),
                    ],
                  ),
                ),
                child: lineItem.isBonus == true
                    ? Container(
                        margin: EdgeInsets.only(left: 10, right: 0),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (lineItem.isBonus == true) SizedBox(width: 20),
                            Stack(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: imageItem() ??
                                              (product.images!.length == 0
                                                  ? ""
                                                  : product
                                                      .images![0].imageUrl!),
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                product.productDiscount == null
                                    ? Container()
                                    : Positioned(
                                        top: -12,
                                        left: 2,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              height: 45,
                                              width: 45,
                                              child: SvgPicture.asset(
                                                "packages/sahashop_customer/assets/icons/ribbon.svg",
                                                color: Color(0xfffdd100),
                                              ),
                                            ),
                                            Positioned(
                                              top: 15,
                                              left: 5,
                                              child: Text(
                                                "-${SahaStringUtils().convertToMoney(product.productDiscount!.value)} %",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xfffd5800)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 40),
                                            child: Text(
                                              product.name ?? "Không tên",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    lineItem.distributesSelected == null ||
                                            lineItem.distributesSelected!
                                                    .length ==
                                                0
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              if (lineItem.isBonus == false) {
                                                ModalBottomOptionBuyProduct
                                                    .showModelOption(
                                                        product:
                                                            lineItem.product!,
                                                        isOnlyAddToCart: true,
                                                        lineItemId: lineItem.id,
                                                        distributesSelectedParam:
                                                            lineItem
                                                                .distributesSelected,
                                                        quantity:
                                                            lineItem.quantity,
                                                        onSubmit: (int quantity,
                                                            Product product,
                                                            List<DistributesSelected>
                                                                distributesSelected,
                                                            bool? buyNow) {
                                                          onUpdateProduct!(
                                                              quantity,
                                                              distributesSelected);
                                                          Get.back();
                                                        });
                                              } else {
                                                if (lineItem
                                                        .allowsChooseDistribute ==
                                                    true) {
                                                  ModalBottomOptionBuyProduct
                                                      .showModelOption(
                                                          product:
                                                              lineItem.product!,
                                                          isOnlyAddToCart: true,
                                                          lineItemId:
                                                              lineItem.id,
                                                          distributesSelectedParam:
                                                              lineItem
                                                                  .distributesSelected,
                                                          quantity:
                                                              lineItem.quantity,
                                                          onSubmit: (int
                                                                  quantity,
                                                              Product product,
                                                              List<DistributesSelected>
                                                                  distributesSelected,
                                                              bool? buyNow) {
                                                            onUpdateProduct!(
                                                                quantity,
                                                                distributesSelected);
                                                            Get.back();
                                                          });
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 5,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints:
                                                        new BoxConstraints(
                                                      minWidth: 10,
                                                      maxWidth: Get.width * 0.5,
                                                    ),
                                                    child: Text(
                                                      'Phân loại: ${lineItem.distributesSelected![0].value ?? ""} ${lineItem.distributesSelected![0].subElement ?? ""}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  if (lineItem.isBonus != true)
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: Colors.grey[600],
                                                      size: 12,
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                    if (product.productDiscount != null)
                                      Row(
                                        children: [
                                          Text(
                                            product.productDiscount == null
                                                ? ""
                                                : "đ${SahaStringUtils().convertToMoney(((100 * lineItem.itemPrice!) / (100 - product.productDiscount!.value!)))}",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              "x $quantity",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (lineItem.isBonus == true) SizedBox(width: 10),
                            if (lineItem.isBonus == true)
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/presents.svg",
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      "${lineItem.bonusProductName ?? ""}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 11),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (lineItem.isBonus == true) SizedBox(width: 10),
                          Stack(
                            children: [
                              SizedBox(
                                width: 88,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: imageItem() ??
                                              (product.images!.length == 0
                                                  ? ""
                                                  : product
                                                      .images![0].imageUrl!),
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              product.productDiscount == null
                                  ? Container()
                                  : Positioned(
                                      top: -12,
                                      left: 2,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            child: SvgPicture.asset(
                                              "packages/sahashop_customer/assets/icons/ribbon.svg",
                                              color: Color(0xfffdd100),
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 5,
                                            child: Text(
                                              "-${SahaStringUtils().convertToMoney(product.productDiscount!.value)} %",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xfffd5800)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
                                          child: Text(
                                            product.name ?? "Không tên",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      if (lineItem.isBonus == true)
                                        SizedBox(
                                          width: 5,
                                        ),
                                      if (lineItem.isBonus == true)
                                        Text(
                                          "x $quantity",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if ((lineItem.distributesSelected == null ||
                                          lineItem.distributesSelected!
                                                  .length ==
                                              0) ==
                                      false)
                                    InkWell(
                                      onTap: () {
                                        if (lineItem.isBonus == false) {
                                          ModalBottomOptionBuyProduct
                                              .showModelOption(
                                                  product: lineItem.product!,
                                                  lineItemId: lineItem.id,
                                                  isOnlyAddToCart: true,
                                                  distributesSelectedParam:
                                                      lineItem
                                                          .distributesSelected,
                                                  quantity: lineItem.quantity,
                                                  onSubmit: (int quantity,
                                                      Product product,
                                                      List<DistributesSelected>
                                                          distributesSelected,
                                                      bool? buyNow) {
                                                    onUpdateProduct!(quantity,
                                                        distributesSelected);
                                                    Get.back();
                                                  });
                                        } else {
                                          if (lineItem.allowsChooseDistribute ==
                                              true) {
                                            ModalBottomOptionBuyProduct
                                                .showModelOption(
                                                    product: lineItem.product!,
                                                    isOnlyAddToCart: true,
                                                    lineItemId: lineItem.id,
                                                    distributesSelectedParam:
                                                        lineItem
                                                            .distributesSelected,
                                                    quantity: lineItem.quantity,
                                                    onSubmit: (int quantity,
                                                        Product product,
                                                        List<DistributesSelected>
                                                            distributesSelected,
                                                        bool? buyNow) {
                                                      onUpdateProduct!(quantity,
                                                          distributesSelected);
                                                      Get.back();
                                                    });
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        color: Colors.grey[200],
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ConstrainedBox(
                                              constraints: new BoxConstraints(
                                                minWidth: 10,
                                                maxWidth: Get.width * 0.5,
                                              ),
                                              child: Text(
                                                'Phân loại: ${lineItem.distributesSelected![0].value ?? ""} ${lineItem.distributesSelected![0].subElement ?? ""}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 12),
                                              ),
                                            ),
                                            if (lineItem.isBonus != true)
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: Colors.grey[600],
                                                size: 12,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: lineItem.isBonus == true
                                              ? 'Hàng tặng'
                                              : "đ${SahaStringUtils().convertToMoney(lineItem.itemPrice ?? 0)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        product.productDiscount == null
                                            ? ""
                                            : "đ${SahaStringUtils().convertToMoney(((100 * lineItem.itemPrice!) / (100 - product.productDiscount!.value!)))}",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (lineItem.isBonus != true)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: !canDecrease
                                              ? null
                                              : () {
                                                  onDecreaseItem!();
                                                },
                                          child: Container(
                                            height: 25,
                                            width: 30,
                                            child: Icon(
                                              Icons.remove,
                                              size: 13,
                                              color: canDecrease
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5)),
                                              border: Border.all(
                                                  color: Colors.grey[200]!),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            ModalBottomOptionBuyProduct
                                                .showModelOption(
                                                    product: lineItem.product!,
                                                    isOnlyAddToCart: true,
                                                    lineItemId: lineItem.id,
                                                    distributesSelectedParam:
                                                        lineItem
                                                            .distributesSelected,
                                                    quantity: lineItem.quantity,
                                                    onSubmit: (int quantity,
                                                        Product product,
                                                        List<DistributesSelected>
                                                            distributesSelected,
                                                        bool? buyNow) {
                                                      onUpdateProduct!(quantity,
                                                          distributesSelected);
                                                      Get.back();
                                                    });
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 40,
                                            child: Center(
                                              child: Text(
                                                '$quantity',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[200]!),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: !canIncrease
                                              ? null
                                              : () {
                                                  onIncreaseItem!();
                                                },
                                          child: Container(
                                            height: 25,
                                            width: 30,
                                            child: Icon(
                                              Icons.add,
                                              size: 13,
                                              color: canIncrease
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5)),
                                              border: Border.all(
                                                  color: Colors.grey[200]!),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            SahaDialogApp.showDialogInput(
                                                title: "Ghi chú",
                                                hintText: "Nhập ghi chú",
                                                textInput: note.text,
                                                onInput: (String? v) {
                                                  note.text = v ?? '';

                                                  onNote!(
                                                      lineItem.id, note.text);
                                                });
                                          },
                                          child: Icon(
                                            Icons.edit_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            onDismissed!();
                                          },
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (lineItem.isBonus == true) SizedBox(width: 10),
                          if (lineItem.isBonus == true)
                            Column(
                              children: [
                                SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/presents.svg",
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    "${lineItem.bonusProductName ?? ""}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  String? imageItem() {
    if (lineItem.product!.distributes != null &&
        lineItem.distributesSelected != null) {
      if (lineItem.product!.distributes!.isNotEmpty) {
        var indexImage = lineItem.product!.distributes![0].elementDistributes!
            .indexWhere(
                (e) => e.name == lineItem.distributesSelected![0].value);
        if (indexImage != -1) {
          String imageUrlCurrent = lineItem.product!.distributes![0]
                  .elementDistributes![indexImage].imageUrl ??
              (lineItem.product!.images!.length == 0
                  ? ""
                  : lineItem.product!.images![0].imageUrl!);
          return imageUrlCurrent;
        }
      }
      return null;
    } else {
      return null;
    }
  }
}
