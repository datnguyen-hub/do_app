import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

// ignore: must_be_immutable
class SahaMoneyText extends StatelessWidget {
  double? price;
  double sizeVND;
  double sizeText;
  Color? color;
  FontWeight? fontWeight;

  SahaMoneyText(
      {this.price,
      this.sizeVND = 16,
      this.sizeText = 18,
      this.color,
      this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Text(
          "${SahaStringUtils().convertToMoney(price)}",
          style: TextStyle(
            fontSize: sizeText,
            fontWeight: fontWeight,
            color: color,
          ),
          maxLines: 2,
        ),
        Text(
          "₫",
          style: TextStyle(
              fontSize: sizeVND, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    );
  }
}
