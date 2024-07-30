import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/device_token/device_token_customer_response.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

class DeviceTokenRepository {
  Future<DeviceTokenCustomer?> updateDeviceTokenCustomer(String? deviceToken) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    try {
      var res = await CustomerServiceManager().service!.updateDeviceTokenCustomer(
          StoreInfo().getCustomerStoreCode(),
          {
        "device_token": deviceToken,
        "device_id": deviceId,
        "device_type": Platform.isAndroid ? 0 : 1,
      });

      return res.data;
    } catch (err) {
      print("Loi update token ${err}");
     // handleErrorCustomer(err);
    }
    return null;
  }
}
