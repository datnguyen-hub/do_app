import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/comment_community.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class CommentCommunityController extends GetxController {
  var listCommentCommunity = RxList<CommentPost>();
  var contentCommentCommunityPost = new TextEditingController(text: "");
  var commentCommunityPostRes = CommentPost().obs;
  CommunityPost communityPost;
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  bool? isNeedHanding;

  CommentCommunityController(
      {this.isNeedHanding, required this.communityPost}) {
    getAllCommentCommunity(isRefresh: true);
    contentCommentCommunityPost.text =
        commentCommunityPostRes.value.content ?? "";
  }

  Future<void> getAllCommentCommunity({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllCommentCommunity(
                currentPage: currentPage, communityPostId: communityPost.id!);

        if (isRefresh == true) {
          listCommentCommunity(data!.data!.data!);
          listCommentCommunity.refresh();
        } else {
          listCommentCommunity.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }

  Future<void> addCommentCommunityPost({
    required int communityPostId,
    required String content,
  }) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .addCommentCommunityPost(
        communityPostId: communityPostId,
        content: content,
      );
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteCommentCommunityPost({required int id}) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .deleteCommentCommunityPost(commentCommunityPostId: id);
      listCommentCommunity.removeWhere((e) => e.id == id);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
