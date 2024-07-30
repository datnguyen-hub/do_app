import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_widget.dart';

class SahaLoadingFullScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              )),
          Center(child: SahaLoadingWidget())
        ],
      ),
    );
  }
}
