import 'package:appsflyer_sdk/appsflyer_sdk.dart';


class AppFlyer {
  static final AppFlyer _singleton = AppFlyer._internal();

  AppsflyerSdk? _appsflyerSdk;
  bool? isUseAppFlyer;
  factory AppFlyer() {
    return _singleton;
  }

  AppFlyer._internal();

  Future<void> initAppFlyer({required String afDevKey,required String appId}) async {
    isUseAppFlyer = true;
    final AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: afDevKey,
        appId: appId,
        showDebug: true,
        timeToWaitForATTUserAuthorization: 15);
    _appsflyerSdk = AppsflyerSdk(options);
    _appsflyerSdk!.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: false,
        registerOnDeepLinkingCallback: true);
      
  }


  Future<void> logEvent(String eventName, Map? eventValues) async {
    
    try {
      var res = await _appsflyerSdk!.logEvent(eventName, eventValues);
      print("=============>${res}");
    } catch (e) {
      print("===============>>>>>>>${e.toString()}");
    }
  }

}
