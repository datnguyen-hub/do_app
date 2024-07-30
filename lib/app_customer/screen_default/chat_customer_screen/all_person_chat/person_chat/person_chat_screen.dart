import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
//import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:uuid/uuid.dart';
import 'person_chat_controller.dart';

class PersonChatScreen extends StatelessWidget {
  InfoCustomer infoCustomerChat;

  PersonChatScreen({required this.infoCustomerChat}) {
    chatController = PersonChatController(infoCustomerChat: infoCustomerChat);
  }

  late PersonChatController chatController;

  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: infoCustomerChat.avatarImage ?? "",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SahaLoadingContainer(
                    height: 40,
                    width: 30,
                  ),
                  errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SahaEmptyImage(),
                  ),
                ),
                borderRadius: BorderRadius.circular(3000),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${infoCustomerChat.name ?? ""}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Avenir'),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Online 1 phút trước",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       Get.to(() => VideoChatScreen(
            //             callingInput: Calling(
            //                 infoCustomerTo: infoCustomerChat, type: AUDIO),
            //           ));
            //     },
            //     icon: Icon(Icons.call)),
            // IconButton(
            //     onPressed: () async {
            //       Get.to(() => VideoChatScreen(
            //         callingInput: Calling(
            //                 infoCustomerTo: infoCustomerChat, type: VIDEO),
            //           ));
            //     },
            //     icon: Icon(Icons.videocam))
          ],
        ),
        body: Obx(
          () => Chat(
            dateLocale: 'vi',
            l10n: const ChatL10nEn(
              inputPlaceholder: 'Tin nhắn',
            ),
            messages: chatController.listMessages.toList(),
            onAttachmentPressed: _handleAtachmentPress,
            onSendPressed: _onSendMessage,
            user: chatController.userMain.value,
            onEndReached: _handleEndReached,
            onEndReachedThreshold: 1,
            showUserAvatars: false,
            showUserNames: true,
            theme: DefaultChatTheme(
              attachmentButtonIcon: Icon(
                Icons.camera_alt,
                color: SahaColorUtils().colorTextWithPrimaryColor(),
              ),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              inputBackgroundColor: Theme.of(context).primaryColor,
              inputBorderRadius:
                  BorderRadius.vertical(top: Radius.circular(15)),
              inputTextColor: SahaColorUtils().colorTextWithPrimaryColor(),
              inputTextCursorColor:
                  SahaColorUtils().colorTextWithPrimaryColor(),
            ),
          ),
        ),
      ),
    );
  }

  void _handleAtachmentPress() {
    showModalBottomSheet<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chatController.multiPickerImage();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thư viện ảnh',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thoát',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleEndReached() async {
    await chatController.getMesagePersonChat();
  }

  void _addMessage(types.Message message) {
    chatController.listMessages.insert(0, message);
  }

  void _onSendMessage(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: chatController.userMain.value,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(textMessage);
    chatController.sendMessageToUser(message.text);
  }
}
