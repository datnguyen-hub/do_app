import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as b;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/notification/notification_cus_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/search_bar_type/search_bar_type5.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../../screen_default/chat_customer_screen/all_person_chat/all_person_chat_screen.dart';
import 'home_style_6_controller.dart';
import 'widget/body.dart';

class HomeScreenStyle6 extends StatefulWidget {
  const HomeScreenStyle6({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle6State createState() => _HomeScreenStyle6State();
}

class _HomeScreenStyle6State extends State<HomeScreenStyle6> {
  final ScrollController _scrollController = ScrollController();
  final HomeStyle6Controller homeStyle6Controller = HomeStyle6Controller();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 1 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        homeStyle6Controller.isTouch.value = true;
      } else if (_scrollController.offset < 1 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        homeStyle6Controller.isTouch.value = false;
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
        backgroundColor: Colors.white,
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
                tooltip: 'Speed Dial',
                heroTag: 'speed-dial-hero-tag4',
                backgroundColor: Colors.white,
                foregroundColor:
                    SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                elevation: 8.0,
                shape: CircleBorder(),
                children: configController.contactButton,
              )
            : Container(),
        body: Stack(
          children: [
            backgroundDecoration(),
            Column(
              children: [
                Obx(
                  () => SizedBox(
                    height: homeStyle6Controller.isTouch.value ? 90 : 120,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => RefreshIndicator(
                      color: Colors.indigo,
                      onRefresh: () async {
                        await homeStyle6Controller.refresh();
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            BannerWidget(),
                            if (dataAppCustomerController.homeData.value
                                        .bannerAdsApp?.position0 !=
                                    null &&
                                dataAppCustomerController.homeData.value
                                    .bannerAdsApp!.position0!.isNotEmpty)
                              bannerAdsItem(dataAppCustomerController
                                  .homeData.value.bannerAdsApp!.position0!),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => homeStyle6Controller.isRefresh.value
                                ? HomeBodyWidget6()
                                : HomeBodyWidget6()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Get.to(() => MemberScreen());
              },
              child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        "Chào bạn ${dataAppCustomerController.infoCustomer.value.name ?? ""} !",
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(NotificationCusScreen())!.then((value) => {
                              dataAppCustomerController.getBadge(),
                            });
                      },
                      child: b.Badge(
                        badgeStyle: b.BadgeStyle(
                          padding: EdgeInsets.all(3),
                        ),
                        position: b.BadgePosition.custom(end: -4, top: -8),
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
                        child: SvgPicture.asset(
                          "packages/sahashop_customer/assets/icons/bell3.svg",
                          height: 25,
                          width: 25,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleLarge!
                              .color,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => AllPersonChatScreen());
                      },
                      child: Obx(
                        () => b.Badge(
                          badgeStyle: b.BadgeStyle(
                            padding: EdgeInsets.all(3),
                          ),
                          position: b.BadgePosition.custom(end: -4, top: -8),
                          badgeContent: Text(
                            '${dataAppCustomerController.badge.value.chatsUnread}',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                          showBadge: dataAppCustomerController
                                      .badge.value.chatsUnread ==
                                  0
                              ? false
                              : true,
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/chat_appbar.svg",
                            height: 25,
                            width: 25,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleLarge!
                                .color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                top: homeStyle6Controller.isTouch.value ? 40 : 80,
                height: 40,
                right: homeStyle6Controller.isTouch.value ? 80 : 10,
                left: 10,
                //width: Get.width,
                child: SearchBarType5(
                  onSearch: () {
                    Get.to(CategoryProductScreen(
                      autoSearch: true,
                    ));
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Widget backgroundDecoration() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 800,
            width: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.3),
                    Theme.of(context).primaryColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated),
            ),
          ),
        ),
        Positioned(
          top: 100,
          //left: -200,
          right: Get.width / 2,
          child: Container(
            height: 1000,
            width: 1000,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.05),
            ),
          ),
        ),
        Positioned(
          top: 200,
          right: 100,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.05),
            ),
          ),
        ),
        Positioned(
          top: 300,
          right: -200,
          left: 0,
          child: Container(
            height: 1000,
            width: 1000,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.05),
            ),
          ),
        ),
      ],
    );
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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
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
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
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
