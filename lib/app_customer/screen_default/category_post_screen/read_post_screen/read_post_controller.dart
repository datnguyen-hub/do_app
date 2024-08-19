import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as html2;
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../../utils/store_info.dart';
import '../../data_app_controller.dart';
import 'input_model_post.dart';
import 'package:html/parser.dart' as html;

class PostController extends GetxController {
  InputModelPost? inputModelPost;
  Post? postInput;
  var postShow = Post().obs;
  var isLoadingPost = false.obs;
  var isFullScreen = false.obs;

  List<String> listLinkVideo = [];

  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();

  PostController(this.inputModelPost) {
    isLoadingPost.value = true;
    if (inputModelPost == null ||
        (inputModelPost!.post == null && inputModelPost!.postId == null)) {
    } else {
      if (inputModelPost!.post != null) {
        postInput = inputModelPost!.post!;
      } else {
        postInput = Post(id: inputModelPost!.postId);
      }
      getDetailPost();
    }
  }

  Future<void> onShare(List<String>? listUrl) async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    // await Share.share(
    //     "Link bài viết: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/tin-tuc/id-${postShow.value.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}",
    //     subject: "",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);

       final cache = DefaultCacheManager(); // Gives a Singleton instance
    var imagePaths = <XFile>[];
    for (var image in (listUrl ?? [])) {
      final file = await cache.getSingleFile(image);

      imagePaths.add(XFile(file.path) );
    }
    // await  Share.share(
    //     "Link mua hàng: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/id-${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}",
    //     subject: "",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    await Share.shareXFiles(imagePaths,text:"${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/tin-tuc/id-${postShow.value.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}");
  }

  Future<void> getDetailPost() async {
    isLoadingPost.value = true;
    try {
      var res = await CustomerRepositoryManager.postCustomerRepository
          .getDetailPost(postInput!.id ?? 0);
      postShow.value = res ?? postInput!;
      parseHtml();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingPost.value = false;
  }

  void printLongString(String chuoiQuaDai) {
    final int maxLength = 1000; // Độ dài tối đa của chuỗi trong console log
    if (chuoiQuaDai.length <= maxLength) {
      print(chuoiQuaDai);
    } else {
      int start = 0;
      int end = maxLength;
      while (end < chuoiQuaDai.length) {
        log(chuoiQuaDai.substring(start, end));
        start = end;
        end += maxLength;
      }
      log(chuoiQuaDai.substring(start));
    }
  }

  void parseHtml() {
    html2.Document document = html.parse(postShow.value.content);

    List<html2.Element> iframes = document.querySelectorAll('iframe');

    if (iframes.isNotEmpty) {
      // Nếu có phần tử <iframe> được tìm thấy
      for (var iframe in iframes) {
        // Lấy giá trị của thuộc tính src của từng phần tử <iframe> (link video)
        String linkVideo = iframe.attributes['src'] ?? '';

        print("Link video: $linkVideo");
        listLinkVideo.add(linkVideo);
      }
    } else {
      print("Không tìm thấy phần tử <iframe> trong chuỗi HTML.");
    }
  }

  String removeIframesFromHtmlString(String htmlString) {
    String pattern = r'<iframe.*?</iframe>';
    RegExp regExp =
        RegExp(pattern, multiLine: true, caseSensitive: false, dotAll: true);
    return htmlString.replaceAll(regExp, '');
  }
}
