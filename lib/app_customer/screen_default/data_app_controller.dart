import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/badge.dart' as b;
import 'package:sahashop_customer/app_customer/model/home_data.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/home/web_theme_res.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/input_model_products.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/input_model.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';

import '../config_controller.dart';
import '../model/calling.dart';
import '../utils/debounce.dart';
import 'cart_screen/cart_controller.dart';
import 'category_post_screen/input_model_posts.dart';

class DataAppCustomerController extends GetxController {
  InputModelProduct? inputModelProduct;
  InputModelProducts? inputModelProducts;
  InputModelPosts? inputModelPosts;
  var webTheme = WebTheme().obs;
  Post? postCurrent;
  var badge = b.BadgeModel().obs;
  var homeData = HomeData().obs;
  var popups = RxList<Popup>();
  var indexPopup = 0.obs;
  int? scoreToday;
  var isShowed = false;
  var isCheckIn = false;
  var isLogin = false.obs;
  var infoCustomer = InfoCustomer().obs;
  var listCalling = RxList<Calling>();
  var calling = Calling().obs;
  late Timer timer;

  CartController cartController = Get.put(CartController());
  final Connectivity connectivity = Connectivity();
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> sub;
  var isConnected = true;

  DataAppCustomerController() {
   
    checkConnected();
    checkLogin();
    initPackageInfo();
  }

  @override
  void onClose() {
    EasyDebounce.cancelAll();
    timer.cancel();
    sub.cancel();
    super.dispose();
  }

