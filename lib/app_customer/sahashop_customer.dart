import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahashop_customer/app_customer/socket/socket.dart';
import 'package:sahashop_customer/app_customer/utils/appflyer.dart';

import 'config_controller.dart';
import 'remote/customer_service_manager.dart';
import 'screen_default/data_app_controller.dart';
import 'screen_default/data_app_screen.dart';
import 'screen_default/navigation_scrren/navigation_screen.dart';
import 'utils/device_info.dart';
import 'utils/store_info.dart';
import 'utils/thread_data.dart';

class SahaShopCustomer extends StatelessWidget {
  final String storeCode;
  final String storeName;
  final bool isPreview;
  final String? slogan;
  final Color? sloganColor;
  final NavigatorObserver? observer;
  final String? appId;
  final String? afDevKey;

  const SahaShopCustomer(
      {Key? key,
      required this.storeCode,
      required this.storeName,
      this.isPreview = false,
      this.slogan,
      this.observer,
      this.sloganColor,
      this.afDevKey,this.appId
      });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    CustomerServiceManager.initialize();
    DeviceInfo().initDeviceId();
    ////////////////////////////////////////////////
    StoreInfo().setCustomerStoreCode(storeCode);
    StoreInfo().name = storeName;
    ////////////////////////////////////////////////
    SocketCustomer().connect();
    CustomerConfigController configController =
        Get.isRegistered<CustomerConfigController>()
            ? Get.find()
            : Get.put(CustomerConfigController());
    DataAppCustomerController dataAppCustomerController =
        Get.isRegistered<DataAppCustomerController>()
            ? Get.find()
            : 
            Get.put(DataAppCustomerController());

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    if(afDevKey!= null && appId != null) {
       AppFlyer().initAppFlyer(afDevKey: afDevKey!,appId: appId!);
    }

    if (isPreview == true) {
      FlowData().setIsOnline(true);
      return LoadAppScreen(
        logo: configController.configApp.logoUrl,
        slogan: slogan,
        sloganColor: sloganColor,
      );
    } else {
      FlowData().setIsOnline(true);

      return GetMaterialApp(
        title: storeCode,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: LoadAppScreen(
          logo: configController.configApp.logoUrl,
          slogan: slogan,
          sloganColor: sloganColor,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          fontFamily: 'baloo2',
          scaffoldBackgroundColor: Colors.white,
        ),
        navigatorObservers:
            observer == null ? [] : <NavigatorObserver>[observer!],
        getPages: [
          GetPage(name: "/customer_home", page: () => NavigationScreen())
        ],
        supportedLocales: [
          Locale('vi', 'VN'),
        ],
      );
    }
  }
}
