import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/banner.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/utils/image_utils.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../config_controller.dart';

class SelectCarouselImagesController extends GetxController {
  Function? onUpload;
  Function? doneUpload;

  RxList<ImageData?> dataImages = <ImageData>[].obs;

  void init() {

    CustomerConfigController configController = Get.find();

    if (configController.configApp.carouselAppImages != null) {
      final listCarousel = configController.configApp.carouselAppImages!;

      dataImages(listCarousel
          .map((e) => ImageData(
              linkImage: e.imageUrl, uploading: false, errorUpload: false))
          .toList());
    }
  }

  void removeImage(ImageData imageData) {
    dataImages.remove(imageData);
    updateBannerToConfig();
  }

  void updateBannerToConfig() {
    CustomerConfigController configController = Get.find();

    var banners = <BannerItem>[];

    dataImages.forEach((imageData) {
      if (imageData!.linkImage != null) {
        banners.add(BannerItem(imageUrl: imageData.linkImage, title: ""));
      }
    });

    configController.configApp.carouselAppImages = banners;

  }

  void updateImage({required int index, ImageData? imageData}) {
    var indexWithLength = index - 1;
    var newList = dataImages.toList();

    newList[indexWithLength] = imageData;

    dataImages(newList);
  }

  Future<String?> uploadImage(File file) async {
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 50);

      var link = await CustomerRepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      //OK up load
      updateImage(
          index: dataImages.length,
          imageData:
              ImageData(linkImage: link, uploading: false, errorUpload: false));

      updateBannerToConfig();

      return link;
    } catch (err) {
      updateImage(
          index: dataImages.length,
          imageData:
              ImageData(file: file, uploading: false, errorUpload: true));

      updateBannerToConfig();
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    return null;
  }

  Future<String?> loadAssets() async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.getImage(source: ImageSource.gallery))!;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile == null) return "";

      dataImages.add(
          ImageData(file: File(croppedFile.path), uploading: true, errorUpload: false));

      return await uploadImage(File(croppedFile.path));
    } on Exception {
      return null;
    }
  }
}

class ImageData {
  File? file;
  String? linkImage;
  bool? errorUpload;
  bool? uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
