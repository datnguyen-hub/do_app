import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/input_model_products.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/category_post_screen/category_post_screen_1.dart';
import 'package:sahashop_customer/app_customer/screen_default/category_post_screen/read_post_screen/input_model_post.dart';
import 'package:sahashop_customer/app_customer/screen_default/category_post_screen/read_post_screen/read_post_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/chat_customer_screen/chat_user_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/choose_combo/choose_combo_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/member/member_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/call/call.dart';
import '../components/toast/saha_alert.dart';
import '../screen_default/bonus_product/bonus_product_screen.dart';
import '../screen_default/guess_number_game/guess_number_screen.dart';
import '../screen_default/spin_wheel/mini_game_screen.dart';

enum TYPE_ACTION {
  QR,
  SCORE,
  CALL,
  MESSAGE_TO_SHOP,
  VOUCHER,
  PRODUCT_BY_CATEGORY,
  PRODUCTS_TOP_SALES,
  PRODUCTS_DISCOUNT,
  COMBO,
  BONUS_PRODUCT,
  PRODUCTS_NEW,
  //////
  LINK,
  PRODUCT,
  CATEGORY_PRODUCT,
  CATEGORY_POST,
  POST,
  SPIN_WHEEL,
  GUESS_NUMBER
}

final Map mapTypeAction = {
  TYPE_ACTION.QR: "QR",
  TYPE_ACTION.SCORE: "SCORE",
  TYPE_ACTION.CALL: "CALL",
  TYPE_ACTION.MESSAGE_TO_SHOP: "MESSAGE_TO_SHOP",
  TYPE_ACTION.VOUCHER: "VOUCHER",
  TYPE_ACTION.PRODUCTS_TOP_SALES: "PRODUCTS_TOP_SALES",
  TYPE_ACTION.PRODUCT_BY_CATEGORY: "PRODUCT_BY_CATEGORY",
  TYPE_ACTION.PRODUCTS_DISCOUNT: "PRODUCTS_DISCOUNT",
  TYPE_ACTION.PRODUCTS_NEW: "PRODUCTS_NEW",
  TYPE_ACTION.COMBO: "COMBO",
  TYPE_ACTION.BONUS_PRODUCT: "BONUS_PRODUCT",
  ////
  TYPE_ACTION.LINK: "LINK",
  TYPE_ACTION.PRODUCT: "PRODUCT",
  TYPE_ACTION.CATEGORY_PRODUCT: "CATEGORY_PRODUCT",
  TYPE_ACTION.CATEGORY_POST: "CATEGORY_POST",
  TYPE_ACTION.POST: "POST",
  TYPE_ACTION.SPIN_WHEEL: "SPIN_WHEEL",
  TYPE_ACTION.GUESS_NUMBER: "GUESS_NUMBER",
};

var checkTypeDefault = [
  TYPE_ACTION.QR,
  TYPE_ACTION.SCORE,
  TYPE_ACTION.CALL,
  TYPE_ACTION.MESSAGE_TO_SHOP,
  TYPE_ACTION.VOUCHER,
  TYPE_ACTION.PRODUCTS_TOP_SALES,
  TYPE_ACTION.PRODUCTS_DISCOUNT,
  TYPE_ACTION.COMBO,
  TYPE_ACTION.BONUS_PRODUCT,
  TYPE_ACTION.PRODUCTS_NEW,
];

class ActionTap {
  static void onTap(
      {String? typeAction, String? value, Function? thenAction}) async {
    if (typeAction == mapTypeAction[TYPE_ACTION.QR]) {
      Future<void> scanProduct(String barcode) async {
        try {
          var data = await CustomerRepositoryManager.productCustomerRepository
              .scanProduct(barcode);
          var product = data!.data!.product;
          if (product != null) {
            Get.to(() => ProductScreen(
                  product: product,
                ));
          } else {
            SahaAlert.showError(message: "Không tìm thấy sản phẩm");
          }
        } catch (err) {
          SahaAlert.showError(message: err.toString());
        }
      }

      String barcodeScanRes;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        print(barcodeScanRes);
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      scanProduct(barcodeScanRes);
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.SPIN_WHEEL]) {
      Get.to(() => MiniGameScreen(
            gameId: int.parse(value!),
          ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.GUESS_NUMBER]) {
      Get.to(() => GuessGameScreen(
            gameId: int.parse(value!),
          ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
      Call.call('$value');
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.SCORE]) {
      Get.to(() => MemberScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]) {
      Get.to(() => ChatCustomerScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_TOP_SALES]) {
      Get.to(() => CategoryProductScreen(
            filterProducts: FILTER_PRODUCTS.TOP_SALE,
            categoryId: -1,
          ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCT_BY_CATEGORY]) {
      Get.to(() => CategoryProductScreen(
            categoryId: int.tryParse(value ?? "") ?? -1,
          ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_DISCOUNT]) {
      Get.to(CategoryProductScreen(
        filterProducts: FILTER_PRODUCTS.DISCOUNT,
        categoryId: -1,
      ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_NEW]) {
      Get.to(CategoryProductScreen(
        filterProducts: FILTER_PRODUCTS.NEW,
        categoryId: -1,
      ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.VOUCHER]) {
      Get.to(() => ChooseVoucherCustomerScreen(
            isWatch: true,
          ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.COMBO]) {
      Get.to(() => ChooseComboScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.LINK]) {
      launchUrl(
          Uri.parse(
            value ?? "",
          ),
          mode: LaunchMode.externalApplication);
      // Navigator.push(
      //   Get.context!,
      //   MaterialPageRoute(
      //       builder: (context) => WebViewScreen(
      //             link: value,
      //           )),
      // ).then((value) {
      //   if (thenAction != null) {
      //     thenAction();
      //   }
      // });
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCT]) {
      Navigator.push(
        Get.context!,
        MaterialPageRoute(
            builder: (context) => ProductScreen(
                  productId: int.tryParse(value!) ?? -1,
                )),
      ).then((value) {
        if (thenAction != null) {
          thenAction();
        }
      });
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT]) {
      Navigator.push(
        Get.context!,
        MaterialPageRoute(
            builder: (context) => CategoryProductScreen(
                  categoryId: int.tryParse(value ?? "") ?? -1,
                )),
      ).then((value) {
        if (thenAction != null) {
          thenAction();
        }
      });
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.POST]) {
      Navigator.push(
        Get.context!,
        MaterialPageRoute(
            builder: (context) => ReadPostScreen(
                  inputModelPost: InputModelPost(
                    postId: int.tryParse(value!) ?? -1,
                  ),
                )),
      ).then((value) {
        if (thenAction != null) {
          thenAction();
        }
      });
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_POST]) {
      Navigator.push(
        Get.context!,
        MaterialPageRoute(
            builder: (context) => CategoryPostScreen(
                  isAutoBackIcon: true,
                  categoryId: int.tryParse(value ?? "") ?? -1,
                )),
      ).then((value) {
        if (thenAction != null) {
          thenAction();
        }
      });
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.BONUS_PRODUCT]) {
      Navigator.push(
        Get.context!,
        MaterialPageRoute(builder: (context) => BonusProductScreen()),
      ).then((value) {
        if (thenAction != null) {
          thenAction();
        }
      });
    }
  }
}
