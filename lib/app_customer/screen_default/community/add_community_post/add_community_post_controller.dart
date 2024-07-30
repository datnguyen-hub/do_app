import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../../utils/image_utils.dart';

class AddCommunityPostController extends GetxController {
  var listCommunityPost = RxList<CommunityPost>();
  var contentCommunityPost = new TextEditingController();
  var communityPostRequest = CommunityPost().obs;
  var listImageFile = RxList<File>();
  var listImageAsset = RxList<Asset>();
  var collapse = true.obs;
  var maxLine = 0.obs;
  var isLoading = false.obs;
  CommunityPost? communityPostInput;

  AddCommunityPostController({this.communityPostInput}) {
    if (communityPostInput != null) {
      communityPostRequest.value = communityPostInput!;
      contentCommunityPost.text = communityPostInput!.content ?? "";
      maxLine.value =
          '\n'.allMatches(communityPostInput!.content ?? "").length + 1;
    }
  }

  Future<void> addCommunityPost() async {
    isLoading.value = true;
    await uploadListImage();
    if (maxLine.value >= 7) {
      communityPostRequest.value.backgroundColor = null;
    }
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .addCommunityPost(
        communityPost: communityPostRequest.value,
      );
      print(data!.data);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateComunityPost() async {
    isLoading.value = true;
    if (communityPostInput == null) {
      await uploadListImage();
    }

    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .updateComunityPost(
        communityPost: communityPostRequest.value,
      );
      print(data!.data);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> loadAssets() async {
    try {
      var resultList =  await ImagePicker().pickMultiImage(
        imageQuality: 50,
      );
      // var resultList = await MultiImagePicker.pickImages(
      //   maxImages: 10 - listImageAsset.length,
      //   enableCamera: true,
      //   selectedAssets: listImageAsset,
      //   cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      //   materialOptions: MaterialOptions(
      //     actionBarColor: "#abcdef",
      //     actionBarTitle: "SahaShop",
      //     allViewTitle: "Mời chọn ảnh",
      //     useDetailsView: false,
      //     selectCircleStrokeColor: "#000000",
      //   ),
      // );
      //listImageAsset(resultList);
      listImageFile([]);
      await Future.wait(resultList.map((xfile) {
        return assetToFile(xfile);
      }));

      if (communityPostInput != null) {
        isLoading.value = true;
        communityPostRequest.value.backgroundColor = null;
        await uploadListImage();
        communityPostRequest.refresh();
        isLoading.value = false;
      }
    } on Exception catch (e) {
      print(e.toString());
      // error = e.toString();
    }
  }

  Future<void> uploadListImage() async {
    int stackComplete = 0;

    var responses = await Future.wait(listImageFile.map((imageFile) {
      return uploadImageData(
          file: imageFile,
          onOK: () {
            stackComplete++;
          });
    }));

    print(stackComplete);
  }

  Future<void> uploadImageData(
      {required File file, required Function onOK}) async {
    try {
      var fileUp = await ImageUtils.getImageCompress(file, quality: 15);
      var link =
          await CustomerRepositoryManager.imageRepository.uploadImage(fileUp);
      if (communityPostRequest.value.images == null) {
        communityPostRequest.value.images = [];
      }
      communityPostRequest.value.images!.add(link ?? "");
    } catch (err) {
      print(err);
    }
    onOK();
  }

  Future<void> assetToFile(XFile xFile) async {
   //var fileUp = await ImageUtils.getImageFileFromAsset(xFile);
   //if (fileUp != null) 
    listImageFile.add(File(xFile.path));
  }
}
