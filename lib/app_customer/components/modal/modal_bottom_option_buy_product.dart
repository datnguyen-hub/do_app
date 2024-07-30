import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/chip/ticker.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/text/text_money.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../screen_default/confirm_screen/confirm_screen.dart';

class ModalBottomOptionBuyProduct {
  static Future<void> showModelOption(
      {int? lineItemId,
      required Product product,
      required bool isOnlyAddToCart,
      String? textButton,
      List<DistributesSelected>? distributesSelectedParam,
      int? quantity,
      Function(int quantity, Product product,
              List<DistributesSelected> distributesSelected, bool? buyNow)?
          onSubmit}) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return OptionBuyProduct(
          lineItemId: lineItemId,
          textButton: textButton,
          product: product,
          onSubmit: onSubmit,
          isOnlyAddToCart: isOnlyAddToCart,
          distributesSelectedParam: distributesSelectedParam,
          quantity: quantity,
        );
      },
    );
  }
}

class OptionBuyProduct extends StatefulWidget {
  Product product;
  int? lineItemId;
  String? textButton;
  bool isOnlyAddToCart;
  List<DistributesSelected>? distributesSelectedParam;
  int? quantity;
  Function(int quantity, Product product,
      List<DistributesSelected> distributesSelected, bool? buyNow)? onSubmit;

  OptionBuyProduct(
      {Key? key,
      required this.product,
      this.onSubmit,
      required this.isOnlyAddToCart,
      this.distributesSelectedParam,
      this.quantity,
      this.lineItemId,
      this.textButton})
      : super(key: key);

  @override
  _OptionBuyProductState createState() => _OptionBuyProductState();
}

class _OptionBuyProductState extends State<OptionBuyProduct> {
  int quantity = 1;
  String errorTextInBottomModel = "";

  List<DistributesSelected> distributesSelected = [];
  bool isLoading = false;

  bool canDecrease = true;
  bool canIncrease = true;

  var quantityInStock;
  int? max = -1;

  DataAppCustomerController dataAppCustomerController = Get.find();

