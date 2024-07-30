import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/model/comment_community.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/comment/comment_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/comment/update_comment/update_comment_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class CommentsScreen extends StatelessWidget {
  RefreshController refreshController = RefreshController();
  late CommentCommunityController commentCommunityController;
  CommunityPost communityPost;

  CommentsScreen({required this.communityPost}) {
    commentCommunityController =
        CommentCommunityController(communityPost: communityPost);
  }

  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        height: Get.height / 1.25,
        child: SmartRefresher(
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
                body = Obx(() => commentCommunityController.isLoading.value
                    ? CupertinoActivityIndicator(
                        color: Colors.red,
                      )
                    : Container());
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator(
                  color: Colors.red,
                );
              }
              return Container(
                height: 50,
                child: Center(child: body),
              );
            },
          ),
          controller: refreshController,
          onRefresh: () async {
            await commentCommunityController.getAllCommentCommunity(
                isRefresh: true);
            refreshController.refreshCompleted();
          },
          onLoading: () async {
            await commentCommunityController.getAllCommentCommunity();
            refreshController.loadComplete();
          },
          child: Obx(
            () => Container(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      InkWell(
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
                              communityPost.totalLike != null
                                  ? communityPost.totalLike.toString()
                                  : "",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...commentCommunityController.listCommentCommunity
                          .map((e) {
                        return comment(commentPost: e);
                      }).toList()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                controller:
                    commentCommunityController.contentCommentCommunityPost,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  hintText: 'Viết bình luận...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
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
            SizedBox(
              width: 10,
            ),
            Container(
              width: 30,
              height: 30,
              child: InkWell(
                onTap: () {
                  commentCommunityController
                      .addCommentCommunityPost(
                        communityPostId: communityPost.id!,
                        content: commentCommunityController
                            .contentCommentCommunityPost.value.text,
                      )
                      .then((value) => commentCommunityController
                          .getAllCommentCommunity(isRefresh: true));
                  FocusScope.of(context).unfocus();
                  commentCommunityController.contentCommentCommunityPost
                      .clear();
                },
                child: Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comment({required CommentPost commentPost}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: CommentTreeWidget<Comment, Comment>(
        Comment(
            avatar: "",
            userName: commentPost.customer?.name != null
                ? commentPost.customer?.name
                : "",
            content: commentPost.content != null ? commentPost.content : ""),
        [],
        treeThemeData:
            TreeThemeData(lineColor: Colors.grey.shade300, lineWidth: 2),
        avatarRoot: (context, data) => PreferredSize(
          preferredSize: Size.fromRadius(18),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              imageUrl: commentPost.customer?.avatarImage ?? "",
              placeholder: (context, url) => new SahaLoadingContainer(),
              errorWidget: (context, url, error) => new SahaEmptyAvata(),
            ),
          ),
        ),
        avatarChild: (context, data) => PreferredSize(
          preferredSize: Size.fromRadius(15),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC5Y3JA-sPcOe2N3PqtJWV1paJ7vLAhurs7Q&usqp=CAU",
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
        ),
        contentRoot: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${data.userName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (dataAppCustomerController.infoCustomer.value.id ==
                            commentPost.customer?.id)
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0)),
                                  ),
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      height: Get.height / 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Get.width / 5,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: Colors.black54),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  SahaDialogApp.showDialogYesNo(
                                                      mess:
                                                          "Bạn có chắc muốn xoá bình luận",
                                                      onOK: () {
                                                        commentCommunityController
                                                            .deleteCommentCommunityPost(
                                                                id: commentPost
                                                                    .id!);
                                                        Get.back();
                                                      });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.trashCan,
                                                      size: 25,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Xoá ',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                          UpdateCommentScreen(
                                                            commentPost:
                                                                commentPost,
                                                          ))!
                                                      .then((value) => {
                                                            commentCommunityController
                                                                .getAllCommentCommunity(
                                                                    isRefresh:
                                                                        true)
                                                          });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .penToSquare,
                                                      size: 25,
                                                      color: Colors.indigo,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Chỉnh sửa',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.more_horiz_rounded,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    ReadMoreText(
                      '${data.content}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      trimLength: 100,
                      trimCollapsedText: 'Xem thêm',
                      trimExpandedText: "Ẩn bớt",
                      lessStyle: TextStyle(color: Colors.grey.shade700),
                      moreStyle: TextStyle(color: Colors.grey.shade700),
                    )
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
                  child: Text(
                      '${SahaStringUtils().displayTimeAgoFromTime(commentPost.createdAt ?? DateTime.now())}'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
