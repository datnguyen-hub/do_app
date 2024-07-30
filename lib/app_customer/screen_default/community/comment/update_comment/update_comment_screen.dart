import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/comment_community.dart';

import 'update_comment_controller.dart';

class UpdateCommentScreen extends StatelessWidget {
  late UpdateCommmentController updateCommmentController;

  CommentPost commentPost;

  UpdateCommentScreen({required this.commentPost}) {
    updateCommmentController =
        UpdateCommmentController(commentPost: commentPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        title: Text(
          'Chỉnh sửa',
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller:
                    updateCommmentController.contentCommentCommunityPost,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade100,
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Huỷ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      updateCommmentController.updateCommentCommunity();
                      Get.back();
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Cập Nhật',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
