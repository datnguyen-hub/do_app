
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }

      var a = int.tryParse(hexColor, radix: 16)!;

      var color = Color(a);

      if (color.opacity < 1) {
        return Theme.of(Get.context!).primaryColor.value;
      }

      return Color(a).value;
    } catch (err) {
      return  Theme.of(Get.context!).primaryColor.value;
    }
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}

extension ToHexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
