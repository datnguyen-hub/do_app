import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  static final DeviceInfo _singleton = DeviceInfo._internal();

  factory DeviceInfo() {
    return _singleton;
  }

  DeviceInfo._internal();

  String? deviceId;

  Future<void> initDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
  }

 String? getDeviceId() {
    return deviceId;
 }



}