import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/friend_request.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import '../profile_screen.dart';
import 'friends_list_controller.dart';

class FriendsListScreen extends StatelessWidget {
  TextEditingController searchEditingController = TextEditingController();
  late FriendsListController friendsListController;
  int? customerId;
  FriendsListScreen({required this.customerId}) {
    friendsListController = FriendsListController(customerId: customerId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Danh sách bạn bè',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: searchEditingController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Tìm kiếm bạn bè ?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                      bottom: 10,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        friendsListController.textSearch = "";
                        friendsListController.getAllFriends(isRefresh: true);
                        searchEditingController.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) async {
                    friendsListController.textSearch = v;
                    friendsListController.getAllFriends(isRefresh: true);
                  },
                ),
              ),
              friendsListController.listFriendRequest.length == 0
                  ? Container()
                  : Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Danh sách kết bạn',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...List.generate(
                            friendsListController.listFriendRequest.length >= 6
                                ? 6
                                : friendsListController
                                    .listFriendRequest.length,
                            (index) => friendRequest(
                              friendRequest: friendsListController
                                  .listFriendRequest[index],
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bạn bè',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ...friendsListController.listFriend.map((e) {
                      return listFriends(infoCustomer: e);
                    }).toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listFriends({InfoCustomer? infoCustomer}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              Get.context!,
              MaterialPageRoute(
                  builder: (context) => ProfileCommunityScreen(
                        customerId: infoCustomer!.id,
                      )),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: infoCustomer?.avatarImage ?? "",
                      placeholder: (context, url) => new SahaLoadingWidget(
                        size: 20,
                      ),
                      errorWidget: (context, url, error) => new SahaEmptyAvata(
                        sizeIcon: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    infoCustomer?.name ?? "",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  SahaDialogApp.showDialogYesNo(
                      mess:
                          "Bạn chắn chắn muốn huỷ kết bạn với ${infoCustomer?.name}?",
                      onOK: () {
                        friendsListController
                            .deleteFriend(toCustomerId: infoCustomer!.id!)
                            .then((value) => friendsListController
                                .getFriendRequest(isRefresh: true));
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Huỷ kết bạn',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget friendRequest({required FriendRequest friendRequest}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: friendRequest.customer?.avatarImage ?? "",
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => SahaLoadingWidget(),
              errorWidget: (context, url, error) => SahaEmptyAvata(
                sizeIcon: 50,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friendRequest.customer?.name ?? "",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            friendsListController.handleFriendRequest(
                                requestId: friendRequest.id ?? 0, status: 1);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Chấp nhận',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            friendsListController.handleFriendRequest(
                                requestId: friendRequest.id!, status: 0);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Xoá',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
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
    );
  }
}
