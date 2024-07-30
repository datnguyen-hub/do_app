import 'package:android_intent_plus/android_intent.dart';
import 'package:badges/badges.dart' as b;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/agency_wallet_screen/agency_wallet_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/code_retroduce/code_retroduct_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/ctv_wallet_screen/ctv_wallet_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/list_product_rose/list_product_rose_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/notification/notification_cus_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config_controller.dart';
import '../../screen_default/address_screen/all_address_customer/all_address_customer_screen.dart';
import '../../screen_default/bought_products/bought_products.dart';
import '../../screen_default/cart_screen/cart_controller.dart';
import '../../screen_default/cart_screen/cart_screen.dart';
import '../../screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import '../../screen_default/config_profile_screen/config_profile_screen.dart';
import '../../screen_default/favorites/favorites.dart';
import '../../screen_default/login/login_screen.dart';
import '../../screen_default/member/member_screen.dart';
import '../../screen_default/order_history/order_history_screen.dart';
import '../../screen_default/register/register_customer_screen.dart';
import '../agency_customer/check_status_agency.dart';
import '../chat_customer_screen/all_person_chat/all_person_chat_screen.dart';
import '../community/community_screen.dart';
import '../ctv_customer/check_status_collaborator.dart';
import '../data_app_controller.dart';
import '../education/course_screen.dart';
import 'contact/contact_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();
  CustomerConfigController customerConfigController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Colors.indigo,
        onRefresh: () async {
          await dataAppCustomerController.getInfoCustomer();
          dataAppCustomerController.getBadge();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                head(context),
                InkWell(
                  onTap: () {
                    Get.to(() => OrderHistoryScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                "packages/sahashop_customer/assets/icons/document.svg",
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Đơn mua",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Xem lịch sử mua hàng",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[700]),
                            ),
                            Container(
                                height: 13,
                                width: 13,
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/right_arrow.svg",
                                  color: Colors.black,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                dataAppCustomerController.isLogin.value == true
                    ? Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => OrderHistoryScreen(
                                            initPage: 0,
                                          ));
                                    },
                                    child: b.Badge(
                                      badgeStyle: b.BadgeStyle(
                                        padding: EdgeInsets.all(3),
                                      ),
                                      badgeContent: Text(
                                        '${dataAppCustomerController.badge.value.ordersWaitingForProgressing}',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                      showBadge: dataAppCustomerController
                                                  .badge
                                                  .value
                                                  .ordersWaitingForProgressing ==
                                              0
                                          ? false
                                          : true,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 44,
                                        width: 44,
                                        child: SvgPicture.asset(
                                          "packages/sahashop_customer/assets/icons/wallet.svg",
                                          height: 30,
                                          width: 30,
                                          color: SahaColorUtils()
                                              .colorPrimaryTextWithWhiteBackground(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Chờ xác nhận",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => OrderHistoryScreen(
                                            initPage: 1,
                                          ));
                                    },
                                    child: b.Badge(
                                      badgeStyle: b.BadgeStyle(
                                        padding: EdgeInsets.all(3),
                                      ),
                                      badgeContent: Text(
                                        '${dataAppCustomerController.badge.value.ordersPacking}',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                      showBadge: dataAppCustomerController
                                                  .badge.value.ordersPacking ==
                                              0
                                          ? false
                                          : true,
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/icons/box.svg",
                                        height: 30,
                                        width: 30,
                                        color: SahaColorUtils()
                                            .colorPrimaryTextWithWhiteBackground(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Chờ lấy hàng",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => OrderHistoryScreen(
                                            initPage: 2,
                                          ));
                                    },
                                    child: b.Badge(
                                      badgeStyle: b.BadgeStyle(
                                        padding: EdgeInsets.all(3),
                                      ),
                                      badgeContent: Text(
                                        '${dataAppCustomerController.badge.value.ordersShipping}',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                      showBadge: dataAppCustomerController
                                                  .badge.value.ordersShipping ==
                                              0
                                          ? false
                                          : true,
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/icons/delivery_truck.svg",
                                        height: 30,
                                        width: 30,
                                        color: SahaColorUtils()
                                            .colorPrimaryTextWithWhiteBackground(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Đang giao",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => OrderHistoryScreen(
                                            initPage: 3,
                                          ));
                                    },
                                    child: b.Badge(
                                      badgeStyle: b.BadgeStyle(
                                        padding: EdgeInsets.all(3),
                                      ),
                                      badgeContent: Text(
                                        '${dataAppCustomerController.badge.value.ordersNoReviews}',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                      showBadge: dataAppCustomerController.badge
                                                  .value.ordersNoReviews ==
                                              0
                                          ? false
                                          : true,
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/icons/score.svg",
                                        height: 25,
                                        width: 25,
                                        color: SahaColorUtils()
                                            .colorPrimaryTextWithWhiteBackground(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Đánh giá",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => CodeRetroduceScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                "packages/sahashop_customer/assets/style_7/ctv.svg",
                                color: Colors.indigo,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mã giới thiệu",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Giới thiệu bạn bè tham gia và nhận phần thưởng",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey[700]),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 13,
                          width: 13,
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/right_arrow.svg",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  height: 8,
                  color: Colors.grey[100],
                ),
                if (dataAppCustomerController.badge.value.hasCommunity == true)
                  itemProfile(
                    title: "Cộng đồng",
                    svgAssets:
                        "packages/sahashop_customer/assets/icons/community.svg",
                    onTap: () {
                      Get.to(() => CommunityLockScreen(showIconBack: true));
                    },
                    colorSVG: Colors.blue,
                  ),
                if (dataAppCustomerController.badge.value.hasCommunity == true)
                  Divider(
                    height: 1,
                  ),
                if (dataAppCustomerController.badge.value.hasTrain == true)
                  itemProfile(
                    title: "Đào tạo",
                    svgAssets:
                        "packages/sahashop_customer/assets/icons/magistrate.svg",
                    onTap: () {
                      Get.to(() => CourseLockScreen());
                    },
                    colorSVG: Colors.indigo,
                  ),
                if (dataAppCustomerController.badge.value.hasTrain == true)
                  Divider(
                    height: 1,
                  ),
                Obx(
                  () => dataAppCustomerController.infoCustomer.value.isAgency ==
                              true ||
                          (dataAppCustomerController
                                  .badge.value.agencyRegisterRequest?.status !=
                              1 && dataAppCustomerController
                                  .badge.value.agencyRegisterRequest != null)
                      ? const SizedBox()
                      : itemProfile(
                          title: dataAppCustomerController
                                      .infoCustomer.value.isCollaborator ==
                                  true
                              ? "Ví Cộng tác viên"
                              : "Đăng ký CTV${dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 0 ? " (Đang chờ duyệt)" : ""}",
                          svgAssets:
                              "packages/sahashop_customer/assets/style_7/user_register.svg",
                          onTap: () {
                            if (dataAppCustomerController.badge.value
                                        .collaboratorRegisterRequest?.status !=
                                    2 &&
                                dataAppCustomerController.badge.value
                                        .collaboratorRegisterRequest !=
                                    null) {
                              Get.to(() => CheckStatusCollaboratorScreen())!
                                  .then((value) {
                                dataAppCustomerController.getBadge();
                                dataAppCustomerController.getInfoCustomer();
                              });
                              return;
                            }
                            Get.to(() => CtvWalletScreen())!.then((value) =>
                                dataAppCustomerController.getBadge());
                          },
                          colorSVG: Colors.pink,
                        ),
                ),
                Divider(
                  height: 1,
                ),
                Obx(() => dataAppCustomerController
                                .infoCustomer.value.isCollaborator ==
                            true ||
                        (dataAppCustomerController
                                .badge.value.collaboratorRegisterRequest?.status !=
                            1 && dataAppCustomerController
                                .badge.value.collaboratorRegisterRequest != null)
                    ? const SizedBox()
                    : itemProfile(
                        title: dataAppCustomerController
                                    .infoCustomer.value.isAgency ==
                                true
                            ? "Ví Đại lý"
                            : "Đăng ký Đại lý",
                        svgAssets:
                            "packages/sahashop_customer/assets/style_7/agency.svg",
                        onTap: () {
                          if (dataAppCustomerController.badge.value
                                      .agencyRegisterRequest?.status !=
                                  2 &&
                              dataAppCustomerController
                                      .badge.value.agencyRegisterRequest !=
                                  null) {
                            Get.to(() => CheckStatusAgencyScreen())!
                                .then((value) {
                              dataAppCustomerController.getBadge();
                              dataAppCustomerController.getInfoCustomer();
                            });
                            return;
                          }
                          Get.to(() => AgencyWalletScreen());
                        },
                        colorSVG: Colors.teal,
                      )),
                Divider(
                  height: 1,
                ),
                itemProfile(
                    title: "Xu tích luỹ",
                    svgAssets:
                        "packages/sahashop_customer/assets/style_7/dollar.svg",
                    onTap: () {
                      Get.to(() => MemberScreen());
                    },
                    colorSVG: Colors.red,
                    subText:
                        "${SahaStringUtils().convertToMoney(dataAppCustomerController.badge.value.customerPoint ?? 0)} Xu "),
                Divider(
                  height: 1,
                ),
                if (dataAppCustomerController.badge.value.statusCollaborator ==
                    1)
                  Column(
                    children: [
                      itemProfile(
                        title: "Sản phẩm hoa hồng",
                        svgAssets:
                            "packages/sahashop_customer/assets/icons/gift_box.svg",
                        onTap: () {
                          Get.to(() => CategoryCtvSceen());
                        },
                        colorSVG: Colors.amber,
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  ),
                itemProfile(
                  title: "Mua lại",
                  svgAssets:
                      "packages/sahashop_customer/assets/style_7/bag.svg",
                  onTap: () {
                    Get.to(BoughtProductsScreen());
                  },
                  colorSVG: Colors.indigo,
                ),
                Divider(
                  height: 1,
                ),
                itemProfile(
                  title: "Ví Voucher",
                  svgAssets:
                      "packages/sahashop_customer/assets/style_7/voucher.svg",
                  onTap: () {
                    Get.to(() => ChooseVoucherCustomerScreen());
                  },
                  colorSVG: Colors.deepOrange,
                ),
                Divider(
                  height: 1,
                ),
                itemProfile(
                  title: "Sản phẩm yêu thích",
                  svgAssets:
                      "packages/sahashop_customer/assets/style_7/heart.svg",
                  onTap: () {
                    Get.to(() => FavoritesScreen());
                  },
                  colorSVG: Colors.red,
                ),
                Divider(
                  height: 1,
                ),
                itemProfile(
                  title: "Địa chỉ của tôi",
                  svgAssets:
                      "packages/sahashop_customer/assets/style_7/map.svg",
                  onTap: () {
                    Get.to(() => AllAddressCustomerScreen());
                  },
                  colorSVG: Colors.lightBlue,
                ),
                Divider(
                  height: 1,
                ),
                itemProfile(
                  title: "Liên hệ ",
                  svgAssets:
                      "packages/sahashop_customer/assets/style_7/dialog.svg",
                  onTap: () {
                    Get.to(() => ContactScreen());
                  },
                  colorSVG: Colors.green,
                ),
                Divider(
                  height: 1,
                ),
                itemProfile(
                  title: "Website",
                  svgAssets:
                      "packages/sahashop_customer/assets/style_7/global.svg",
                  onTap: () {
                    var url =
                        'https://${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}';
                    if (dataAppCustomerController.badge.value.domain == null) {
                      url =
                          "https://${StoreInfo().getCustomerStoreCode()}.myiki.vn";
                      launchUrl(Uri.parse(url));
                      return;
                    }

                    if (dataAppCustomerController.badge.value.domain!
                        .contains('https://')) {
                      url = dataAppCustomerController.badge.value.domain!;
                      print(url);
                      launchUrl(Uri.parse(url));
                      return;
                    } else {
                      url =
                          "https://${dataAppCustomerController.badge.value.domain!}";
                      print(url);
                      launchUrl(Uri.parse(url));
                      return;
                    }
                  },
                  colorSVG: Colors.blueAccent,
                ),
                Divider(
                  height: 1,
                ),
                itemProfile(
                  title: "Fanpage",
                  svgAssets:
                      "packages/sahashop_customer/assets/icons/facebook-2.svg",
                  onTap: () async {
                    if ((customerConfigController.configApp.contactFanpage ??
                            "") ==
                        "") {
                      SahaAlert.showError(
                          message: "Thương hiệu chưa có fanpage");
                    } else {
                      if (Theme.of(context).platform ==
                          TargetPlatform.android) {
                        final AndroidIntent intent = AndroidIntent(
                          action: 'android.intent.action.VIEW',
                          data:
                              customerConfigController.configApp.contactFanpage,
                          package: 'com.android.chrome',
                        );
                        await intent.launch();
                      } else {
                        await launchUrl(Uri.parse(
                            customerConfigController.configApp.contactFanpage ??
                                ""));
                      }
                    }
                  },
                ),
                Divider(
                  height: 1,
                ),
                dataAppCustomerController.isLogin.value == true
                    ? itemProfile(
                        title: "Đăng xuất",
                        svgAssets:
                            "packages/sahashop_customer/assets/svg/logout.svg",
                        onTap: () {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn muốn đăng xuất",
                              onOK: () {
                                CustomerInfo().logout();
                              });
                        })
                    : Container(),
                TextButton(
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess:
                            "Tài khoản của bạn sẽ được xoá sau khoảng thời gian 1 ngày, trong thời gian này bạn có thể huỷ kích hoạt xoá tài khoản bằng cách đăng nhập lại!",
                        onOK: () {
                          CustomerInfo().logout();
                        });
                  },
                  child: Text(
                    "Yêu cầu xoá tài khoản",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey[500]),
                  ),
                ),
                Container(
                  width: Get.width,
                  padding:
                      EdgeInsets.only(top: 5, right: 10, bottom: 20, left: 10),
                  child: Center(
                    child: Text(
                      "version ${dataAppCustomerController.packageInfo.value.version} - Build ${dataAppCustomerController.packageInfo.value.buildNumber}",
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemProfile(
      {required String title,
      required String svgAssets,
      required Function onTap,
      Color? colorSVG,
      String? subText}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    svgAssets,
                    color: colorSVG,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                if (subText != null)
                  Text(
                    subText,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                Container(
                    height: 13,
                    width: 13,
                    child: SvgPicture.asset(
                      "packages/sahashop_customer/assets/icons/right_arrow.svg",
                      color: Colors.black,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget head(BuildContext context) {
    return Container(
      height: 185,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: checkFullInfo() == false ? 26 : 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              b.Badge(
                  badgeStyle: b.BadgeStyle(
                    padding: EdgeInsets.all(3),
                  ),
                  position: b.BadgePosition.custom(end: 5, top: 5),
                  badgeContent: Text(
                    '${dataAppCustomerController.badge.value.notificationUnread}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  showBadge: dataAppCustomerController
                                  .badge.value.notificationUnread ==
                              0 ||
                          dataAppCustomerController
                                  .badge.value.notificationUnread ==
                              null
                      ? false
                      : true,
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_active,
                      color:
                          Theme.of(context).primaryTextTheme.bodyLarge!.color,
                    ),
                    onPressed: () {
                      Get.to(() => NotificationCusScreen())!.then(
                          (value) => {dataAppCustomerController.getBadge()});
                    },
                  )),
              b.Badge(
                  badgeStyle: b.BadgeStyle(
                    padding: EdgeInsets.all(3),
                  ),
                  badgeContent: Text(
                    '${cartController.listOrder.length}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  showBadge:
                      cartController.listOrder.length == 0 ? false : true,
                  position: b.BadgePosition.custom(end: 5, top: 5),
                  child: IconButton(
                    icon: Icon(
                      Ionicons.cart,
                      color:
                          Theme.of(context).primaryTextTheme.bodyLarge!.color,
                    ),
                    onPressed: () {
                      Get.to(() => CartScreen())!.then(
                          (value) => {dataAppCustomerController.getBadge()});
                    },
                  )),
              IconButton(
                  icon: Icon(
                    Icons.chat_outlined,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  ),
                  onPressed: () {
                    Get.to(() => AllPersonChatScreen());
                  }),
            ],
          ),
          dataAppCustomerController.isLogin.value == true
              ? Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ConfigProfileScreen(
                                  infoCustomer: dataAppCustomerController
                                      .infoCustomer.value,
                                ))!
                            .then((value) =>
                                {dataAppCustomerController.getInfoCustomer()});
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[200]!)),
                        child: ClipRRect(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CachedNetworkImage(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                imageUrl: dataAppCustomerController
                                        .infoCustomer.value.avatarImage ??
                                    "",
                                errorWidget: (context, url, error) =>
                                    SahaEmptyAvata(),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 20,
                                  width: 100,
                                  color: Colors.black45.withOpacity(0.3),
                                  child: Center(
                                    child: Text(
                                      "Sửa",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(3000),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataAppCustomerController.infoCustomer.value.name ??
                                "Chưa có tên",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleLarge!
                                  .color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ConfigProfileScreen(
                                            infoCustomer:
                                                dataAppCustomerController
                                                    .infoCustomer.value,
                                          ))!
                                      .then((value) => {
                                            dataAppCustomerController
                                                .getInfoCustomer()
                                          });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Thông tin tài khoản",
                                        style: TextStyle(
                                            color: colorText,
                                            fontSize: 13,
                                            height: 1.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: colorText,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => LoginScreenCustomer(),
                                )!
                                    .then((value) => {
                                          dataAppCustomerController
                                              .getInfoCustomer()
                                        });
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground()),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => RegisterCustomerScreen(
                                        isOneBack: true))!
                                    .then((value) => {
                                          dataAppCustomerController
                                              .getInfoCustomer()
                                        });
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleLarge!
                                            .color!)),
                                child: Center(
                                    child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleLarge!
                                          .color),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
          checkFullInfo() == false
              ? Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                  margin: EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Cập nhật đầy đủ thông tin để hưởng các quyền lợi",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  bool checkFullInfo() {
    if (dataAppCustomerController.infoCustomer.value.name == "" ||
        dataAppCustomerController.infoCustomer.value.name == null ||
        dataAppCustomerController.infoCustomer.value.dateOfBirth == null) {
      print(dataAppCustomerController.infoCustomer.value.dateOfBirth);
      return false;
    } else {
      return true;
    }
  }

  Color colorText = Colors.grey;

  String checkMemberType() {
    if (dataAppCustomerController.badge.value.totalBoughtAmount! >= 2000000 &&
        dataAppCustomerController.badge.value.totalBoughtAmount! < 4000000) {
      colorText = Color(0xffe6b92f);
      return "Vàng";
    } else if (dataAppCustomerController.badge.value.totalBoughtAmount! >=
            4000000 &&
        dataAppCustomerController.badge.value.totalBoughtAmount! < 8000000) {
      colorText = Color(0xff07abc3);
      return "Bạch kim";
    } else if (dataAppCustomerController.badge.value.totalBoughtAmount! >=
        8000000) {
      colorText = Colors.indigoAccent;
      return "Kim cương";
    } else {
      colorText = Colors.grey;
      return "Bạc";
    }
  }
}
