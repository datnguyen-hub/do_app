import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/message.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/utils/image_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../../model/info_customer.dart';
import '../../../../model/message_person_chat.dart';
import '../../../../socket/socket.dart';
import '../../../data_app_controller.dart';
import '../../message_to_json.dart';

class PersonChatController extends GetxController {
  var limitedSocket = 0.obs;
  var currentPage = 1;
  var isEnd = false;
  var listMessageRes = RxList<MessageRes>();
  var allImageInMessage = RxList<List<dynamic>?>();
  var listImageResponse = [];
  var listImageRequest = [];
  var listSaveDataImages = RxList<List<ImageData>?>();
  var timeNow = DateTime.now().obs;
  var isLoading = false.obs;
  var listMessages = RxList<types.Message>();
  List<String> listImageChat = [];

  var userMain = types.User(id: "").obs;
  var userChat = types.User(id: "").obs;

  InfoCustomer infoCustomerChat;

  PersonChatController({required this.infoCustomerChat}) {
    userMain = types.User(
            id: "${dataAppCustomerController.infoCustomer.value.id}",
            imageUrl:
                "${dataAppCustomerController.infoCustomer.value.avatarImage ?? ""}",
            firstName:
                "${dataAppCustomerController.infoCustomer.value.name ?? ""}")
        .obs;
    userChat.value = types.User(
        id: '${infoCustomerChat.id ?? 0}',
        imageUrl: infoCustomerChat.avatarImage ?? '',
        firstName: '${infoCustomerChat.name ?? ''}');
    if (dataAppCustomerController.isLogin.value == true) {
      getMesagePersonChat(isRefresh: true);
      getDataMessageCustomer();
    }
  }

  DataAppCustomerController dataAppCustomerController = Get.find();

  void getDataMessageCustomer() {
    SocketCustomer().listenFriendWithId(
        dataAppCustomerController.infoCustomer.value.id, infoCustomerChat.id,
        (data) {
      timeNow.value = DateTime.now();
      limitedSocket.value++;
      if (limitedSocket.value == 1) {
        print("------------------------------$data");
        var resData = MessageRes.fromJson(data);
        if (resData.linkImages == null) {
          final message = types.TextMessage(
            author: userChat.value,
            id: resData.id.toString(),
            createdAt: resData.createdAt?.millisecondsSinceEpoch ??
                timeNow.value.millisecondsSinceEpoch,
            text: resData.content ?? "",
            status: types.Status.sent,
          );
          listMessages.insert(0, message);
        } else {
          try {
            var listImage = (jsonDecode(resData.linkImages!) as List)
                .map((e) => ImageChat.fromJson(e as Map<String, dynamic>))
                .toList();
            listImage.forEach((e) {
              final message = types.ImageMessage(
                author: userChat.value,
                height: e.height,
                id: e.linkImages!,
                name: e.linkImages!,
                size: e.size ?? 1000000,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                uri: e.linkImages!,
                width: e.width,
                status: types.Status.sent,
              );
              listMessages.insert(0, message);
            });
          } catch (err) {
            //allImageInMessage[i] = [listMessage[i].linkImages];
          }
        }
      }
      Future.delayed(Duration(seconds: 1), () {
        limitedSocket.value = 0;
      });
    });
  }

