import 'package:sahashop_customer/app_customer/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreInfo {
  static final StoreInfo _singleton = StoreInfo._internal();

  String? _customerStoreCode;
  String? name = "";
  bool? _isRelease;

  factory StoreInfo() {
    return _singleton;
  }

  StoreInfo._internal();

  Future<void> setCustomerStoreCode(String? code) async {
    this._customerStoreCode = code;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (code == null) {
        await prefs.remove(CUSTOMER_STORE_CODE);
      } else {
        await prefs.setString(CUSTOMER_STORE_CODE, code);
      }
    } catch (err) {
      print(err.toString());
    }
  }

  String? getCustomerStoreCode() {
    return _customerStoreCode;
  }

  Future<void> setRelease(bool? isRelease) async {
    this._isRelease = isRelease;
  }

  bool? getIsRelease() {
    return _isRelease;
  }
}
