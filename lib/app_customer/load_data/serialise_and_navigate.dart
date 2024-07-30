import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/const/const_type_message.dart';
import 'package:sahashop_customer/app_customer/screen_default/chat_customer_screen/chat_user_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/order_history/order_history_screen.dart';

import '../utils/action_tap.dart';

class SerialiseAndNavigate {
  RemoteMessage message;

  SerialiseAndNavigate({required this.message});

  void navigate() {
    var typeMessage = message.data['type'];
    var typeMessageClick = message.data['type_action'];
    var value = message.data['value_action'];
    if (typeMessage != null) {
      if (typeMessage == NEW_MESSAGE) {
        Get.to(() => ChatCustomerScreen());
      } else if (typeMessage == NEW_ORDER) {
        Get.to(() => OrderHistoryScreen());
      }
    }

    /// click

    if (typeMessageClick != null && typeMessageClick != "") {
      ActionTap.onTap(typeAction: typeMessageClick, value: value);
    }
  }
}
