
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingiOS {
  void onLoading() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(clipBehavior: Clip.none,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: Get.width/3),

          elevation: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.circular(10)
              ),
              child:
              CupertinoActivityIndicator(),
            ), ),
        );
      },
    );
  }
}