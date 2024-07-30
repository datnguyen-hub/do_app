import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sahashop_customer/app_customer/load_data/serialise_and_navigate.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';

import 'notification/alert_notification.dart';

class LoadFirebase {
  static void initFirebase() async {
    FCMMess().handleFirebaseMess();
  }
}

class FCMMess {
  static final FCMMess _singleton = FCMMess._internal();
  FCMMess._internal();

  factory FCMMess() {
    return _singleton;
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void removeID() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    var map = message.data;

    print(map);

    if (map.containsKey('data')) {
      final dynamic data = map['data'];
    }

    if (map.containsKey('notification')) {
      final dynamic notification = map['notification'];
    }
  }

  void handleFirebaseMess() async {

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      SerialiseAndNavigate(message: message).navigate();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
      SahaNotificationAlert.alertNotification(message);
    });

    await _firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      print("Push Messaging token: $token");
      FCMToken().setToken(token);
        if(CustomerInfo().getToken() != null) {
          CustomerRepositoryManager.deviceTokenRepository
              .updateDeviceTokenCustomer(
              token);
        }
    });
  }
}

class FCMToken {
  static final FCMToken _singleton = new FCMToken._internal();

  String? _token;

  String? get token => _token;

  factory FCMToken() {
    return _singleton;
  }

  FCMToken._internal();

  void setToken(String? code) {
    _token = code;
  }

  String? getToken() {
    return _token;
  }
}
