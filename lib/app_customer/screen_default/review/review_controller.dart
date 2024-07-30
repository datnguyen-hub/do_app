import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/image_up.dart';
import '../../repository/repository_customer.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/order.dart';

class ReviewController extends GetxController {
  final List<LineItemsAtTime>? lineItemsAtTimeInput;
  final String? orderCodeInput;
  ReviewController({this.lineItemsAtTimeInput, this.orderCodeInput}) {
    lineItemsAtTimeInput!.forEach((item) {
      listStar.add(5);
      listContent.add("");
      listImageRequest!.add([]);
      listImages!.add([]);
      listFile.add(null);
    });
  }

  List<String> listChooseText = [
    "Chất lượng sản phẩm tuyệt vời",
    "Đóng gói sản phẩm rất đẹp",
    "Shop phục vụ rất tốt",
    "Rất đáng tiền",
    "Thời gian giao hàng nhanh",
  ];

  var listStar = RxList<int?>();
  var listVideo = RxList<String?>();
  var listContent = RxList<String?>();
  List<List<String>>? listImageRequest = [];
  List<List<ImageData>>? listImages = [];
  List<File?> listFile = [];

  var uploadingImages = false.obs;

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<void> reviewAllOrder() async {
    listFile.forEach((e)async {
      await upVideo(e,listFile.indexOf(e));
    });
    // Future.wait(lineItemsAtTimeInput!.map((e) {
    //   return reviewProduct(
    //       e.id!,
    //       orderCodeInput!,
    //       listStar[lineItemsAtTimeInput!.indexOf(e)]!,
    //       listContent[lineItemsAtTimeInput!.indexOf(e)]!,
    //       jsonEncode(listImageRequest![lineItemsAtTimeInput!.indexOf(e)])
    //           .toString(),
    //       listVideo[lineItemsAtTimeInput!.indexOf(e)]);
    // }));
    // for (int i = 0; i < lineItemsAtTimeInput!.length; i++) {
    //   await reviewProduct(
    //       lineItemsAtTimeInput![i].id!,
    //       orderCodeInput!,
    //       listStar[i]!,
    //       listContent[i]!,
    //       jsonEncode(listImageRequest![i]).toString());
    // }
    SahaAlert.showSuccess(message: "Đánh giá thành công");
    Get.back(result: true);
  }

  // Future<void> reviewProduct(int idProduct, String orderCode, int star,
  //     String content, String images, String? videoUrl) async {
  //   try {
  //     var data = await CustomerRepositoryManager.reviewCustomerRepository
  //         .review(idProduct, orderCode, star, content, images, videoUrl);
  //   } catch (err) {
  //     SahaAlert.showError(message: err.toString());
  //   }
  // }

  Future<String?> upVideo(File? file,int index) async {
    try {
      var link = await CustomerRepositoryManager.imageRepository
          .uploadVideo(video: file, type: '');
      listVideo[index] = link;
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
}
