import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'package:sahashop_customer/app_customer/utils/action_tap.dart';


List<HomeButton> LIST_HOME_BUTTON_EXAMPLE = [
  HomeButton(
    title: "Chat với cửa hàng",
    typeAction: mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]
  ),
  HomeButton(
      title: "Sản phẩm",
      typeAction: mapTypeAction[TYPE_ACTION.PRODUCT],
    imageUrl: "https://i.imgur.com/hESDRss.jpeg"
  ),
];
