import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/loading/loading_widget.dart';
import '../../../../components/toast/saha_alert.dart';
import '../../../../model/image_up.dart';
import '../../../../model/review.dart';
import '../../../../repository/repository_customer.dart';

class ReviewProductController extends GetxController{

  var review = Review(stars: 5).obs;
  String? orderCode;
  var listImages = RxList<ImageData>([]);
  File? file;
  // String? videoLink;
  // List<String> listImageRequest = [];
  // String? content;
  List<String> listChooseText = [
    "Chất lượng sản phẩm tuyệt vời",
    "Đóng gói sản phẩm rất đẹp",
    "Shop phục vụ rất tốt",
    "Rất đáng tiền",
    "Thời gian giao hàng nhanh",
  ];
  ReviewProductController({this.orderCode}){
    review.value.orderCode = orderCode;

  }
    Future<void> reviewProduct(int idProduct) async {
       if (file != null) {
        showDialogSuccess('Đang tạo video');
        await upVideo();
        Get.back();
      }
    try {
      var data = await CustomerRepositoryManager.reviewCustomerRepository
          .review(idProduct: idProduct,review: review.value);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
   Future<String?> upVideo() async {
    try {
      var link = await CustomerRepositoryManager.imageRepository
          .uploadVideo(video: file, type:'');
      review.value.videoUrl = link;
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
   void showDialogSuccess(String title) {
    var alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.grey[200],
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SahaLoadingWidget(),
          const SizedBox(
            height: 1,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext c) {
          return alert;
        });
  }
}
