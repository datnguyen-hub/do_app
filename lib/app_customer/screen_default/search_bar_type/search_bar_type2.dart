import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/icon_button/iconbtn_counter.dart';
import 'package:sahashop_customer/app_customer/components/search/seach_field.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_style_1/search_text_field_screen/search_text_field_screen.dart';

import '../data_app_controller.dart';


class SearchBarType2 extends StatelessWidget {

  final DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: SearchField(
                onClick: () {
                  Get.to(SearchTextFiledScreen(
                    onSubmit: (text, categoryId) {

                    },
                  ));
                },
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            IconBtnWithCounter(
              svgSrc: "packages/sahashop_customer/assets/icons/cart_icon.svg",
              press: () {},
            ),
            SizedBox(
              width: 10,
            ),
            IconBtnWithCounter(
              svgSrc: "packages/sahashop_customer/assets/icons/wallet.svg",
              numOfitem: 3,
              press: () {},
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
