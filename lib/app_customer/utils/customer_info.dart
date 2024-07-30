import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/const/const_database_shared_preferences.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerInfo {
  static final CustomerInfo _singleton = CustomerInfo._internal();

  String? _token;
  int? _currentIdUser;

  String? phoneNumberIntroduce;
  int? collaboratorByCustomerId;
 
  factory CustomerInfo() {
    return _singleton;
  }

  CustomerInfo._internal();

  Future<void> setCurrentIdUser(int? idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idUser == null) {
      await prefs.remove(CURRENT_USER_ID);
    } else {
      await prefs.setInt(CURRENT_USER_ID, idUser);
    }
    this._currentIdUser = idUser;
  }



  Future<void> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(CUSTOMER_TOKEN);
    } else {
      await prefs.setString(CUSTOMER_TOKEN, token);
    }
    this._token = token;
  }

  Future<void> setCollaboratorByCustomerId(
      String? phoneNumberIntroduce, int? collaboratorByCustomerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (phoneNumberIntroduce == null) {
    } else {
      await prefs.setString("PHONE_NUMBER", phoneNumberIntroduce);
    }
    this.phoneNumberIntroduce = phoneNumberIntroduce;

    if (collaboratorByCustomerId == null) {
    } else {
      await prefs.setInt("COLLAB_ID", collaboratorByCustomerId);
    }
    this.collaboratorByCustomerId = collaboratorByCustomerId;
  }

  String? getToken() {
    return _token;
  }

  int? getCurrentIdUser() {
    return _currentIdUser;
  }

  int? getCollaboratorByCustomerId() {
    return collaboratorByCustomerId;
  }

  String? getPhoneNumberIntroduce() {
    return phoneNumberIntroduce;
  }

  Future<bool> hasLogged() async {
    await loadDataUserSaved();
    if (this._token != null)
      return true;
    else
      return false;
  }

  Future<bool> hasPhoneIntroduce() async {
    await loadDataUserSaved();
    if (this.phoneNumberIntroduce != null)
      return true;
    else
      return false;
  }

  Future<void> loadDataUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenLocal = prefs.getString(CUSTOMER_TOKEN) ?? null;
    var phoneNumberIntroduce = prefs.getString('PHONE_NUMBER') ?? null;
    var collaboratorByCustomerId = prefs.getInt('COLLAB_ID') ?? null;
    this._token = tokenLocal;
    this.phoneNumberIntroduce = phoneNumberIntroduce;
  }

  Future<void> logoutWhenSwitchStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CUSTOMER_TOKEN);
    //prefs.remove(CURRENT_STORE_CODE);
  }

  Future<void> logout({bool? isNotBackHome}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CUSTOMER_TOKEN);
    //prefs.remove(CURRENT_STORE_CODE);

    DataAppCustomerController dataAppCustomerController = Get.find();
    dataAppCustomerController.checkLogin();
    dataAppCustomerController.infoCustomer.value.isCollaborator = false;
    dataAppCustomerController.logout();

    if (isNotBackHome != true) {
      Get.offNamed('customer_home');
    }

    // SahaAlert.showSuccess(message: "Đã đăng xuất");
  }

  Future<void> loginExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CUSTOMER_TOKEN);
    DataAppCustomerController dataAppCustomerController = Get.find();
    dataAppCustomerController.isLogin.value = false;
    dataAppCustomerController.infoCustomer.value.isCollaborator = false;
    dataAppCustomerController.infoCustomer.value.name = null;
    dataAppCustomerController.logout();
  }
}