  Future<void> getMesagePersonChat({bool? isRefresh}) async {
    isLoading.value = true;
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    timeNow.value = DateTime.now();
    try {
      if (!isEnd) {
        var res = await CustomerRepositoryManager.chatCustomerRepository
            .getMesagePersonChat(
                customerId: infoCustomerChat.id!, currentPage: currentPage);
        res!.data!.data!.forEach((eMain) {
          print(eMain.isSender);
          if (eMain.isSender == false) {
            if (eMain.images == null) {
              final message = types.TextMessage(
                author: userChat.value,
                id: eMain.id.toString(),
                createdAt: eMain.createdAt?.millisecondsSinceEpoch ??
                    timeNow.value.millisecondsSinceEpoch,
                text: eMain.content ?? "",
                status: types.Status.sent,
              );
              listMessages.add(message);
            } else {
              try {
                var listImage = eMain.images ?? [];
                listImage.forEach((e) {
                  final message = types.ImageMessage(
                    id: e,
                    name: e,
                    author: userChat.value,
                    size: 1000000,
                    createdAt: eMain.createdAt?.millisecondsSinceEpoch ??
                        timeNow.value.millisecondsSinceEpoch,
                    uri: e,
                    status: types.Status.sent,
                  );
                  listMessages.add(message);
                });
              } catch (err) {
                //allImageInMessage[i] = [listMessage[i].linkImages];
              }
            }
          } else {
            if (eMain.images == null) {
              final message = types.TextMessage(
                author: userMain.value,
                id: eMain.id.toString(),
                createdAt: eMain.createdAt?.millisecondsSinceEpoch ??
                    timeNow.value.millisecondsSinceEpoch,
                text: eMain.content ?? "",
                status: types.Status.sent,
              );
              listMessages.add(message);
            } else {
              try {
                var listImage = eMain.images ?? [];
                listImage.forEach((e) {
                  final message = types.ImageMessage(
                    author: userMain.value,
                    id: e,
                    name: e,
                    size: 1000000,
                    createdAt: eMain.createdAt?.millisecondsSinceEpoch ??
                        timeNow.value.millisecondsSinceEpoch,
                    uri: e,
                    status: types.Status.sent,
                  );
                  listMessages.add(message);
                });
              } catch (err) {
                //allImageInMessage[i] = [listMessage[i].linkImages];
              }
            }
          }
        });
        listMessages.refresh();

        if (res.data!.nextPageUrl != null) {
          currentPage++;
          isEnd = false;
        } else {
          isEnd = true;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void addMessage(types.Message message) {
    listMessages.insert(0, message);
    listMessages.refresh();
  }

  Future<void> sendImageToUser() async {
    timeNow.value = DateTime.now();
    try {
      var res = await CustomerRepositoryManager.chatCustomerRepository
          .sendMessagePersonChat(
              customerId: infoCustomerChat.id ?? 0,
              messagePersonChat: MessagePersonChat(images: listImageChat));
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> sendMessageToUser(String? textMessage) async {
    timeNow.value = DateTime.now();
    try {
      listSaveDataImages.insert(0, null);
      allImageInMessage.insert(0, null);
      var res = await CustomerRepositoryManager.chatCustomerRepository
          .sendMessagePersonChat(
              customerId: infoCustomerChat.id ?? 0,
              messagePersonChat: MessagePersonChat(content: textMessage));
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var dataImages = <ImageData>[];

  void updateListImage(List<XFile> listXFile) {
    var listPre = dataImages.toList();
    var newList = <ImageData>[];
    for (var file in listXFile) {
      var dataPre = listPre.firstWhereOrNull((itemPre) => itemPre.file == file);

      if (dataPre != null) {
        newList.add(dataPre);
      } else {
        newList.add(ImageData(
            file: file, linkImage: null, errorUpload: false, uploading: false));
      }
    }
    dataImages = newList;
    dataImages.forEach((e) async {
      final size = File(e.file!.path).lengthSync();
      final bytes = await e.file!.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageName = e.file!.path.split('/').last;
      final message = types.ImageMessage(
          author: userMain.value,
          height: image.height.toDouble(),
          id: const Uuid().v4(),
          name: imageName,
          size: size,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          uri: e.file!.path,
          width: image.width.toDouble(),
          status: types.Status.sent);

      addMessage(message);
    });
    uploadListImage();
  }

  void uploadListImage() async {
    int stackComplete = 0;
    listImageChat = [];
    var responses = await Future.wait(dataImages.map((imageData) {
      if (imageData.linkImage == null) {
        return uploadImageData(
            indexImage: dataImages.indexOf(imageData),
            onOK: () {
              stackComplete++;
            });
      } else
        return Future.value(null);
    }));
    dataImages.forEach((e) async {
      listImageChat.add(e.linkImage ?? "");
      print(jsonEncode(listImageChat));
      if (listImageChat.length == dataImages.length) {
        sendImageToUser();
      }
    });
  }

  Future<void> uploadImageData(
      {required int indexImage, required Function onOK}) async {
    try {
      var fileUp = await ImageUtils.getImageCompress(
          File(dataImages[indexImage].file!.path),
          minWidth: 700,
          minHeight: 512,
          quality: 15);

      var link =
          await CustomerRepositoryManager.imageRepository.uploadImage(fileUp);

      dataImages[indexImage].linkImage = link;
    } catch (err) {
      print(err);
      dataImages[indexImage].linkImage = null;
    }
    onOK();
  }

  Future<void> multiPickerImage() async {
    dataImages = [];
    List<XFile>? resultList = <XFile>[];
    String error = 'No Error Detected';
    try {
      resultList = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 1440,
      );
    } on Exception catch (e) {
      print(error);
      error = e.toString();
      print(error);
    }

    if (resultList!.isNotEmpty) {
      updateListImage(resultList);
    } else {
      return;
    }
  }
}

class ImageData {
  XFile? file;
  String? linkImage;
  bool? errorUpload;
  bool? uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
