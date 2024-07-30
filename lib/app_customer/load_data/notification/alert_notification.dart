import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/calling.dart';
import '../serialise_and_navigate.dart';

class SahaNotificationAlert {
  static const String NEW_ORDER = "NEW_ORDER";

  static void alertNotification(RemoteMessage messages) {
    var message = messages.data;
    if (message['type'] != null) {
      showFlash(
        context: Get.context!,
        duration: const Duration(seconds: 5),
        persistent: true,
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlashBar(
              content: Text(''),
              controller: controller,
              // borderRadius: BorderRadius.circular(8.0),
              // borderColor: SahaPrimaryColor,
              // boxShadows: kElevationToShadow[8],
              position: FlashPosition.top,
              behavior: FlashBehavior.floating,
              // backgroundGradient: RadialGradient(
              //   colors: [Colors.white, Colors.white],
              //   center: Alignment.topLeft,
              //   radius: 2,
              // ),
              // onTap: () => {
              //   SerialiseAndNavigate(message: messages).navigate(),
              //   controller.dismiss(),
              // },
              forwardAnimationCurve: Curves.easeInCirc,
              reverseAnimationCurve: Curves.bounceIn,
              builder: (context, child) => GestureDetector(
                onTap: () => {
                  SerialiseAndNavigate(message: messages).navigate(),
                  controller.dismiss(),
                },
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.black87),
                  child: FlashBar(
                    title: Text(
                      '${messages.notification?.title}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                    content: Text('${messages.notification?.body}'),
                    indicatorColor: Theme.of(Get.context!).primaryColor,
                    icon: Icon(Icons.notifications_active),
                    primaryAction: TextButton(
                      onPressed: () => controller.dismiss(),
                      child: Text('Đóng'),
                    ),
                    controller: controller,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  // static void alertCalling(Calling calling) {
  //   showFlash(
  //     context: Get.context!,
  //     duration: const Duration(seconds: 20),
  //     persistent: true,
  //     builder: (_, controller) {
  //       return Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Flash(
  //           controller: controller,
  //           borderRadius: BorderRadius.circular(8.0),
  //           borderColor: Theme.of(Get.context!).primaryColor,
  //           boxShadows: kElevationToShadow[8],
  //           position: FlashPosition.top,
  //           behavior: FlashBehavior.floating,
  //           backgroundGradient: RadialGradient(
  //             colors: [Colors.white, Colors.white],
  //             center: Alignment.topLeft,
  //             radius: 2,
  //           ),
  //           onTap: () {

  //           },
  //           forwardAnimationCurve: Curves.easeInCirc,
  //           reverseAnimationCurve: Curves.bounceIn,
  //           child: DefaultTextStyle(
  //             style: TextStyle(color: Colors.black87),
  //             child: FlashBar(
  //               title: Text(
  //                 '${calling.name}',
  //                 style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.green,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //               content: Text('${calling.name}'),
  //               indicatorColor: Theme.of(Get.context!).primaryColor,
  //               icon: Icon(Icons.notifications_active),
  //               primaryAction: TextButton(
  //                 onPressed: () => controller.dismiss(),
  //                 child: Text('Đóng'),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
