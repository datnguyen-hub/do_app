import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/widget/select_image/select_images.dart';
import 'package:sahashop_customer/app_customer/model/image_up.dart';
import '../../components/widget/video_picker_single/video_picker_single.dart';
import '../../screen_default/review/review_controller.dart';
import '../../screen_default/review/widget/select_image_review.dart';
import '../../screen_default/review/widget/star.dart';
import '../../screen_default/review/widget/text_field_choose.dart';
import '../../model/order.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatelessWidget {
  final List<LineItemsAtTime>? lineItemsAtTime;
  final String? orderCode;

  ReviewScreen({
    this.lineItemsAtTime,
    this.orderCode,
  }) {
    reviewController = ReviewController(
        lineItemsAtTimeInput: lineItemsAtTime, orderCodeInput: orderCode);
  }
  ReviewController? reviewController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Đánh giá sản phẩm"),
              Spacer(),
              TextButton(
                  onPressed: () {
                    reviewController!.reviewAllOrder();
                  },
                  child: Text(
                    "Gửi",
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .color,
                        fontSize: 15),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(reviewController!.lineItemsAtTimeInput!.length,
                  (index) => itemReview(index)),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemReview(int index) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    imageUrl:
                        "${reviewController!.lineItemsAtTimeInput![index].imageUrl}",
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                    "${reviewController!.lineItemsAtTimeInput![index].name ?? "Loading..."}")
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Obx(
            () => Star(
              starInput: reviewController!.listStar[index],
              onTap: (int star) {
                reviewController!.listStar[index] = star;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectImages(
              title: "Chọn ảnh",
              subTitle: "Tối đa 10 ảnh",
              type: "",
              maxImage: 10,
              onUpload: () {
                reviewController!.setUploadingImages(true);
              },
              images: reviewController!.listImages![index].isEmpty
                  ? null
                  : reviewController!.listImages![index],
              doneUpload: (List<ImageData> listImages) {
                reviewController!.listImageRequest![index] = [];
                print(
                    "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                reviewController!.setUploadingImages(true);
                reviewController!.listImages![index] = listImages;
                listImages.forEach((image) {
                  reviewController!.listImageRequest![index]
                      .add(image.linkImage!);
                });
                print(reviewController!.listImageRequest!);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => VideoPickerSingle(
                linkVideo: reviewController!.listVideo.isEmpty ? null : reviewController!.listVideo[index],
                onChange: (File? file) async {
                  reviewController!.listFile[index] = file;
                  if (file == null) {
                    reviewController!.listVideo[index] = "";
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldChoose(
            listChooseText: reviewController!.listChooseText,
            textInput: reviewController!.listContent[index],
            onChange: (v) {
              reviewController!.listContent[index] = v;
              print(reviewController!.listContent);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
