import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/notification/notification_cus_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import '../../screen_default/data_app_controller.dart';
import '../chat_customer_screen/all_person_chat/all_person_chat_screen.dart';

// ignore: must_be_immutable
class SearchBarType1 extends StatelessWidget {
  Function? onSearch;
  DataAppCustomerController dataAppCustomerController = Get.find();
  SearchBarType1({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              onSearch!();
            },
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  color: Colors.grey[100]!),
              child: Row(
                children: [
                  Icon(Icons.search),
                  Expanded(
                    child: Text(
                      "Tìm kiếm",
                      style: TextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Obx(
              () => InkWell(
                onTap: () {
                  Get.to(() => NotificationCusScreen())!
                      .then((value) => {dataAppCustomerController.getBadge()});
                },
                child: b.Badge(
                  badgeStyle: b.BadgeStyle(
                    padding: EdgeInsets.all(3),
                  ),
                  position: b.BadgePosition.custom(end: 0, top: -5),
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
                  child: Container(
                    padding: EdgeInsets.all(12),
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "packages/sahashop_customer/assets/icons/bell2.svg",
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    ),
                  ),
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
              child: b.Badge(
                badgeStyle: b.BadgeStyle(
                  padding: EdgeInsets.all(3),
                ),
                position: b.BadgePosition.custom(end: 0, top: -5),
                badgeContent: Text(
                  '${dataAppCustomerController.badge.value.chatsUnread}',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
                showBadge:
                    dataAppCustomerController.badge.value.chatsUnread == 0
                        ? false
                        : true,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "packages/sahashop_customer/assets/icons/chat.svg",
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
