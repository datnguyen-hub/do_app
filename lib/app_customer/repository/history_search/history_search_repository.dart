import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/search_history/all_search_history_response.dart';

import '../handle_error.dart';

class HistorySearchRepository {
  Future<bool?> addHistorySearch(
    String text,
  ) async {
    try {
      var deviceId;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      var res = await CustomerServiceManager()
          .service!
          .addHistorySearch(StoreInfo().getCustomerStoreCode(), {
        "text": text,
        "device_id": deviceId,
      });
      return true;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<List<HistorySearch>?> get10HistorySearch() async {
    try {
      var deviceId;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      var res = await CustomerServiceManager().service!.getAllHistorySearch(
            StoreInfo().getCustomerStoreCode(),
            deviceId,
          );
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<bool?> deleteHistorySearch() async {
    try {
      var deviceId;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      var res = await CustomerServiceManager()
          .service!
          .deleteAllHistorySearch(StoreInfo().getCustomerStoreCode(), deviceId);
      return true;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
