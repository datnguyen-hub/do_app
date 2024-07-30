import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/repository_customer.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/info_customer.dart';
import '../../utils/date_utils.dart';
import '../../utils/image_utils.dart';

import 'package:image_cropper/image_cropper.dart';

import 'select_image_carousel_controller.dart';

class ConfigProfileController extends GetxController {
  var infoCustomer = new InfoCustomer().obs;
  var sex = "".obs;
  var sexIndex = 0;
  var linkAvatar = "".obs;
  var isUpdatingImage = false.obs;
  Rx<ImageData?> dataImages = ImageData().obs;
  var birthDate = DateTime.now().obs;

  var nameEditingController = new TextEditingController().obs;
  var phoneEditingController = new TextEditingController().obs;
  var emailEditingController = new TextEditingController().obs;
  var passwordEditingController = new TextEditingController().obs;

  SelectCarouselImagesController selectImageController =
      SelectCarouselImagesController();

  ConfigProfileController({InfoCustomer? infoCustomer2}) {
    infoCustomer(infoCustomer2!);
    nameEditingController.value.text = infoCustomer.value.name ?? "";
    phoneEditingController.value.text = infoCustomer.value.phoneNumber ?? "";
    emailEditingController.value.text = infoCustomer.value.email ?? "";
    passwordEditingController.value.text = infoCustomer.value.email ?? "";
    linkAvatar.value = infoCustomer.value.avatarImage ?? "";
    onChangeSexPicker(infoCustomer.value.sex ?? 0);
    birthDate.value = infoCustomer.value.dateOfBirth == null
        ? DateTime.now()
        : DateTime.parse(infoCustomer.value.dateOfBirth!.toIso8601String());
    dataImages.value = ImageData(
        linkImage: infoCustomer.value.avatarImage,
        uploading: false,
        errorUpload: false);
  }

  void onChangeSexPicker(int value) {
    if (value == 0) {
      sex.value = "Khác";
      sexIndex = 0;
    } else {
      if (value == 1) {
        sex.value = "Nam";
        sexIndex = 1;
      } else {
        sex.value = "Nữ";
        sexIndex = 2;
      }
    }
  }

  Future<void> updateProfileCustomer() async {
    try {
      var res = await CustomerRepositoryManager.infoCustomerRepository
          .updateAccountCustomer(InfoCustomer(
              name: nameEditingController.value.text,
              sex: sexIndex,
              avatarImage: linkAvatar.value,
              dateOfBirth:
                  SahaDateUtils().isSameDate(DateTime.now(), birthDate.value) ==
                          true
                      ? null
                      : birthDate.value,
              email: emailEditingController.value.text));
      Get.back();
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateReferralPhoneNumber(phone) async {
    try {
      var res = await CustomerRepositoryManager.infoCustomerRepository
          .updateReferralPhoneNumber(phone);
      infoCustomer(res!.data!);
      // Get.back();
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void updateImage({ImageData? imageData}) {
    dataImages.value = imageData;
  }

  Future<String?> uploadImage(File file) async {
    isUpdatingImage.value = true;
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 20);

      var link = (await CustomerRepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress))!;

      //OK up load
      updateImage(
          imageData:
              ImageData(linkImage: link, uploading: false, errorUpload: false));
      linkAvatar.value = link;
    } catch (err) {
      updateImage(
          imageData:
              ImageData(file: file, uploading: false, errorUpload: true));

      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    isUpdatingImage.value = false;
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

      dataImages.value = ImageData(
          file: File(croppedFile.path), uploading: true, errorUpload: false);

      return await uploadImage(File(croppedFile.path));
    } on Exception {
      return null;
    }
  }
}
