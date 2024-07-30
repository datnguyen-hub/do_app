import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/add_community_post/add_community_post_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/comment/comment_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../components/empty/saha_empty_avatar.dart';
import '../../components/widget/image_post.dart';
import '../../const/community.dart';
import '../login/check_login/check_login.dart';
import 'community_controller.dart';
import 'profile/profile_screen.dart';

class CommunityLockScreen extends StatelessWidget {
  bool? showIconBack;
  CommunityLockScreen({this.showIconBack});
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
        child: CommunityScreen(showIconBack: showIconBack));
  }
}

class CommunityScreen extends StatefulWidget {
  bool? showIconBack;
  CommunityScreen({this.showIconBack});
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  RefreshController refreshController = RefreshController();
  CommunityController communityController = CommunityController();
  bool show_more = true;

  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: widget.showIconBack == true ? true : false,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        elevation: 0,
        title: Text(
          "Cộng đồng ${dataAppCustomerController.badge.value.storeName ?? ""}",
        ),
      ),
      body: Obx(
        () => communityController.isLoading.value
            ? SahaLoadingFullScreen()
            : communityController.listCommunityPost.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        boxProfile(),
                        Expanded(
                          child: Center(child: Text("Chưa có bài đăng nào")),
                        ),
                      ],
                    ),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => communityController.isLoading.value
                              ? CupertinoActivityIndicator()
                              : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        }
                        return Container(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await communityController.getAllCommunityPost(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await communityController.getAllCommunityPost();
                      refreshController.loadComplete();
                    },
                    child: ListView(
                      children: [
                        boxProfile(),
                        SizedBox(
                          height: 10,
                        ),
                        ...communityController.listCommunityPost.map((e) {
                          return itemPost(communityPost: e);
                        }).toList()
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget boxProfile() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => ProfileCommunityScreen(
                        customerId:
                            dataAppCustomerController.infoCustomer.value.id,
                      ))!
                  .then((value) => {
                        communityController.getAllCommunityPost(isRefresh: true)
                      });
            },
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: dataAppCustomerController
                          .infoCustomer.value.avatarImage ??
                      "",
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => SahaEmptyAvata(
                    sizeIcon: 20,
                  ),
                )),
          ),
          Container(
            width: Get.width / 1.4,
            child: InkWell(
              onTap: () {
                Get.to(() => AddCommunityPostSceen())!.then((value) =>
                    {communityController.getAllCommunityPost(isRefresh: true)});
              },
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Bạn đang nghĩ gì?',
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
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => AddCommunityPostSceen(
                        isUpImage: true,
                      ))!
                  .then((value) => {
                        communityController.getAllCommunityPost(isRefresh: true)
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ProfileCommunityScreen(
                                      customerId: communityPost.customerId,
                                    ))!
                                .then((value) => {
                                      communityController.getAllCommunityPost(
                                          isRefresh: true)
                                    });
                          },
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    communityPost.customer?.avatarImage ?? "",
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    SahaEmptyAvata(
                                  sizeIcon: 20,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => ProfileCommunityScreen(
                                          customerId: communityPost.customerId,
                                        ))!
                                    .then((value) => {
                                          communityController
                                              .getAllCommunityPost(
                                                  isRefresh: true)
                                        });
                              },
                              child: Text.rich(TextSpan(
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
                                        feelCommunity[int.parse(
                                                communityPost.feeling!)]
                                            .icon,
                                        size: 16,
                                      )),
                                  ])),
                            ),
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
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          if (dataAppCustomerController.infoCustomer.value.id ==
                              communityPost.customer?.id)
                            InkWell(
                              onTap: () {
                                Get.to(() => AddCommunityPostSceen(
                                          communityPostInput: communityPost,
                                        ))!
                                    .then((value) => {
                                          communityController
                                              .getAllCommunityPost(
                                                  isRefresh: true)
                                        });
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.black54,
                                size: 25,
                              ),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (dataAppCustomerController
                                      .infoCustomer.value.id ==
                                  communityPost.customer?.id) {
                                SahaDialogApp.showDialogYesNo(
                                    mess: "Bạn có chắc muốn xoá bài viết?",
                                    onOK: () {
                                      communityController.deleteCommunityPost(
                                          communityPostId: communityPost.id!);
                                    });
                              } else {
                                communityController.listCommunityPost
                                    .remove(communityPost);
                              }
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.black54,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    communityPost.backgroundColor != null
                        ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            communityPost.content ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                        : 
                        communityPost.content != null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: 
                                ReadMoreText(
                                  communityPost.content ?? '',
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
                            : SizedBox(),
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
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => CommentsScreen(
                            communityPost: communityPost,
                          ),
                        )!
                            .then((value) => {
                                  communityController
                                      .getCommunityPost(communityPost.id!)
                                });
                      },
                      child: Text(
                        '${communityPost.totalComment} bình luận',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
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
                    InkWell(
                      onTap: () {
                        communityController.likePost(
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
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => CommentsScreen(
                            communityPost: communityPost,
                          ),
                        )!
                            .then((value) => {
                                  communityController
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
}
