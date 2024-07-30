import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/components/widget/image_post.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/add_community_post/add_community_post_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/comment/comment_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/profile/profile_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../components/loading/loading_container.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../const/community.dart';
import '../../../model/info_customer.dart';
import '../../chat_customer_screen/all_person_chat/person_chat/person_chat_screen.dart';
import 'friends_list/friends_list_screen.dart';

class ProfileCommunityScreen extends StatelessWidget {
  late PersonalCommunityPostController personalCommunityController;
  DataAppCustomerController dataAppCustomerController = Get.find();

  ProfileCommunityScreen({required this.customerId}) {
    personalCommunityController =
        PersonalCommunityPostController(customerId: customerId!);
  }

  int? customerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      body: Obx(
        () => personalCommunityController.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  bottom: 50,
                                ),
                                margin: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: personalCommunityController
                                          .communityCustomerProfile
                                          .value
                                          .customer
                                          ?.avatarImage ??
                                      "",
                                  height: 200,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      SahaLoadingContainer(),
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(Get.context!)
                                            .primaryColor)),
                                padding: EdgeInsets.all(5),
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: personalCommunityController
                                            .communityCustomerProfile
                                            .value
                                            .customer
                                            ?.avatarImage ??
                                        "",
                                    width: Get.width / 2,
                                    height: Get.width / 2,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SahaLoadingContainer(),
                                    errorWidget: (context, url, error) =>
                                        SahaEmptyAvata(
                                      sizeIcon: 150,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(3000),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              '${personalCommunityController.communityCustomerProfile.value.customer?.name ?? ""}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          if (personalCommunityController
                                  .communityCustomerProfile
                                  .value
                                  .customer
                                  ?.id !=
                              dataAppCustomerController.infoCustomer.value.id)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          if (personalCommunityController
                                                  .communityCustomerProfile
                                                  .value
                                                  .isFriend ==
                                              true) {
                                            SahaDialogApp.showDialogYesNo(
                                                mess:
                                                    "Bạn chắn chắn muốn huỷ kết bạn với ${personalCommunityController.communityCustomerProfile.value.customer?.name ?? ""}?",
                                                onOK: () {
                                                  personalCommunityController
                                                      .deleteFriend(
                                                          toCustomerId:
                                                              personalCommunityController
                                                                      .communityCustomerProfile
                                                                      .value
                                                                      .customer
                                                                      ?.id ??
                                                                  0);
                                                });
                                          } else if (personalCommunityController
                                                  .communityCustomerProfile
                                                  .value
                                                  .sentFriendRequest ==
                                              true) {
                                            SahaDialogApp.showDialogYesNo(
                                                mess: 'Huỷ lởi mời kết bạn ?',
                                                onOK: () async {
                                                  personalCommunityController
                                                      .deleteFriendRequest(
                                                          personalCommunityController
                                                                  .communityCustomerProfile
                                                                  .value
                                                                  .customer
                                                                  ?.id ??
                                                              0);
                                                });
                                          } else {
                                            personalCommunityController.addFriend(
                                                personalCommunityController
                                                        .communityCustomerProfile
                                                        .value
                                                        .customer
                                                        ?.id ??
                                                    0);
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                personalCommunityController
                                                            .communityCustomerProfile
                                                            .value
                                                            .isFriend ==
                                                        true
                                                    ? Icons.person_rounded
                                                    : personalCommunityController
                                                                .communityCustomerProfile
                                                                .value
                                                                .sentFriendRequest ==
                                                            true
                                                        ? Icons
                                                            .person_remove_rounded
                                                        : Icons
                                                            .person_add_alt_1_rounded,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                personalCommunityController
                                                            .communityCustomerProfile
                                                            .value
                                                            .isFriend ==
                                                        true
                                                    ? '  Bạn bè'
                                                    : personalCommunityController
                                                                .communityCustomerProfile
                                                                .value
                                                                .sentFriendRequest ==
                                                            true
                                                        ? '  Huỷ lời mời'
                                                        : '  Thêm bạn bè',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (personalCommunityController
                                                .communityCustomerProfile
                                                .value
                                                .sentFriendRequest ==
                                            true ||
                                        personalCommunityController
                                                .communityCustomerProfile
                                                .value
                                                .isFriend ==
                                            true)
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => PersonChatScreen(
                                                  infoCustomerChat:
                                                      personalCommunityController
                                                          .communityCustomerProfile
                                                          .value
                                                          .customer!,
                                                ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.chat_bubble_rounded,
                                                ),
                                                Text(
                                                  '  Nhắn tin',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                if (personalCommunityController
                                        .communityCustomerProfile
                                        .value
                                        .isFriend !=
                                    true)
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[350],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.chat_bubble_rounded,
                                        ),
                                        Text(
                                          '  Nhắn tin',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Text(
                              'Bạn bè ${personalCommunityController.communityCustomerProfile.value.totalFriends == null ? "" : "(${personalCommunityController.communityCustomerProfile.value.totalFriends})"}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 5,
                            children: [
                              ...List.generate(
                                personalCommunityController.listFriend.length >=
                                        6
                                    ? 6
                                    : personalCommunityController
                                        .listFriend.length,
                                (index) => friends(
                                  infoCustomer: personalCommunityController
                                      .listFriend[index],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => FriendsListScreen(
                                        customerId: personalCommunityController
                                            .customerId,
                                      ))!
                                  .then((value) => personalCommunityController
                                      .getAllFriend(isRefresh: true));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(
                                child: Text(
                                  'Xem tất cả bạn bè',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (dataAppCustomerController.infoCustomer.value.id ==
                        personalCommunityController
                            .communityCustomerProfile.value.customer?.id)
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bài Viết',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15, bottom: 10),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => AddCommunityPostSceen())!.then(
                                      (value) => {
                                            personalCommunityController
                                                .getPostCommunity(
                                                    isRefresh: true)
                                          });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            imageUrl: dataAppCustomerController
                                                    .infoCustomer
                                                    .value
                                                    .avatarImage ??
                                                "",
                                            height: 35,
                                            width: 35,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SahaEmptyAvata(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Bạn đang nghĩ gì?',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => AddCommunityPostSceen(
                                                  isUpImage: true,
                                                ))!
                                            .then((value) => {
                                                  personalCommunityController
                                                      .getPostCommunity(
                                                          isRefresh: true)
                                                });
                                      },
                                      child: Icon(
                                        Icons.collections_rounded,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    ...personalCommunityController.listPersonalCommunity
                        .map((e) {
                      return itemPost(communityPost: e);
                    }).toList()
                  ],
                ),
              ),
      ),
    );
  }

  Widget itemPost({required CommunityPost communityPost}) {
    String getName() {
      if (communityPost.customer?.name != null)
        return communityPost.customer!.name!;
      if (communityPost.staff?.name != null) return communityPost.staff!.name!;
      if (communityPost.user?.name != null) return communityPost.user!.name!;
      return '';
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: communityPost.customer?.avatarImage ?? "",
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              SahaEmptyAvata(),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: getName(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <InlineSpan>[
                                if (communityPost.feeling != null)
                                  TextSpan(
                                      text:
                                          '  đang cảm thấy ${feelCommunity[int.parse(communityPost.feeling!)].name}  ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300)),
                                if (communityPost.feeling != null)
                                  WidgetSpan(
                                      child: Icon(
                                    feelCommunity[
                                            int.parse(communityPost.feeling!)]
                                        .icon,
                                    size: 16,
                                  )),
                              ])),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              communityPost.createdAt != null
                                  ? Text(
                                      "${SahaStringUtils().displayTimeAgoFromTime(communityPost.createdAt ?? DateTime.now())}",
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  right: 2,
                                ),
                                child: Icon(
                                  Icons.fiber_manual_record_rounded,
                                  size: 5,
                                  color: Colors.black54,
                                ),
                              ),
                              Icon(
                                Icons.public_rounded,
                                size: 15,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (dataAppCustomerController.infoCustomer.value.id ==
                        communityPost.customer?.id)
                      InkWell(
                        onTap: () {
                          Get.to(() => AddCommunityPostSceen(
                                    communityPostInput: communityPost,
                                  ))!
                              .then((value) => {
                                    personalCommunityController
                                        .getPostCommunity(isRefresh: true)
                                  });
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    SizedBox(
                      width: 20,
                    ),
                    if (dataAppCustomerController.infoCustomer.value.id ==
                        communityPost.customer?.id)
                      InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn có chắc muốn xoá bài viết?",
                              onOK: () {
                                personalCommunityController.deleteCommunityPost(
                                    communityPostId: communityPost.id!);
                              });
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    communityPost.backgroundColor != null
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                communityPost.backgroundColor ?? "",
                                fit: BoxFit.fill,
                              ),
                              Text(
                                communityPost.content ?? "",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        : communityPost.content != null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ReadMoreText(
                                  communityPost.content.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  trimLength: 150,
                                  trimCollapsedText: 'Xem thêm',
                                  trimExpandedText: "Ẩn bớt",
                                  lessStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  moreStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                ),
                              )
                            : Container(),
                  ],
                ),
              ),
              ImagePost(
                listImageUrl: communityPost.images ?? [],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidThumbsUp,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${communityPost.totalLike}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            '${communityPost.totalComment} bình luận',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //     left: 3,
                          //     right: 3,
                          //   ),
                          //   child: Icon(
                          //     Icons.fiber_manual_record_rounded,
                          //     size: 6,
                          //     color: Colors.black54,
                          //   ),
                          // ),
                          // Text(
                          //   '${communityPost.sh} chia sẻ',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.black54,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Divider(
                  height: 1,
                  color: Colors.black26,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        personalCommunityController.likePost(
                            communityPostId: communityPost.id!,
                            isLike:
                                communityPost.isLike == true ? false : true);
                      },
                      child: Row(
                        children: [
                          communityPost.isLike != true
                              ? Icon(
                                  FontAwesomeIcons.thumbsUp,
                                  color: Colors.black54,
                                  size: 20,
                                )
                              : Icon(
                                  FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                          SizedBox(
                            width: 5,
                          ),
                          communityPost.isLike != true
                              ? Text(
                                  'Thích',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                )
                              : Text(
                                  'Thích',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => CommentsScreen(
                            communityPost: communityPost,
                          ),
                        )!
                            .then((value) => {
                                  personalCommunityController
                                      .getCommunityPost(communityPost.id!)
                                });
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.comment,
                            color: Colors.black54,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Bình luận',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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

  Widget friends({InfoCustomer? infoCustomer}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          Get.context!,
          MaterialPageRoute(
              builder: (context) => ProfileCommunityScreen(
                    customerId: infoCustomer!.id,
                  )),
        );
      },
      child: Container(
        width: (Get.width - 20) / 3,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  width: (Get.width - 20) / 3,
                  imageUrl: infoCustomer?.avatarImage ?? "",
                  placeholder: (context, url) => new SahaLoadingWidget(
                    size: 20,
                  ),
                  errorWidget: (context, url, error) => Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 50,
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  infoCustomer?.name ?? "",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
