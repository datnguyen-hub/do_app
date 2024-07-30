import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../../components/text/text_money.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/string_utils.dart';

class PriceProduct extends StatelessWidget {
  Product product;
  DataAppCustomerController dataAppCustomerController;

  PriceProduct(
      {required this.product, required this.dataAppCustomerController});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                product.minPrice != product.maxPrice
                    ? Row(
                        children: [
                          SahaMoneyText(
                            price: checkMinMaxPrice(product.minPrice),
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
                            price: checkMinMaxPrice(product.maxPrice),
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (product.productDiscount != null)
                            Row(
                              children: [
                                Text(
                                  "${SahaStringUtils().convertToMoney(product.minPrice ?? 0)}₫",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
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
                                  "₫${SahaStringUtils().convertToMoney(product.maxPrice ?? 0)}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "-${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground()),
                                ),
                              ],
                            ),
                        ],
                      )
                    : product.minPrice == 0
                        ? Text(
                            "Giá: Liên hệ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                          .primaryColor
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Theme.of(context).primaryColor,
                            ),
                          )
                        : product.productDiscount != null
                            ? Row(
                                children: [
                                  SahaMoneyText(
                                    price: product
                                            .productDiscount?.discountPrice ??
                                        0,
                                    sizeText: 20,
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground(),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(product.maxPrice ?? 0)}₫",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "-${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: SahaColorUtils()
                                            .colorPrimaryTextWithWhiteBackground()),
                                  ),
                                ],
                              )
                            : SahaMoneyText(
                                price: product.maxPrice ?? 0,
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
              ],
            ),
          ],
        ),
      ),
      if (dataAppCustomerController.badge.value.statusCollaborator == 1)
        Padding(
          padding:
              const EdgeInsets.only(left: 5.0, top: 8, right: 8, bottom: 0),
          child: Row(
            children: [
              moneyRose(),
              Text(
                " (Hoa hồng)",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      if (dataAppCustomerController.badge.value.statusAgency == 1)
        Padding(
          padding:
              const EdgeInsets.only(left: 5.0, top: 8, right: 8, bottom: 0),
          child: Row(
            children: [
              product.minPriceBeforeOverride != product.maxPriceBeforeOverride
                  ? Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.minPriceBeforeOverride) ?? 0))}",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          maxLines: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.maxPriceBeforeOverride) ?? 0)}",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPriceBeforeOverride ?? 0)!)}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
              Text(
                " (Giá bán lẻ)",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      if (dataAppCustomerController.badge.value.statusAgency == 1 &&
          (product.percentAgency ?? 0) > 0)
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 0),
          child: Row(
            children: [
              product.minPriceBeforeOverride != product.maxPriceBeforeOverride
                  ? Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 5.0),
                          child: Text(
                            "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.minPriceBeforeOverride)!) * (product.percentAgency! / 100))}",
                            style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          maxLines: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 5.0),
                          child: Text(
                            "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.maxPriceBeforeOverride)!) * (product.percentAgency! / 100))}",
                            style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 0, right: 5.0),
                      child: Text(
                        "₫${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPriceBeforeOverride!)! * (product.percentAgency! / 100))}",
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
              Text(
                " (Hoa hồng giới thiệu)",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
    ]);
  }

  double? checkMinMaxPrice(double? price) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }

  //print(product.productDiscount!.value!);

  Widget moneyRose() {
    return product.typeShareCollaboratorNumber == 0
        ? product.minPrice != product.maxPrice
            ? Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.minPrice)!) * (product.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    maxLines: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.maxPrice)!) * (product.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  "đ ${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPrice)! * (product.percentCollaborator! / 100))}",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  maxLines: 1,
                ),
              )
        : Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(
              "₫${SahaStringUtils().convertToMoney(product.moneyAmountCollaborator ?? 0)}",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              maxLines: 1,
            ),
          );
  }

  Widget moneyRose1() {
    return product.typeShareCollaboratorNumber == 0
        ? product.minPrice != product.maxPrice
            ? Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.maxPrice)!) * (product.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    maxLines: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "₫${SahaStringUtils().convertToMoney((checkMinMaxPrice(product.maxPrice)!) * (product.percentCollaborator! / 100))}",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  "${SahaStringUtils().convertToMoney(checkMinMaxPrice(product.minPrice ?? 0))}",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  maxLines: 1,
                ),
              )
        : Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(
              "₫${SahaStringUtils().convertToMoney(product.moneyAmountCollaborator ?? 0)}",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              maxLines: 1,
            ),
          );
  }
}
