import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as b;
import 'package:sahashop_customer/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/widget/silver_appbar.dart';
import '../../../config_controller.dart';
import '../../../model/category.dart';
import '../../../screen_default/chat_customer_screen/all_person_chat/all_person_chat_screen.dart';
import '../../../screen_default/notification/notification_cus_screen.dart';
import '../../../utils/action_tap.dart';
import 'home_style_7_controller.dart';
import 'widget/body.dart';

class HomeScreenStyle7 extends StatefulWidget {
  const HomeScreenStyle7({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle7State createState() => _HomeScreenStyle7State();
}

class _HomeScreenStyle7State extends State<HomeScreenStyle7> {
  HomeStyle7Controller homeStyle1Controller = HomeStyle7Controller();
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_scrollController.position.pixels <= 0) {
          isHide(false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isHide(true);
      }
    });

    configController.addButton(context);
  }

  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  var isHide = false.obs;
  SliverPersistentHeader makeHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 55.0,
        maxHeight: 55.0,
        child: Container(
          padding:
              const EdgeInsets.only(left: 15.0, right: 5, top: 5, bottom: 5),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  try {
                    globalKey.currentState!.openDrawer();
                  } catch (e) {
                    print(e.toString());
                  }

                  print('abc');
                },
                child: SizedBox(
                    child: SvgPicture.asset(
                  "packages/sahashop_customer/assets/style_7/fluent_list.svg",
                  width: 24,
                  height: 24,
                  color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => CategoryProductScreen(
                          autoSearch: true,
                        ));
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 25,
                        ),
                        Text(
                          "Tìm kiếm trong cửa hàng",
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(
                () => isHide.value
                    ? Row(
                        children: [
                          b.Badge(
                            badgeStyle: b.BadgeStyle(
                              padding: EdgeInsets.all(4),
                            ),
                            position: b.BadgePosition.custom(
                              end: -3,
                              top: -6,
                            ),
                            badgeContent: Text(
                              '${dataAppCustomerController.badge.value.chatsUnread}',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            showBadge: dataAppCustomerController
                                            .badge.value.chatsUnread ==
                                        0 ||
                                    dataAppCustomerController
                                            .badge.value.chatsUnread ==
                                        null
                                ? false
                                : true,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => AllPersonChatLockScreen());
                              },
                              child: SvgPicture.asset(
                                "packages/sahashop_customer/assets/style_7/chat.svg",
                                width: 24,
                                height: 24,
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          b.Badge(
                            badgeStyle: b.BadgeStyle(
                              padding: EdgeInsets.all(4),
                            ),
                            position: b.BadgePosition.custom(
                              end: -3,
                              top: -6,
                            ),
                            badgeContent: Text(
                              '${dataAppCustomerController.badge.value.notificationUnread}',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            showBadge: dataAppCustomerController
                                            .badge.value.notificationUnread ==
                                        0 ||
                                    dataAppCustomerController
                                            .badge.value.notificationUnread ==
                                        null
                                ? false
                                : true,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => NotificationCusScreen());
                              },
                              child: SvgPicture.asset(
                                "packages/sahashop_customer/assets/style_7/noti.svg",
                                width: 24,
                                height: 24,
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          key: globalKey,
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${dataAppCustomerController.badge.value.storeName ?? "Xin chào !"}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => CategoryProductScreen(
                            autoSearch: true,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]!),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 25,
                            ),
                            Text(
                              "Tìm kiếm trong cửa hàng",
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...listLayout(),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await homeStyle1Controller.refresh();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverFixedExtentList(
                  itemExtent: 50,
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${dataAppCustomerController.badge.value.storeName ?? "Xin chào !"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Obx(
                              () => isHide.value
                                  ? Container()
                                  : Row(
                                      children: [
                                        b.Badge(
                                          badgeStyle: b.BadgeStyle(
                                            padding: EdgeInsets.all(4),
                                          ),
                                          position: b.BadgePosition.custom(
                                            end: -3,
                                            top: -6,
                                          ),
                                          badgeContent: Text(
                                            '${dataAppCustomerController.badge.value.chatsUnread}',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                          showBadge: dataAppCustomerController
                                                          .badge
                                                          .value
                                                          .chatsUnread ==
                                                      0 ||
                                                  dataAppCustomerController
                                                          .badge
                                                          .value
                                                          .chatsUnread ==
                                                      null
                                              ? false
                                              : true,
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  AllPersonChatLockScreen());
                                            },
                                            child: SvgPicture.asset(
                                              "packages/sahashop_customer/assets/style_7/chat.svg",
                                              width: 24,
                                              height: 24,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        b.Badge(
                                          badgeStyle: b.BadgeStyle(
                                            padding: EdgeInsets.all(4),
                                          ),
                                          position: b.BadgePosition.custom(
                                            end: -3,
                                            top: -6,
                                          ),
                                          badgeContent: Text(
                                            '${dataAppCustomerController.badge.value.notificationUnread}',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                          showBadge: dataAppCustomerController
                                                          .badge
                                                          .value
                                                          .notificationUnread ==
                                                      0 ||
                                                  dataAppCustomerController
                                                          .badge
                                                          .value
                                                          .notificationUnread ==
                                                      null
                                              ? false
                                              : true,
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                      NotificationCusScreen())!
                                                  .then((value) => {
                                                        dataAppCustomerController
                                                            .getBadge()
                                                      });
                                            },
                                            child: SvgPicture.asset(
                                              "packages/sahashop_customer/assets/style_7/noti.svg",
                                              width: 24,
                                              height: 24,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                makeHeader(),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BannerWidget()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => homeStyle1Controller.isRefresh.value
                            ? HomeBodyWidget7()
                            : HomeBodyWidget7()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                heroTag: 'speed-dial-hero-tag1',
                backgroundColor: Colors.white,
                foregroundColor:
                    SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                elevation: 8.0,
                shape: CircleBorder(),
                children: configController.contactButton,
              )
            : Container(),
        ),
      ),
    );

    // Scaffold(
    //     backgroundColor: Colors.white,
    //     floatingActionButton: configController.contactButton.isNotEmpty
    //         ? SpeedDial(
    //             childMargin: EdgeInsets.only(bottom: 20, left: 18),
    //             icon: Icons.phone,
    //             activeIcon: Icons.read_more_sharp,
    //             visible: true,
    //             closeManually: false,
    //             renderOverlay: false,
    //             curve: Curves.bounceIn,
    //             overlayColor: Colors.grey[300],
    //             overlayOpacity: 0.5,
    //             onOpen: () => print('OPENING DIAL'),
    //             onClose: () => print('DIAL CLOSED'),
    //             heroTag: 'speed-dial-hero-tag1',
    //             backgroundColor: Colors.white,
    //             foregroundColor:
    //                 SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
    //             elevation: 8.0,
    //             shape: CircleBorder(),
    //             children: configController.contactButton,
    //           )
    //         : Container(),
    //     body: Stack(
    //       children: [
    //         Column(
    //   children: [
    //     Container(
    //       height: MediaQuery.of(context).padding.top,
    //       color: Theme.of(context).primaryColor,
    //     ),
    //     Expanded(
    //       child: Obx(
    //         () => RefreshIndicator(
    //           color: Colors.indigo,
    //           onRefresh: () async {
    //             await homeStyle1Controller.refresh();
    //           },
    //           child: SingleChildScrollView(
    //             padding: EdgeInsets.zero,
    //             controller: _scrollController,
    //             physics: const ClampingScrollPhysics(),
    //             child: Column(
    //               children: [
    //                 Stack(
    //                   clipBehavior: Clip.none,
    //                   children: [
    //                     BannerWidget(),
    //                     Positioned(
    //                       bottom: -30,
    //                       left: 0,
    //                       right: 0,
    //                       child: Container(
    //                         padding:
    //                             EdgeInsets.only(left: 20, right: 20),
    //                         child: Card(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(12.0),
    //                             child: Row(
    //                               children: [
    //                                 InkWell(
    //                                   onTap: () {
    //                                     Get.to(QRScreen());
    //                                   },
    //                                   child: SvgPicture.asset(
    //                                     "packages/sahashop_customer/assets/svg/qr-code-scan.svg",
    //                                     height: 30,
    //                                     width: 30,
    //                                     color: Colors.grey,
    //                                   ),
    //                                 ),
    //                                 VerticalDivider(
    //                                   color: Colors.grey,
    //                                   width: 10,
    //                                 ),
    //                                 dataAppCustomerController
    //                                             .infoCustomer.value ==
    //                                         null
    //                                     ? Container()
    //                                     : Container(
    //                                         child: Text(
    //                                           "${dataAppCustomerController.infoCustomer.value.name ?? "Xin chào"}",
    //                                           style: TextStyle(
    //                                               color:
    //                                                   Colors.black87),
    //                                         ),
    //                                       ),
    //                                 Spacer(),
    //                                 VerticalDivider(
    //                                   color: Colors.grey,
    //                                   width: 2,
    //                                 ),
    //                                 InkWell(
    //                                   onTap: () {
    //                                     Get.to(() => MemberScreen());
    //                                   },
    //                                   child: dataAppCustomerController
    //                                               .infoCustomer.value !=
    //                                           null
    //                                       ? Container(
    //                                           child: Row(
    //                                             children: [
    //                                               Column(
    //                                                 crossAxisAlignment:
    //                                                     CrossAxisAlignment
    //                                                         .start,
    //                                                 children: [
    //                                                   Row(
    //                                                     children: [
    //                                                       Image.asset(
    //                                                         "packages/sahashop_customer/assets/style1/money.png",
    //                                                         height: 13,
    //                                                         width: 13,
    //                                                         color: Colors
    //                                                             .amber,
    //                                                       ),
    //                                                       SizedBox(
    //                                                         width: 5,
    //                                                       ),
    //                                                       Text(
    //                                                         "${SahaStringUtils().convertToMoney(dataAppCustomerController.badge.value.customerPoint ?? 0)} điểm",
    //                                                         style: TextStyle(
    //                                                             fontSize:
    //                                                                 12),
    //                                                       )
    //                                                     ],
    //                                                   ),
    //                                                   SizedBox(
    //                                                     height: 2,
    //                                                   ),
    //                                                   Text(
    //                                                     "Săn điểm ngay",
    //                                                     style: TextStyle(
    //                                                         color: Colors
    //                                                             .grey,
    //                                                         fontSize:
    //                                                             12),
    //                                                   )
    //                                                 ],
    //                                               ),
    //                                               SizedBox(
    //                                                 width: 5,
    //                                               ),
    //                                               Icon(
    //                                                 Icons
    //                                                     .arrow_forward_ios_rounded,
    //                                                 color: Colors.grey,
    //                                                 size: 12,
    //                                               )
    //                                             ],
    //                                           ),
    //                                         )
    //                                       : Row(children: [
    //                                           Text(
    //                                             "Tích điểm",
    //                                             style: TextStyle(
    //                                                 color: Colors.grey),
    //                                           ),
    //                                           Icon(
    //                                             Icons
    //                                                 .arrow_forward_ios_rounded,
    //                                             color: Colors.grey,
    //                                             size: 12,
    //                                           )
    //                                         ]),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 if (dataAppCustomerController.homeData.value
    //                             .bannerAdsApp?.position0 !=
    //                         null &&
    //                     dataAppCustomerController.homeData.value
    //                         .bannerAdsApp!.position0!.isNotEmpty)
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                 if (dataAppCustomerController.homeData.value
    //                             .bannerAdsApp?.position0 !=
    //                         null &&
    //                     dataAppCustomerController.homeData.value
    //                         .bannerAdsApp!.position0!.isNotEmpty)
    //                   bannerAdsItem(dataAppCustomerController
    //                       .homeData.value.bannerAdsApp!.position0!),
    //                 Column(
    //                   children: [
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     Obx(() => homeStyle1Controller.isRefresh.value
    //                         ? HomeBodyWidget()
    //                         : HomeBodyWidget()),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
    // Obx(
    //   () => AnimatedContainer(
    //     duration: const Duration(microseconds: 250),
    //     height: 100,
    //     width: double.infinity,
    //     color: Theme.of(context)
    //         .primaryColor
    //         .withOpacity(homeStyle1Controller.opacity.value),
    //     padding: const EdgeInsets.fromLTRB(0, 40, 10, 0),
    //     child: SearchBarType1(
    //       onSearch: () {
    //         Get.to(CategoryProductScreen(
    //           autoSearch: true,
    //         ));
    //       },
    //     ),
    //   ),
    // ),
    //   ],
    // ));
  }

  List<Widget> listLayout() {
    List<Widget> list = [];
    if (dataAppCustomerController.homeData.value.listLayout != null) {
      for (var layout in dataAppCustomerController.homeData.value.listLayout!) {
        list.add(layout.model != "Category"
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (layout.model == "Category")
                    ...layout.list!.cast<Category>().map((e) => InkWell(
                          onTap: () {
                            ActionTap.onTap(
                              typeAction:
                                  mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT],
                              value: e.id.toString(),
                            );
                            try {
                              globalKey.currentState!.closeDrawer();
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      imageUrl: e.imageUrl ?? "",
                                      errorWidget: (context, url, error) =>
                                          SahaEmptyImage(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    (e.name ?? "").toUpperCase(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                ],
              ));
      }
    }
    return list;
  }
}
