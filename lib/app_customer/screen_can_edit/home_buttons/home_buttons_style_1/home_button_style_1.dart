import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';

import '../list_home_button.dart';

class HomeButtonStyle1Widget extends StatelessWidget {
  HomeButtonStyle1Widget({Key? key, this.homeButton}) : super(key: key);
  HomeButton? homeButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 80,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: buildImageButton(
                  imageUrl: homeButton!.imageUrl,
                  typeAction: homeButton!.typeAction),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            child: Center(
              child: AutoSizeText(
                homeButton!.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 12, height: 1),
                maxLines: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
