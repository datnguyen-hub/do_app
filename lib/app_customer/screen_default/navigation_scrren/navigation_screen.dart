import 'dart:io';

import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/popup/popup.dart';
import 'package:sahashop_customer/app_customer/screen_default/category_post_screen/read_post_screen/input_model_post.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screen_can_edit/product_screen/product_screen.dart';
import '../../screen_default/data_app_controller.dart';
import '../cart_screen/cart_controller.dart';
import '../category_post_screen/read_post_screen/read_post_screen.dart';
import 'navigation_controller.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController navigationController = NavigationController();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 2000), () {
        checkVersion();
        if (dataAppCustomerController.popups.isNotEmpty &&
            dataAppCustomerController.isShowed == false) {
          PopupShow.showPopup();
          dataAppCustomerController.isShowed = true;
        }
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (dataAppCustomerController.badge.value.dynamicLinks?.phoneRef !=
            null) {
          CustomerInfo().setCollaboratorByCustomerId(
              dataAppCustomerController
                  .badge.value.dynamicLinks?.phoneRef?.phone,
              dataAppCustomerController.badge.value.dynamicLinks?.phoneRef
                  ?.collaboratorByCustomerId);
        }
        if (dataAppCustomerController
                .badge.value.dynamicLinks?.productRef?.handled ==
            false) {
          Get.to(() => ProductScreen(
                productId: int.tryParse(dataAppCustomerController
                        .badge.value.dynamicLinks?.productRef?.referencesId ??
                    ''),
              ));
          navigationController.handleDynamicLink(
              id: dataAppCustomerController
                      .badge.value.dynamicLinks?.productRef?.id ??
                  -1);
          return;
        }
        if (dataAppCustomerController
                .badge.value.dynamicLinks?.postRef?.handled ==
            false) {
          Get.to(() => ReadPostScreen(
                inputModelPost: InputModelPost(
                    postId: int.parse(dataAppCustomerController
                            .badge.value.dynamicLinks?.postRef?.referencesId ??
                        '')),
              ));
          navigationController.handleDynamicLink(
              id: dataAppCustomerController
                      .badge.value.dynamicLinks?.postRef?.id ??
                  -1);
          return;
        }
      });
    });
    super.initState();
  }

  void checkVersion() async {
    var versionBackend = (Platform.isAndroid
            ? (dataAppCustomerController.badge.value.versionAndroid ?? "0")
            : (dataAppCustomerController.badge.value.versionIos ?? "0"))
        .replaceAll(".", "");
    var versionBuild =
        dataAppCustomerController.packageInfo.value.version.replaceAll(".", "");

    print("=========================== ver back end: $versionBackend");
    print("=========================== ver build: $versionBuild");

    if ((int.tryParse(versionBackend) ?? 0) >
        (int.tryParse(versionBuild) ?? 0)) {
      SahaDialogApp.showDialogYesNo(
          mess: "Có bản cập nhật mới",
          onOK: () async {
            if (Platform.isAndroid) {
              print('is Android');
              final url = Uri.parse(
                  "market://details?id=${dataAppCustomerController.packageInfo.value.packageName}");
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            } else {
              final url = Uri.parse(
                  dataAppCustomerController.badge.value.linkAppple ?? '');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            children: navigationController.navigationHome,
            index: navigationController.selectedIndexBottomBar.value,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(10, 0),
                    spreadRadius: 0,
                    blurRadius: 20),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BottomNavigationBar(
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedItemColor:
                    SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: b.Badge(
                      badgeStyle: b.BadgeStyle(
                        padding: EdgeInsets.all(4),
                      ),
                      position: b.BadgePosition.custom(end: -4, top: -4),
                      badgeContent: Text(
                        '${dataAppCustomerController.badge.value.cartQuantity}',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                      showBadge:
                          dataAppCustomerController.badge.value.cartQuantity ==
                                  0
                              ? false
                              : true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SvgPicture.asset(
                          "packages/sahashop_customer/assets/icons/cart_home_new.svg",
                          color: navigationController
                                      .selectedIndexBottomBar.value ==
                                  0
                              ? SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground()
                              : null,
                        ),
                      ),
                    ),
                    label: 'Giỏ hàng',
                  ),
                  dataAppCustomerController.badge.value.hasCommunity == true
                      ? BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/community_home_new.svg",
                              color: navigationController
                                          .selectedIndexBottomBar.value ==
                                      1
                                  ? SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground()
                                  : Colors.grey,
                            ),
                          ),
                          label: 'Cộng đồng',
                        )
                      : BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/document.svg",
                              color: navigationController
                                          .selectedIndexBottomBar.value ==
                                      1
                                  ? SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground()
                                  : Color(0xFF64748B),
                            ),
                          ),
                          label: 'Tin tức',
                        ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/home_new.svg",
                        color:
                            navigationController.selectedIndexBottomBar.value ==
                                    2
                                ? SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground()
                                : Color(0xFF64748B),
                      ),
                    ),
                    label: 'Trang chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/cate_home_new.svg",
                        color:
                            navigationController.selectedIndexBottomBar.value ==
                                    3
                                ? SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground()
                                : null,
                      ),
                    ),
                    label: 'Danh mục',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/profile_home_new.svg",
                        color:
                            navigationController.selectedIndexBottomBar.value ==
                                    4
                                ? SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground()
                                : null,
                      ),
                    ),
                    label: 'Tài khoản',
                  ),
                ],
                currentIndex: navigationController.selectedIndexBottomBar.value,
                onTap: (currentIndex) {
                  navigationController.selectedIndexBottomBar.value =
                      currentIndex;
                  if (currentIndex == 0) {
                    Get.find<CartController>().refresh();
                  }
                  if (currentIndex == 2) {
                    if ((dataAppCustomerController
                                .homeData.value.banner?.list ??
                            [])
                        .isEmpty) {
                      dataAppCustomerController.getHomeData();
                    }
                  }
                  if (currentIndex == 4) {
                    Get.find<DataAppCustomerController>().getBadge();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
