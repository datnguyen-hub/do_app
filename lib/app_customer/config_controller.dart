import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/text_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/call/call.dart';
import 'components/toast/saha_alert.dart';
import 'model/config_app.dart';
import 'screen_can_edit/repository_widget_config.dart';
import 'screen_default/font_data/font_data.dart';
import 'utils/color.dart';

class CustomerConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();
  var isLoadingGet = false.obs;
  var contactButton = RxList<SpeedDialChild>();
  var currentTheme = ThemeData().obs;

  CustomerConfigController() {
    currentTheme.value = ThemeData(
      fontFamily: 'baloo2',
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'baloo2',
          height: 1.1,
        ),
        bodyLarge: TextStyle(
          height: 1.1,
        ),
        bodySmall: TextStyle(
          height: 1.1,
        ),
      ),
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    deleteContactButton();
  }

  void updateTheme() {
    currentTheme.value = ThemeData(
        fontFamily: 'baloo2',
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'baloo2',
            height: 1.2,
          ),
          bodyLarge: TextStyle(
            height: 1.2,
          ),
          bodySmall: TextStyle(
            height: 1.2,
          ),
        ),
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness:
              Color(HexColor.getColorFromHex(configApp.colorMain1!))
                          .computeLuminance() <
                      0.5
                  ? Brightness.dark
                  : Brightness.light,
        )),
        primarySwatch: MaterialColor(
          HexColor.getColorFromHex(configApp.colorMain1!),
          {
            50: HexColor(configApp.colorMain1!).withOpacity(0.1),
            100: HexColor(configApp.colorMain1!).withOpacity(0.2),
            200: HexColor(configApp.colorMain1!).withOpacity(0.3),
            300: HexColor(configApp.colorMain1!).withOpacity(0.4),
            400: HexColor(configApp.colorMain1!).withOpacity(0.5),
            500: HexColor(configApp.colorMain1!).withOpacity(0.6),
            600: HexColor(configApp.colorMain1!).withOpacity(0.7),
            700: HexColor(configApp.colorMain1!).withOpacity(0.8),
            800: HexColor(configApp.colorMain1!).withOpacity(0.9),
            900: HexColor(configApp.colorMain1!).withOpacity(1),
          },
        ));

    Get.changeTheme(currentTheme.value);
  }

  void addButton(BuildContext context) {
    contactButton([]);
    if (contactButton.isEmpty) {
      if (configApp.isShowIconHotline == true) {
        contactButton.add(
          SpeedDialChild(
            child: Icon(
              Icons.phone,
              color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
            ),
            backgroundColor: Colors.white,
            // label: configApp.phoneNumberHotline!.isEmpty
            //     ? null
            //     : configApp.phoneNumberHotline,
            // labelStyle: TextStyle(fontSize: 14.0),
            // labelBackgroundColor: Colors.white,
            onTap: () => Call.call("${configApp.phoneNumberHotline ?? ""}"),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }

      if (configApp.isShowIconEmail == true) {
        contactButton.add(
          SpeedDialChild(
            child: Icon(
              Icons.email,
              color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
            ),
            // backgroundColor: Colors.white,
            // label:
            //     configApp.contactEmail!.isEmpty ? null : configApp.contactEmail,
            // labelStyle: TextStyle(fontSize: 14.0),
            // labelBackgroundColor: Colors.white,
            onTap: () async {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: '${configApp.contactEmail ?? ""}',
                query: encodeQueryParameters(<String, String>{
                  'subject': '',
                }),
              );

              launchUrl(emailLaunchUri);
            },
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
      if (configApp.isShowIconFacebook == true) {
        contactButton.add(
          SpeedDialChild(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                  "packages/sahashop_customer/assets/icons/facebook-2.svg"),
            ),
            backgroundColor: Colors.white,
            //label:
            // labelWidget:configApp.idFacebook!.isEmpty ? null : Container(
            //     width: Get.width / 2,
            //     padding: EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     child: Center(
            //       child: Text(
            //           '${configApp.idFacebook!.isEmpty ? null : configApp.idFacebook}'),
            //     )),
            // labelStyle: TextStyle(
            //   fontSize: 14.0,
            // ),
            // labelBackgroundColor: Colors.white,
            onTap: () async {
              print(configApp.idFacebook);
              if (configApp.idFacebook != null &&
                  configApp.idFacebook!.contains("https://")) {
                await launchUrl(Uri.parse(configApp.idFacebook!));
                return;
              }
              var messengerUrl = "http://m.me/${configApp.idFacebook}";

              final Uri messengerUri = Uri.parse(messengerUrl);
              if (await canLaunchUrl(messengerUri)) {
                await launchUrl(messengerUri);
              } else {
                await launchUrl(Uri.parse(
                    "https://www.facebook.com/${configApp.idFacebook}"));
                // throw 'Could not launchhh $messengerUrl';
              }
            },
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
      if (configApp.isShowIconZalo == true) {
        contactButton.add(
          SpeedDialChild(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                  "packages/sahashop_customer/assets/icons/zalo.svg"),
            ),
            backgroundColor: Colors.white,
            // label: configApp.idZalo!.isEmpty ? null : configApp.idZalo,
            // labelStyle: TextStyle(fontSize: 14.0),
            // labelBackgroundColor: Colors.white,
            onTap: () => launchUrl(Uri.parse("${configApp.idZalo}")),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
    }
  }

  // void launchURL(String phone) async {
  //   var tel = Uri(scheme: "tel", path: phone);
  //   await canLaunchUrl(tel)
  //       ? await launchUrl(tel)
  //       : throw 'Could not launch $phone';
  // }

  void deleteContactButton() {
    contactButton = new RxList<SpeedDialChild>();
  }

  Future<bool?> getAppTheme({bool refresh = false}) async {
    try {
      if (refresh == false) isLoadingGet.value = true;
      var data =
          (await CustomerRepositoryManager.configUiRepository.getAppTheme())!;
      configApp.colorMain1 = data.colorMain1 ?? "#ff93b9b4";
      configApp.fontFamily =
          data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
              ? data.fontFamily
              : FONT_DATA.keys.toList()[0];
      configApp.productItemType = data.productItemType ?? 0;
      if (configApp.productItemType! >
          RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET.length) {
        configApp.productItemType =
            RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET.length - 1;
      }
      configApp.carouselType = data.carouselType ?? 0;
      configApp.homePageType = data.homePageType ?? 0;
      configApp.categoryPageType = data.categoryPageType ?? 0;
      configApp.productPageType = data.productPageType ?? 0;
      configApp.logoUrl = data.logoUrl ?? "";
      configApp.phoneNumberHotline = data.phoneNumberHotline ?? "";
      configApp.contactEmail = data.contactEmail ?? "";
      configApp.idFacebook = data.idFacebook ?? "";
      configApp.idZalo = data.idZalo ?? "";
      configApp.isShowIconHotline = data.isShowIconHotline ?? false;
      configApp.isShowIconEmail = data.isShowIconEmail ?? false;
      configApp.isShowIconFacebook = data.isShowIconFacebook ?? false;
      configApp.isShowIconZalo = data.isShowIconZalo ?? false;
      configApp.carouselAppImages = data.carouselAppImages;
      configApp.typeButton = data.typeButton ?? 0;
      configApp.isScrollButton = data.isScrollButton ?? false;
      configApp.contactFanpage = data.contactFanpage ?? "";
      configApp.contactAddress = data.contactAddress ?? "";
      configApp.contactTimeWork = data.contactTimeWork ?? "";
      configApp.contactPhoneNumber = data.contactPhoneNumber ?? "";
      configApp.contactEmail = data.contactEmail ?? "";

      isLoadingGet.value = false;
      updateTheme();
      return true;
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi lấy dữ liệu Config App");
      isLoadingGet.value = false;
    }
    return null;
  }
}
