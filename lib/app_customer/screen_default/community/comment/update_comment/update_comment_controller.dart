import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/comment_community.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class UpdateCommmentController extends GetxController {
  var isLoadingUpdate = false.obs;

  var contentCommentCommunityPost = new TextEditingController(text: "");
  CommentPost commentPost;

  UpdateCommmentController({required this.commentPost}) {
    contentCommentCommunityPost.text = commentPost.content ?? "";
  }

  Future<void> updateCommentCommunity() async {
    isLoadingUpdate.value = true;
    try {
      var res = await CustomerRepositoryManager.customerCommunityRepository
          .updateCommentCommunity(
              commentPost.id,
              CommentPost(
                content: contentCommentCommunityPost.value.text,
              ));
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }
}