  void checkConnected() {
    print("da vao function nay roi");
    sub = connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      EasyDebounce.debounce('data_app', Duration(milliseconds: 1000), () async {
        if (result == ConnectivityResult.none) {
          print('No connected');
          if (isConnected == true) {
            showDialogErrorInternet();
          }
          isConnected = false;
        } else {
          print('connected');
          if (isConnected == false) {
            isConnected = true;
            await handleAPI();
          }
        }
      });
    });
  }

  void startTimerLoadData() {
    const oneSec = const Duration(seconds: 2);
    timer = Timer.periodic(
      oneSec,
      (Timer timers) async {
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          print('No connected');
          if (isConnected == true) {
            showDialogErrorInternet();
          }
          isConnected = false;
        } else {
          print('connected');
          if (isConnected == false) {
            isConnected = true;
            await handleAPI();
          }
        }
      },
    );
  }

  Future<void> handleAPI() async {
    print('goi api');
    await checkLogin();
    await getLayout();
    await Future.wait([
      Get.find<CustomerConfigController>().getAppTheme(),
      getBanner(),
      getWebTheme(),
      getHomeButton(),
      getAllCategory(),
      getBadge(),
      getProductDiscount(),
      getProductTopSale(),
      getProductNews(),
      getProductByCategory(),
      getPostNew(),
      getPopup(),
      getBannerAdsApp(),
    ]);
  }

  // void checkConnected() {
  //   print('=================xxxx============== check connected>');
  //   sub = connectivity.onConnectivityChanged
  //       .listen((ConnectivityResult result) async {
  //     EasyDebounce.debounce('connection', Duration(milliseconds: 1000),
  //         () async {
  //       connectionStatus = result;
  //
  //       print('=================xxxx==============>${result}');
  //
  //       if (connectionStatus == ConnectivityResult.none) {
  //         isConnected(false);
  //         showDialogErrorInternet();
  //       }
  //
  //       if (connectionStatus == ConnectivityResult.wifi ||
  //           connectionStatus == ConnectivityResult.mobile) {
  //         if (isConnected == false) {
  //           isConnected(true);
  //         }
  //
  //         if (isReconnecting == false) {
  //           print('===============================>gọi api');
  //           isReconnecting = true;
  //
  //           isReconnecting = false;
  //         }
  //       }
  //     });
  //   });
  // }

  void showDialogErrorInternet() {
    if (isShowed == false) {
      showDialog(
          barrierDismissible: true,
          context: Get.context!,
          builder: (context) {
            isShowed = true;
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Không có kết nối mạng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          });
    }
  }

  // void initCalling() {
  //   print('calling');
  //   CollectionReference reference =
  //       FirebaseFirestore.instance.collection('all_call');
  //   reference.snapshots().listen((querySnapshot) {
  //     EasyDebounce.debounce('debounce_data_app', Duration(milliseconds: 500),
  //         () {
  //       print('===========>DEBONCE DATA APP');
  //       listCalling(
  //           querySnapshot.docs.map((doc) => Calling.fromDoc(doc)).toList());
  //
  //       var indexCall =
  //           listCalling.indexWhere((e) => e.toId == infoCustomer.value.id);
  //
  //       if (indexCall != -1) {
  //         Get.to(() => VideoChatScreen(
  //               callingInput: listCalling[indexCall],
  //             ));
  //       }
  //
  //       var index = listCalling.indexWhere((e) =>
  //           e.toId == infoCustomer.value.id ||
  //           e.fromId == infoCustomer.value.id);
  //
  //       if (index != -1) {
  //         calling.value = listCalling[index];
  //       } else {
  //         calling.value.state = DISCONNECTED;
  //         calling.refresh();
  //       }
  //     }
  //         );
  //   });
  // }

  var packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  ).obs;

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value = info;
    print("===========>${info.version}");
  }

  Future<void> logout() async {
    infoCustomer.value = InfoCustomer();
    getBadge();
  }

  Future<void> checkLogin() async {
    if (await CustomerInfo().hasLogged()) {
      await getInfoCustomer();
      getBadge();
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
  }

  Future<void> checkIn() async {
    try {
      var data = await CustomerRepositoryManager.scoreRepository.checkIn();
      SahaAlert.showSuccess(message: "Điểm danh thành công");
      isCheckIn = false;
      getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getInfoCustomer() async {
    if (await CustomerInfo().hasLogged()) {
      try {
        var res = await CustomerRepositoryManager.infoCustomerRepository
            .getInfoCustomer();
        infoCustomer.value = res!.data!;
        isLogin.value = true;
      } catch (err) {
        isLogin.value = false;
      }
    } else {
      isLogin.value = false;
    }
  }

  Future<void> getHomeData() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getHomeData();
      homeData.value = data!;
      popups(data.popups!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getLayout() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getLayout();
      homeData.value.listLayout = data?.data;
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getBannerAdsApp() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getBannerAdsApp();
      homeData.value.bannerAdsApp = data!.bannerAdsApp!;
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getBanner() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getBanner();
      homeData.value.banner =
          BannerList(name: "banner", type: 'CAROUSEL', list: data!.data!);
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getWebTheme() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getWebTheme();
      webTheme.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getPopup() async {
    try {
      var data =
          await CustomerRepositoryManager.homeDataCustomerRepository.getPopup();
      homeData.value.popups = data!.data!.popups;
      popups(data.data!.popups);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getHomeButton() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getHomeButton();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'HOME_BUTTON');

      if (index != -1) {
        homeData.value.listLayout![index].list = data!.data;
      }
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getProductDiscount() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getProductDiscount();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'PRODUCTS_DISCOUNT');

      if (index != -1) {
        homeData.value.listLayout![index].list = data!.data;
      }
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getProductTopSale() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getProductTopSale();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'PRODUCTS_TOP_SALES');

      if (index != -1) {
        homeData.value.listLayout![index].list = data!.data;
      }
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getProductNews() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getProductNews();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'PRODUCTS_NEW');

      if (index != -1) {
        homeData.value.listLayout![index].list = data!.data;
      }
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getPostNew() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getPostNew();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'POSTS_NEW');

      if (index != -1) {
        homeData.value.listLayout![index].list = data!.data;
      }
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getProductByCategory() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getProductByCategory();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'PRODUCT_BY_CATEGORY');

      if (index != -1) {
        data!.data!.reversed.forEach((e) {
          homeData.value.listLayout!.insert(index, e);
        });
      }

      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllCategory() async {
    try {
      var data =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();

      var index = (homeData.value.listLayout ?? [])
          .indexWhere((e) => e.typeLayout == 'CATEGORY');
      if (index != -1) {
        homeData.value.listLayout![index].list = data!;
      }
      homeData.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  /// Badge

  Future<void> getBadge() async {
    try {
      var data = await CustomerRepositoryManager.badgeRepository.getBadge();
      badge.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
