import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

class SelectCmndImage extends StatelessWidget {
  SelectCmndImageController selectImageController =
      new SelectCmndImageController();
  final Function? onChange;
  final String? linkLogo;

  SelectCmndImage({Key? key, this.onChange, this.linkLogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var deviceImage = selectImageController.pathImage.value;
        print("bbb");
        if (deviceImage == "") return addImage();
        return buildItemAsset(File(deviceImage));
      }),
    );
  }

  Widget addImage() {
    return selectImageController.isLoadingAdd.value
        ? SahaLoadingWidget()
        : Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Get.bottomSheet(
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            selectImageController.getImageNewCamera(
                                onOK: (link) {
                              onChange!(link);
                            });
                            Get.back();
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.camera_enhance_outlined),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Chụp ảnh',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            selectImageController.getImage(onOK: (link) {
                              onChange!(link);
                            });
                            Get.back();
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons
                                          .picture_in_picture_alt_outlined),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Chọn ảnh từ thư viện',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: 100,
                width: 100,
                child: linkLogo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: linkLogo!,
                          placeholder: (context, url) => new SahaLoadingWidget(
                            size: 20,
                          ),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                      )
                    : Center(
                        child: Icon(Icons.camera_alt_outlined),
                      ),
              ),
            ),
          );
  }

  Widget buildItemAsset(File asset) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground())),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      asset,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    )),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    selectImageController.removeImage();
                    onChange!(null);
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectCmndImageController extends GetxController {
  var pathImage = "".obs;
  final picker = ImagePicker();
  var isLoadingAdd = false.obs;

  Future getImage({Function? onOK, Function? onError}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var file = File(pickedFile.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = dir.absolute.path + basename(pickedFile.path) + ".jpg";

      var result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 60, minHeight: 512, minWidth: 512);

      var link = await upLogo(result);
      onOK!(link);
      pathImage.value = pickedFile.path;
    } else {
      SahaAlert.showError(message: "Có lỗi khi up logo");
      print('No image selected.');
    }
  }

  Future getImageNewCamera({Function? onOK, Function? onError}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      var file = File(pickedFile.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = dir.absolute.path + basename(pickedFile.path) + ".jpg";

      var result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 60, minHeight: 512, minWidth: 512);

      var link = await upLogo(result);
      onOK!(link);
      pathImage.value = pickedFile.path;
    } else {
      SahaAlert.showError(message: "Có lỗi khi up logo");
      print('No image selected.');
    }
  }

  void removeImage() {
    pathImage.value = "";
  }

  Future<String?> upLogo(File? file) async {
    isLoadingAdd.value = true;
    try {
      var link =
          await CustomerRepositoryManager.imageRepository.uploadImage(file);
      isLoadingAdd.value = false;
      return link;
    } catch (err) {
      isLoadingAdd.value = false;
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
}
