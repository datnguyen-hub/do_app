import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/chat/all_person_chat_res.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_container.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../config_controller.dart';
import '../../../model/info_customer.dart';
import '../../../utils/string_utils.dart';
import '../../login/check_login/check_login.dart';
import '../chat_user_screen.dart';
import 'all_person_chat_controller.dart';
import 'person_chat/person_chat_screen.dart';

class AllPersonChatLockScreen extends StatelessWidget {
  bool? showIconBack;
  AllPersonChatLockScreen({this.showIconBack});
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: AllPersonChatScreen());
  }
}

// ignore: must_be_immutable
class AllPersonChatScreen extends StatefulWidget {
  @override
  State<AllPersonChatScreen> createState() => _AllPersonChatScreenState();
}

class _AllPersonChatScreenState extends State<AllPersonChatScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController searchEditingController = TextEditingController();

  AllPersonChatController allPersonChatController =
      Get.put(AllPersonChatController());
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => allPersonChatController.isSearch.value
              ? Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: searchEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(right: 15, top: 15, bottom: 10),
                      border: InputBorder.none,
                      hintText: "Tìm kiếm",
                      suffixIcon: IconButton(
                        onPressed: () {
                          allPersonChatController.textSearch = "";
                          allPersonChatController.getPersonChat(
                              isRefresh: true);
                          searchEditingController.clear();
                        },
                        icon: Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    onChanged: (v) async {
                      allPersonChatController.textSearch = v;
                      allPersonChatController.getPersonChat(isRefresh: true);
                    },
                    minLines: 1,
                    maxLines: 1,
                  ),
                )
              : Text(
                  'Chat',
                ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (allPersonChatController.isSearch.value == false) {
                  allPersonChatController.isSearch.value = true;
                } else {
                  allPersonChatController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: Obx(
        () => allPersonChatController.loadInit.value
            ? SahaLoadingFullScreen()
            : allPersonChatController.listPerson.isEmpty
                ? itemUser(PersonChat(
                    lastMess: 'Liên hệ ngay',
                    toCustomer: InfoCustomer(
                      name: '${StoreInfo().name ?? ""}',
                      avatarImage:
                          "${Get.find<CustomerConfigController>().configApp.logoUrl ?? ""}",
                    )))
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget? body;
                        if (mode == LoadStatus.idle) {
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("Đã hết User");
                        } else {
                          body = Text("Đã xem hết User");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: () async {
                      await allPersonChatController.getPersonChat(
                          isRefresh: true);
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await allPersonChatController.getPersonChat();
                      _refreshController.loadComplete();
                    },
                    child: ListView(
                      children: [
                        itemUser(PersonChat(
                            lastMess: 'Liên hệ ngay',
                            toCustomer: InfoCustomer(
                                name: 'Admin',
                                avatarImage:
                                    'https://ikitech.vn/wp-content/uploads/2020/07/logoikitech-copy-300x132.png'))),
                        ...allPersonChatController.listPerson
                            .map((e) => itemChatUser(e))
                            .toList(),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget itemChatUser(PersonChat personChat) {
    return InkWell(
      onTap: () {
        if (personChat.toCustomer != null)
          Get.to(() => PersonChatScreen(
                    infoCustomerChat: personChat.toCustomer!,
                  ))!
              .then((value) =>
                  {allPersonChatController.getPersonChat(isRefresh: true)});
      },
      child: Column(
        children: [
          Slidable(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: personChat.toCustomer?.avatarImage ?? "",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SahaLoadingContainer(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                        borderRadius: BorderRadius.circular(3000),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            personChat.toCustomer?.name ?? "Chưa đặt tên",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(
                              personChat.lastMess ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    right: 10,
                    top: 0,
                    child: Row(
                      children: [
                        Text(
                          SahaStringUtils().displayTimeAgoFromTime(
                              personChat.updatedAt ?? DateTime.now()),
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[400]),
                        ),
                        if (personChat.seen != true)
                          SizedBox(
                            width: 10,
                          ),
                        if (personChat.seen != true)
                          Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 12,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget itemUser(PersonChat personChat) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatCustomerScreen())!.then((value) {
          allPersonChatController.getPersonChat(isRefresh: true);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Scrollable(
            controller: scrollController,
            viewportBuilder: (context, position) => Slidable(
              direction: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: personChat.toCustomer?.avatarImage ?? "",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                          borderRadius: BorderRadius.circular(3000),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              personChat.toCustomer?.name ?? "Chưa đặt tên",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(
                                personChat.lastMess ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      child: Text(
                        SahaStringUtils().displayTimeAgoFromTime(
                            personChat.updatedAt ?? DateTime.now()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
