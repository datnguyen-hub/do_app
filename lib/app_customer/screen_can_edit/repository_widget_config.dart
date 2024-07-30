import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/data/example/home_button.dart';
import 'package:sahashop_customer/app_customer/data/example/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/banner/banner_style_6/banner_type_6.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home/home_style_6/home_style_6.dart';
import 'banner/banner_style_2/banner_type_2.dart';
import 'banner/banner_style_4/banner_type_4.dart';
import 'banner/banner_style_3/banner_type_3.dart';
import 'banner/banner_style_1/banner_type_1.dart';
import 'banner/banner_style_5/banner_type_5.dart';
import 'category_product_screen/category_product_style_2/category_product_screen_2.dart';
import 'category_product_screen/category_product_style_3/category_product_screen_3.dart';
import 'category_product_screen/category_product_style_4/category_product_screen_4.dart';
import 'home/home_style_1/home_style_1.dart';
import 'home/home_style_2/home_style_2.dart';
import 'home/home_style_3/home_style_3.dart';
import 'home/home_style_4/home_style_4.dart';
import 'home/home_style_5/home_style_5.dart';
import 'home/home_style_7/home_style_7.dart';
import 'home_buttons/home_buttons_style_1/home_button_style_1.dart';
import 'home_buttons/home_buttons_style_2/home_button_style_2.dart';
import 'home_buttons/home_buttons_style_3/home_button_style_3.dart';
import 'home_buttons/home_buttons_style_4/home_button_style_4.dart';
import 'home_buttons/home_buttons_style_5/home_button_style_5.dart';
import 'product_item_widget/product_item_style_1/product_item_widget_style_1.dart';
import 'product_item_widget/product_item_style_2/product_item_widget_style_2.dart';
import 'product_item_widget/product_item_style_3/product_item_widget_style_3.dart';
import 'product_item_widget/product_item_style_4/product_item_widget_style_4.dart';
import 'product_item_widget/product_item_style_5/product_item_widget_style_5.dart';
import 'product_item_widget/product_item_style_6/product_item_widget_style_6.dart';
import 'product_screen/product_style_1/product_screen_1.dart';
import 'product_screen/product_style_2/product_screen_2.dart';
import 'product_screen/product_style_3/product_screen_3.dart';
import 'product_screen/product_style_4/product_screen_4.dart';
import 'product_screen/product_style_5/product_screen_5.dart';
import 'product_screen/product_style_6/product_screen_6.dart';

class RepositoryWidgetCustomer {
  List<Widget> LIST_HOME_SCREEN = [
    HomeScreenStyle7(),
    HomeScreenStyle1(),
    HomeScreenStyle3(),
    HomeScreenStyle2(),
    HomeScreenStyle4(),
    HomeScreenStyle5(),
    HomeScreenStyle6(),
  ];

  List<Widget> LIST_CATEGORY_PRODUCT_SCREEN = [
    CategoryProductStyle4(),
    CategoryProductStyle3(),
    CategoryProductStyle2(),
   
   
    
  ];

  List<Widget> LIST_PRODUCT_SCREEN = [
    ProductScreen6(),
    ProductScreen1(),
    ProductScreen2(),
    ProductScreen3(),
    ProductScreen4(),
    ProductScreen5(),
  ];

  List<Widget> LIST_BUTTON_WIDGET = [
    HomeButtonStyle1Widget(
      homeButton: LIST_HOME_BUTTON_EXAMPLE[0],
    ),
    HomeButtonStyle2Widget(
      homeButton: LIST_HOME_BUTTON_EXAMPLE[0],
    ),
    HomeButtonStyle3Widget(
      homeButton: LIST_HOME_BUTTON_EXAMPLE[0],
    ),
    HomeButtonStyle4Widget(
      homeButton: LIST_HOME_BUTTON_EXAMPLE[0],
    ),
    HomeButtonStyle5Widget(
      homeButton: LIST_HOME_BUTTON_EXAMPLE[0],
    ),
  ];

  List<Widget> LIST_ITEM_PRODUCT_WIDGET = [
    ProductItemWidgetStyle6(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle1(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle2(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle3(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle4(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle5(product: EXAMPLE_LIST_PRODUCT[0]),
  ];

  List<Widget> LIST_WIDGET_BANNER = [
    BannerType1(height: 210),
    BannerType2(height: 210),
    BannerType3(height: 210),
    BannerType4(height: 210),
    BannerType5(height: 210),
    BannerType6(height: 210),
  ];
}
