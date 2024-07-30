import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/home_data.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/action_tap.dart';

class PopupShow {
  static PopupShow _instance = new PopupShow.internal();

  PopupShow.internal();

  factory PopupShow() => _instance;

  static Future<void>? showPopup() {
    DataAppCustomerController dataAppCustomerController = Get.find();
    Widget itemPopup(Popup popup) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () async {
              ActionTap.onTap(
                  typeAction: popup.typeAction,
                  value: popup.valueAction,
                  thenAction: () {
                    var index = dataAppCustomerController.homeData.value.popups!
                        .indexWhere((e) => e.id == popup.id);
                    if (index != -1) {
                      dataAppCustomerController.popups.removeAt(index);
                      //dataAppCustomerController.popups.refresh();
                      if (dataAppCustomerController.popups.isEmpty) {
                        Get.back();
                      }
                    }
                  });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: popup.linkImage ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    height: 1,
                    width: 1,
                  ),
                  errorWidget: (context, url, error) => SahaEmptyImage(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: (Get.width - 60) / 2,
            child: GestureDetector(
              onTap: () {
                // print (dataAppCustomerController.popups.length - 1);
                // print (dataAppCustomerController.indexPopup.value);
                // if (dataAppCustomerController.indexPopup.value <
                //     dataAppCustomerController.popups.length - 1) {
                //   dataAppCustomerController.indexPopup.value =
                //       dataAppCustomerController.indexPopup.value + 1;
                // } else {
                //   Get.back();
                // }
                var index = dataAppCustomerController.homeData.value.popups!
                    .indexWhere((e) => e.id == popup.id);
                if (index != -1) {
                  if (dataAppCustomerController.popups.length == 1) {
                    Get.back();
                  } else {
                    dataAppCustomerController.popups.removeAt(index);
                  }
                }
              },
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.highlight_remove_sharp)),
            ),
          )
        ],
      );
    }

    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          clipBehavior: Clip.none,
          elevation: 0,
          child: Center(
            child: Obx(() => itemPopup(dataAppCustomerController.popups[0])),
          ),
        );
      },
    );
  }
}
