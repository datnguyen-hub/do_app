// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sahashop_customer/app_customer/model/image_up.dart';
// import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
// import 'package:sahashop_customer/app_customer/utils/image_utils.dart';


// class SelectImageReviewController extends GetxController {
//   Function? onUpload;
//   Function? doneUpload;
//   SelectImageReviewController({this.onUpload, this.doneUpload});

//   var dataImages = <ImageData>[].obs;

//   void deleteImage(Asset? asset) {
//     var indexRm =
//         dataImages.toList().map((e) => e.file).toList().indexOf(asset);

//     dataImages.removeAt(indexRm);

//     updateListImage(dataImages.map((element) => element.file).toList());
//     doneUpload!(dataImages.toList());
//   }

//   void updateListImage(List<Asset?> listAsset) {
//     print(listAsset.map((e) => e!.identifier!));
//     print(dataImages.map((e) => e.file!.identifier!));
//     onUpload!();

//     var listPre = dataImages.toList();

//     for (var asset in listAsset) {
//       if(listPre.isEmpty) {
//         dataImages.add(ImageData(
//             file: asset,
//             linkImage: null,
//             errorUpload: false,
//             uploading: false));
//       } else {
//        var check = listPre.map((e) => e.file!.identifier).toList().contains(asset!.identifier);

//        if(check) {
//          print("da ton tai");
//        } else {
//          print("add");
//          dataImages.add(ImageData(
//              file: asset,
//              linkImage: null,
//              errorUpload: false,
//              uploading: false));
//        }
//       }
//     }
//     uploadListImage();
//   }

//   void uploadListImage() async {
//     int stackComplete = 0;

//     var responses = await Future.wait(dataImages.map((imageData) {
//       if (imageData.linkImage == null) {
//         return uploadImageData(
//             indexImage: dataImages.indexOf(imageData),
//             onOK: () {
//               stackComplete++;
//             });
//       } else
//         return Future.value(null);
//     }));

//     doneUpload!(dataImages.toList());
//   }

//   Future<void> uploadImageData(
//       {required int indexImage, required Function onOK}) async {
//     try {
//       dataImages[indexImage].uploading = true;
//       dataImages.refresh();

//       var fileUp =
//           await ImageUtils.getImageFileFromAsset(dataImages[indexImage].file);
//       var fileUpImageCompress = await ImageUtils.getImageCompress(fileUp!);

//       var link = await CustomerRepositoryManager.imageRepository
//           .uploadImage(fileUpImageCompress);

//       dataImages[indexImage].linkImage = link;
//       dataImages[indexImage].errorUpload = false;
//       dataImages[indexImage].uploading = false;
//       dataImages.refresh();
//     } catch (err) {
//       print(err);
//       dataImages[indexImage].linkImage = null;
//       dataImages[indexImage].errorUpload = true;
//       dataImages[indexImage].uploading = false;
//       dataImages.refresh();
//     }
//     onOK();
//   }

//   Future<File> getImageFileFromAssetsAndroid(String path) async {
//     final byteData = await rootBundle.load('packages/sahashop_customer/assets/$path');

//     final file = File('${(await getTemporaryDirectory()).path}/$path');
//     await file.writeAsBytes(byteData.buffer
//         .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

//     return file;
//   }

//   Future<void> loadAssets() async {
//    List<Asset?> resultList = dataImages.toList().map((e) => e.file!).toList();
//     String error = 'No Error Detected';
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 5 - resultList.length,
//         enableCamera: true,
//         selectedAssets: dataImages.toList().map((e) => e.file!).toList(),
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "SahaShop",
//           allViewTitle: "Mời chọn ảnh",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }
//     updateListImage(resultList);
//   }
// }