  Future<void> getOneProduct(int idProduct) async {
    try {
      isLoading = true;
      var data = await CustomerRepositoryManager.productCustomerRepository
          .getDetailProduct(idProduct);
      widget.product = data!.data!;
      max = widget.product.mainStock == null || widget.product.mainStock! < 0
          ? -1
          : widget.product.mainStock;

      if (widget.distributesSelectedParam != null) {
        distributesSelected = widget.distributesSelectedParam!;
        checkItemPriceCurrent();
      }
      if (widget.quantity != null) {
        quantity = widget.quantity!;
      }
      textEditingController.text = "$quantity";

      quantityInStock = (widget.product.quantityInStockWithDistribute ?? 0) > 0
          ? widget.product.quantityInStockWithDistribute ?? 0
          : widget.product.quantityInStock == null ||
                  widget.product.quantityInStock! < 0
              ? -1
              : widget.product.quantityInStock;
      checkCanCrease();
      isLoading = false;
      setState(() {});
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getOneProduct(widget.product.id!);
  }

  String? nameDistribute;
  String? valueDistribute;
  String? subElementDistribute;
  double? priceMin;
  double? priceMax;
  double? priceCurrent;
  double? priceCurrentAgency;
  String? imageUrlCurrent;
  int? quantityStockCurrent;
  double? retailPrice;

  void onCheckElementDistribute() {
    quantity = 1;
    textEditingController.text = "$quantity";
    distributesSelected = [
      DistributesSelected(
          name: nameDistribute,
          value: valueDistribute,
          subElement: subElementDistribute)
    ];
    setState(() {
      print(distributesSelected[0].toJson());
    });
  }

  bool isChecked(String nameDistribute, String nameElement) {
    if (distributesSelected.map((e) => e.name).contains(nameDistribute) &&
        distributesSelected.map((e) => e.value).contains(nameElement)) {
      return true;
    } else {
      return false;
    }
  }

  bool isCheckedSub(String nameSubElement) {
    if (distributesSelected.map((e) => e.subElement).contains(nameSubElement)) {
      return true;
    } else {
      return false;
    }
  }

  void onSubmitBuy({bool buyNow = false}) {
    if (dataAppCustomerController.badge.value.allowSemiNegative != true) {
      if (widget.product.checkInventory == true) {
        if (max == 0) {
          errorTextInBottomModel = "Hết hàng";
          setState(() {});
          return;
        }
      }
    }

    if (widget.product.distributes!.isNotEmpty) {
      if (distributesSelected.isNotEmpty) {
        if (widget.product.distributes![0].subElementDistributeName != null &&
            widget.product.distributes![0].subElementDistributeName != "") {
          if (distributesSelected[0].subElement != null &&
              distributesSelected[0].name != null &&
              distributesSelected[0].value != null) {
            widget.onSubmit!(
                quantity, widget.product, distributesSelected, buyNow);
          } else {
            if (distributesSelected[0].name != null &&
                distributesSelected[0].value != null) {
              errorTextInBottomModel =
                  "Mời chọn ${widget.product.distributes![0].subElementDistributeName} ";
            } else {
              errorTextInBottomModel =
                  "Mời chọn ${widget.product.distributes![0].name} ";
            }
            setState(() {});
          }
        } else {
          if (distributesSelected[0].name != null &&
              distributesSelected[0].value != null) {
            widget.onSubmit!(
                quantity, widget.product, distributesSelected, buyNow);
          } else {
            errorTextInBottomModel =
                "Mời chọn ${widget.product.distributes![0].name} ";
            setState(() {});
          }
        }
      } else {
        errorTextInBottomModel =
            "Mời chọn ${widget.product.distributes![0].name} ";
        setState(() {});
        return;
      }
    } else {
      widget.onSubmit!(quantity, widget.product, distributesSelected, buyNow);
    }
  }

  bool isDoneCheckElement() {
    if (widget.product.quantityInStockWithDistribute != null &&
        widget.product.quantityInStockWithDistribute! != 0) {
      max = widget.product.quantityInStockWithDistribute == null ||
              widget.product.quantityInStockWithDistribute! < 0
          ? -1
          : widget.product.quantityInStockWithDistribute;
    } else {
      max = widget.product.mainStock == null || widget.product.mainStock! < 0
          ? -1
          : widget.product.mainStock;
    }

    if (widget.product.checkInventory == true) {
      if (max == 0) {
        errorTextInBottomModel = "Hết hàng";
        return false;
      }
    }

    if (widget.product.distributes!.isNotEmpty) {
      if (distributesSelected.isNotEmpty) {
        if (widget.product.distributes![0].subElementDistributeName != null &&
            widget.product.distributes![0].subElementDistributeName != "") {
          if (distributesSelected[0].subElement != null &&
              distributesSelected[0].name != null &&
              distributesSelected[0].value != null) {
            return true;
          } else {
            return false;
          }
        } else {
          if (distributesSelected[0].name != null &&
              distributesSelected[0].value != null) {
            return true;
          } else {
            return false;
          }
        }
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  void checkCanCrease() {
    setState(() {
      var quantityInStockCheck = quantityStockCurrent ?? quantityInStock;
      if (quantityInStockCheck == "Vô hạn") {}
      max = quantityInStockCheck == null || quantityInStockCheck! < 0
          ? -1
          : quantityInStockCheck;

      if (widget.product.checkInventory == true) {
        if (max == 0) {
          errorTextInBottomModel = "Hết hàng";
        }
      }

      if (quantity == 1)
        canDecrease = false;
      else
        canDecrease = true;

      if (quantity + 1 > max! && max != -1)
        canIncrease = false;
      else
        canIncrease = true;
    });
  }

  void checkItemPriceCurrentAgency() {
    errorTextInBottomModel = "";
    var priceMain = priceCurrentAgency ??
        (widget.product.productDiscount == null
            ? widget.product.price
            : widget.product.productDiscount!.discountPrice);

    if (widget.product.distributes!.isNotEmpty) {
      var distribute = widget.product.distributes![0];
      var select = distributesSelected[0];
      if (select.subElement != null && select.subElement!.isNotEmpty) {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          var indexSub = distribute
              .elementDistributes![indexElement].subElementDistribute!
              .indexWhere((e) => e.name == select.subElement);
          if (indexSub != -1) {
            priceCurrent = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].price;

            if (widget.product.productDiscount != null) {
              if (priceCurrent != null) {
                priceCurrent = priceCurrent! -
                    ((priceCurrent! * widget.product.productDiscount!.value!) /
                        100);
              } else {
                priceCurrent = null;
              }
            }
          } else {
            priceCurrent = priceMain;
          }
        } else {
          priceCurrent = priceMain;
        }
      } else {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          priceCurrent = distribute.elementDistributes![indexElement].price;
          if (widget.product.productDiscount != null) {
            if (priceCurrent != null) {
              priceCurrent = priceCurrent! -
                  ((priceCurrent! * widget.product.productDiscount!.value!) /
                      100);
            } else {
              priceCurrent = null;
            }
          }
        } else {
          priceCurrent = priceMain;
        }
      }
    }
  }

  void checkItemPriceCurrent() {
    
    errorTextInBottomModel = "";
    var priceMain = priceCurrent ??
        (widget.product.productDiscount == null
            ? widget.product.price
            : widget.product.productDiscount!.discountPrice);

    if (widget.product.distributes!.isNotEmpty) {
      var distribute = widget.product.distributes![0];
      var select = distributesSelected[0];
      if (select.subElement != null) {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
     
          var indexSub = distribute
              .elementDistributes![indexElement].subElementDistribute!
              .indexWhere((e) => e.name == select.subElement);
          if (indexSub != -1) {
                
            priceCurrent = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].price;
            quantityStockCurrent = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].quantityInStock;
            retailPrice = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].priceBeforeOverride;
             if(widget.product.isProductRetailStep == true && dataAppCustomerController.badge.value.statusAgency != 1 && dataAppCustomerController.badge.value.statusCollaborator != 1){
                  priceCurrent = (widget.product.productRetailSteps ?? []).firstWhere((e) => (e.fromQuantity ?? 0) <= quantity && quantity <=  (e.toQuantity ?? 0) ,orElse: () => ProductRetailStep(price:  quantity > ((widget.product.productRetailSteps ?? []).last.toQuantity ?? 0) ? (widget.product.productRetailSteps ?? []).last.price : priceCurrent),).price;
                }
            if (widget.product.productDiscount != null) {
              if (priceCurrent != null) {
               
                priceCurrent = priceCurrent! -
                    ((priceCurrent! * widget.product.productDiscount!.value!) /
                        100);
                retailPrice = retailPrice! -
                    ((retailPrice! * widget.product.productDiscount!.value!) /
                        100);
              } else {
                priceCurrent = null;
                retailPrice = null;
              }
            }
          } else {
            quantityStockCurrent = quantityInStock;
           
            priceCurrent = priceMain;
          }
        } else {
          quantityStockCurrent = quantityInStock;
          priceCurrent = priceMain;
        }
      } else {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          quantityStockCurrent =
              distribute.elementDistributes![indexElement].quantityInStock;
          priceCurrent = distribute.elementDistributes![indexElement].price;
          retailPrice =
              distribute.elementDistributes![indexElement].priceBeforeOverride;
          if (widget.product.productDiscount != null) {
            if (priceCurrent != null) {
          
              priceCurrent = priceCurrent! -
                  ((priceCurrent! * widget.product.productDiscount!.value!) /
                      100);
              retailPrice = retailPrice! -
                  ((retailPrice! * widget.product.productDiscount!.value!) /
                      100);
            } else {
              priceCurrent = null;
              retailPrice = null;
            }
          }
        } else {
          priceCurrent = priceMain;
          quantityStockCurrent = quantityInStock;
        }
      }
      var indexImage = distribute.elementDistributes!
          .indexWhere((e) => e.name == select.value);
      if (indexImage != -1) {
        imageUrlCurrent = distribute.elementDistributes![indexImage].imageUrl ??
            (widget.product.images!.length == 0
                ? ""
                : widget.product.images![0].imageUrl!);
      }

      checkCanCrease();
    }
  }

  double? checkMinMaxPrice(double? price) {
    if(widget.product.isProductRetailStep == true && dataAppCustomerController.badge.value.statusAgency != 1 && dataAppCustomerController.badge.value.statusCollaborator != 1){
      price = (widget.product.productRetailSteps ?? []).firstWhere((e) => ((e.fromQuantity ?? 0) <= quantity && quantity <=  (e.toQuantity ?? 0)),orElse: () => ProductRetailStep(price: quantity > ((widget.product.productRetailSteps ?? []).last.toQuantity ?? 0) ? (widget.product.productRetailSteps ?? []).last.price : price),).price;
    
    }
   var priceProduct =  widget.product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (widget.product.productDiscount!.value! / 100)));
    
    return priceProduct;
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 110,
                      height: 110,
                      child: CachedNetworkImage(
                          imageUrl: imageUrlCurrent ??
                              (widget.product.images!.length == 0
                                  ? ""
                                  : widget.product.images![0].imageUrl!),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage()),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      priceCurrent != null && isDoneCheckElement()
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SahaMoneyText(
                                  price: priceCurrent ?? 0,
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                ),
                                if (dataAppCustomerController
                                        .badge.value.statusAgency ==
                                    1)
                                  Text(
                                    "Giá bán lẻ: ${SahaStringUtils().convertToMoney(retailPrice ?? 0)}đ",
                                  )
                              ],
                            )
                          : Row(
                              children: [
                                widget.product.minPrice !=
                                        widget.product.maxPrice
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (widget.product.productDiscount !=
                                              null)
                                            Row(
                                              children: [
                                                Text(
                                                  "₫${SahaStringUtils().convertToMoney(widget.product.minPrice ?? 0)}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  " - ",
                                                  style: TextStyle(
                                                    color: SahaColorUtils()
                                                        .colorPrimaryTextWithWhiteBackground(),
                                                  ),
                                                ),
                                                Text(
                                                  "₫${SahaStringUtils().convertToMoney(widget.product.maxPrice ?? 0)}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          Row(
                                            children: [
                                              SahaMoneyText(
                                                price: checkMinMaxPrice(
                                                    widget.product.minPrice),
                                                color: SahaColorUtils()
                                                    .colorPrimaryTextWithWhiteBackground(),
                                              ),
                                              Text(
                                                " - ",
                                                style: TextStyle(
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground(),
                                                ),
                                              ),
                                              SahaMoneyText(
                                                price: checkMinMaxPrice(
                                                    widget.product.maxPrice),
                                                color: SahaColorUtils()
                                                    .colorPrimaryTextWithWhiteBackground(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : widget.product.minPrice == 0
                                        ? Text(
                                            "Giá: Liên hệ",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                          .primaryColor
                                                          .computeLuminance() >
                                                      0.5
                                                  ? Colors.black
                                                  : Theme.of(context)
                                                      .primaryColor,
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (widget.product
                                                      .productDiscount !=
                                                  null)
                                                Text(
                                                  "₫${SahaStringUtils().convertToMoney(widget.product.price ?? 0)}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                ),
                                              SahaMoneyText(
                                                price: checkMinMaxPrice(
                                                    widget.product.minPrice),
                                                color: SahaColorUtils()
                                                    .colorPrimaryTextWithWhiteBackground(),
                                              ),
                                              if (dataAppCustomerController
                                                      .badge
                                                      .value
                                                      .statusAgency ==
                                                  1)
                                                Text(
                                                  "Giá bán lẻ: ₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(widget.product.minPriceBeforeOverride ?? 0))}",
                                                )
                                            ],
                                          ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      if (widget.product.productDiscount != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (priceCurrent != null && isDoneCheckElement())
                              Row(
                                children: [
                                  Text(
                                    "${SahaStringUtils().convertToMoney((priceCurrent! * 100) / (100 - widget.product.productDiscount!.value!))}đ",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            Text(
                              "-${SahaStringUtils().convertToMoney(widget.product.productDiscount!.value)}%",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      if (widget.product.checkInventory == true)
                        quantityStockCurrent != null && isDoneCheckElement()
                            ? Text(
                                "Kho: ${quantityStockCurrent == 0 ? "hết hàng" : quantityStockCurrent == -1 ? "vô hạn" : quantityStockCurrent ?? ""}")
                            : Text(
                                "Kho: ${quantityInStock == 0 ? "hết hàng" : quantityInStock == -1 ? "vô hạn" : quantityInStock ?? ""}"),
                    ],
                  )
                ],
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  }),
            ],
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 15,
          ),
          widget.product.distributes == null ||
                  widget.product.distributes!.length == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 35.0,
                        maxHeight: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Get.height * 0.5
                            : Get.height * 0.2,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Text(
                                        widget.product.distributes![0].name!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Wrap(
                                        children: widget.product.distributes![0]
                                            .elementDistributes!
                                            .map(
                                              (elementDistribute) =>
                                                  TickerStateLess(
                                                text: elementDistribute.name,
                                                ticked: isChecked(
                                                    widget.product
                                                        .distributes![0].name!,
                                                    elementDistribute.name!),
                                                onChange: (va) {
                                                  nameDistribute = widget
                                                      .product
                                                      .distributes![0]
                                                      .name!;
                                                  valueDistribute =
                                                      elementDistribute.name!;
                                                  onCheckElementDistribute();
                                                  checkItemPriceCurrent();
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (widget.product.distributes![0]
                                      .subElementDistributeName !=
                                  null)
                                Container(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        child: Text(
                                          widget.product.distributes![0]
                                              .subElementDistributeName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Wrap(
                                          children: widget
                                              .product
                                              .distributes![0]
                                              .elementDistributes![0]
                                              .subElementDistribute!
                                              .map(
                                                (e) => TickerStateLess(
                                                  text: e.name,
                                                  ticked: isCheckedSub(e.name!),
                                                  onChange: (va) {
                                                    subElementDistribute =
                                                        e.name!;
                                                    onCheckElementDistribute();
                                                    checkItemPriceCurrent();
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ]),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số lượng",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity == 1) return;
                          quantity--;
                          textEditingController.text = "$quantity";
                        });
                        errorTextInBottomModel = "";
                        checkCanCrease();
                        checkItemPriceCurrent();
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        child: Icon(
                          Icons.remove,
                          color: canDecrease ? Colors.black : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      child: Center(
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            if (dataAppCustomerController
                                    .badge.value.allowSemiNegative ==
                                true) {
                              quantity = int.parse(textEditingController.text);
                            } else {
                              if (widget.product.checkInventory == true) {
                                setState(() {
                                  var quantityInStockCheck =
                                      quantityStockCurrent ?? quantityInStock;
                                  if (quantityInStockCheck < 0) {
                                    quantity =
                                        int.parse(textEditingController.text);
                                  } else {
                                    if (v != "" && v != "0") {
                                      if (quantityInStockCheck != null &&
                                          quantityInStockCheck != 'Vô hạn') {
                                        if (int.parse(v) <
                                            quantityInStockCheck) {
                                          quantity = int.parse(
                                              textEditingController.text);
                                        } else {
                                          textEditingController.text =
                                              '$quantityInStockCheck';
                                          quantity = int.parse(
                                              textEditingController.text);
                                          FocusScope.of(context).unfocus();
                                        }
                                      } else {
                                        quantity = int.parse(
                                            textEditingController.text);
                                      }
                                    }
                                  }
                                  checkCanCrease();
                               
                                });
                              } else {
                                quantity =
                                    int.tryParse(textEditingController.text) ??
                                        1;
                              }
                            }
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!)),
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.product.checkInventory == true) {
                          setState(() {
                            if (canIncrease) {
                              quantity++;
                              textEditingController.text = "$quantity";
                            }
                          });
                          checkCanCrease();
                          checkItemPriceCurrent();
                        } else {
                          setState(() {
                            quantity++;
                            textEditingController.text = "$quantity";
                               checkItemPriceCurrent();
                          });
                        }
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        child: Icon(
                          Icons.add,
                          color: widget.product.checkInventory == false
                              ? Colors.black
                              : canIncrease
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          errorTextInBottomModel.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$errorTextInBottomModel",
                    style: TextStyle(fontSize: 12, color: Colors.redAccent),
                  ),
                )
              : Container(),
          Row(
            children: (widget.isOnlyAddToCart == true)
                ? [
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Thêm vào giỏ hàng",
                        textColor: isLoading == false && isDoneCheckElement()
                            ? Theme.of(context).primaryColor
                            : Colors.grey[600],
                        color: isLoading == false && isDoneCheckElement()
                            ? Colors.white
                            : Colors.grey[200],
                        onPressed: () {
                          if (isLoading == false) {
                            if (widget.product.checkInventory == true) {
                              if ((quantityStockCurrent ?? quantityInStock) !=
                                  0) {
                                onSubmitBuy(buyNow: false);
                              } else {
                                setState(() {
                                  errorTextInBottomModel = "Hết hàng";
                                });
                              }
                            } else {
                              onSubmitBuy(buyNow: false);
                            }
                          }
                        },
                      ),
                    ),
                  ]
                : [
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Thêm vào giỏ",
                        textColor: isLoading == false && isDoneCheckElement()
                            ? Theme.of(context).primaryColor
                            : Colors.grey[600],
                        color: isLoading == false && isDoneCheckElement()
                            ? Colors.white
                            : Colors.grey[200],
                        onPressed: () {
                          if (isLoading == false) {
                            if (widget.product.checkInventory == true) {
                              if ((quantityStockCurrent ?? quantityInStock) !=
                                  0) {
                                onSubmitBuy(buyNow: false);
                              } else {
                                setState(() {
                                  errorTextInBottomModel = "Hết hàng";
                                });
                              }
                            } else {
                              onSubmitBuy(buyNow: false);
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Mua ngay",
                        textColor: isLoading == false && isDoneCheckElement()
                            ? Colors.grey[200]
                            : Colors.grey[600],
                        color: isLoading == false && isDoneCheckElement()
                            ? Theme.of(context).primaryColor
                            : Colors.grey[200],
                        onPressed: () {
                          if (isLoading == false) {
                            if (widget.product.checkInventory == true) {
                              if ((quantityStockCurrent ?? quantityInStock) !=
                                  0) {
                                onSubmitBuy(buyNow: true);
                              } else {
                                setState(() {
                                  errorTextInBottomModel = "Hết hàng";
                                });
                              }
                            } else {
                              onSubmitBuy(buyNow: true);
                            }
                          }
                        },
                      ),
                    ),
                  ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
