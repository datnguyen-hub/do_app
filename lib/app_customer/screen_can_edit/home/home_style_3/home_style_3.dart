import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as b;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home/home_style_3/home_style_3_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/notification/notification_cus_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/search_bar_type/seach_bar_type4.dart';

import '../../../screen_default/chat_customer_screen/all_person_chat/all_person_chat_screen.dart';
import '../home_body.dart';

class HomeScreenStyle3 extends StatefulWidget {
  const HomeScreenStyle3({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle3State createState() => _HomeScreenStyle3State();
}

class _HomeScreenStyle3State extends State<HomeScreenStyle3> {
  HomeStyle3Controller homeStyle3Controller = HomeStyle3Controller();
  final ScrollController _scrollController = ScrollController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        homeStyle3Controller.changeOpacitySearch(1);
      } else {
        homeStyle3Controller
            .changeOpacitySearch(_scrollController.offset / 100);
      }

      if (_scrollController.offset > 315 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        homeStyle3Controller.checkTouch.value = true;
        homeStyle3Controller.changeHeightAppbar(0);
      } else if (_scrollController.offset < 315 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        homeStyle3Controller.changeHeightAppbar(35.0);
      }
    });

    configController.addButton(context);
  }

  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        floatingActionButton: configController.contactButton.isNotEmpty
            ? SpeedDial(
                childMargin: EdgeInsets.only(bottom: 20, left: 18),
                icon: Icons.phone,
                activeIcon: Icons.read_more_sharp,
                visible: true,
                closeManually: false,
                renderOverlay: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.grey[300],
                overlayOpacity: 0.5,
                onOpen: () => print('OPENING DIAL'),
                onClose: () => print('DIAL CLOSED'),
                heroTag: 'speed-dial-hero-tag3',
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 8.0,
                shape: CircleBorder(),
                children: configController.contactButton,
              )
            : Container(),
        body: Stack(
          children: [
            Column(
              children: [
                Obx(
                  () => SizedBox(
                    height: 100 + homeStyle3Controller.changeHeight.value,
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: Colors.indigo,
                    onRefresh: () async {
                      await homeStyle3Controller.refresh();
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          BannerWidget(),
                          if (dataAppCustomerController
                                      .homeData.value.bannerAdsApp?.position0 !=
                                  null &&
                              dataAppCustomerController.homeData.value
                                  .bannerAdsApp!.position0!.isNotEmpty)
                            bannerAdsItem(dataAppCustomerController
                                .homeData.value.bannerAdsApp!.position0!),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => homeStyle3Controller.isRefresh.value
                              ? HomeBodyWidget()
                              : HomeBodyWidget()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 110),
                height: 100 + homeStyle3Controller.changeHeight.value,
                width: double.infinity,
                color: Colors.white
                    .withOpacity(homeStyle3Controller.opacity.value),
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          height: homeStyle3Controller.changeHeight.value < 0
                              ? 0
                              : homeStyle3Controller.changeHeight.value,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(QRScreen());
                                },
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/svg/qr-code-scan.svg",
                                  height: 25,
                                  width: 25,
                                  color: Colors.grey,
                                ),
                              ),
                              if (homeStyle3Controller.changeHeight.value ==
                                  35.0)
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => MemberScreen());
                                          },
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "xin chào!",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  "${dataAppCustomerController.infoCustomer.value.name ?? "Khách"}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => AllPersonChatScreen());
                                  },
                                  child: b.Badge(
                                    badgeStyle: b.BadgeStyle(
                                      padding: EdgeInsets.all(3),
                                    ),
                                    position:
                                        b.BadgePosition.custom(end: 0, top: -5),
                                    badgeContent: Text(
                                      '${dataAppCustomerController.badge.value.chatsUnread}',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    showBadge: dataAppCustomerController
                                                    .badge.value.chatsUnread ==
                                                0 ||
                                            homeStyle3Controller
                                                    .changeHeight.value <
                                                35
                                        ? false
                                        : true,
                                    child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/chat.svg",
                                      height: 28,
                                      width: 28,
                                      color: Colors.grey[600],
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => NotificationCusScreen())!.then(
                                        (value) => {
                                              dataAppCustomerController
                                                  .getBadge()
                                            });
                                  },
                                  child: b.Badge(
                                    badgeStyle: b.BadgeStyle(
                                      padding: EdgeInsets.all(3),
                                    ),
                                    position:
                                        b.BadgePosition.custom(end: 0, top: -7),
                                    badgeContent: Text(
                                      '${dataAppCustomerController.badge.value.notificationUnread}',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    showBadge:
                                        dataAppCustomerController.badge.value
                                                        .notificationUnread ==
                                                    0 ||
                                                dataAppCustomerController
                                                        .badge
                                                        .value
                                                        .notificationUnread ==
                                                    null ||
                                                homeStyle3Controller
                                                        .changeHeight.value <
                                                    35
                                            ? false
                                            : true,
                                    child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/bell2.svg",
                                      height: 25,
                                      width: 25,
                                      color: Colors.grey[600],
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SearchBarType4(
                        onSearch: () {
                          Get.to(CategoryProductScreen(
                            autoSearch: true,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(CategoryProductScreen(
            categoryId: category!.id,
          ));
        },
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 0.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 55,
                        width: 55,
                        imageUrl: category!.imageUrl ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SahaLoadingContainer(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    category!.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
