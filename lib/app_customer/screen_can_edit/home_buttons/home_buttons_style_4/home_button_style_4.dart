import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';

import '../list_home_button.dart';

class HomeButtonStyle4Widget extends StatelessWidget {
  HomeButtonStyle4Widget({Key? key, this.homeButton}) : super(key: key);
  HomeButton? homeButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 105,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            child: ClipRRect(
              child: buildImageButton(
                  imageUrl: homeButton!.imageUrl,
                  typeAction: homeButton!.typeAction),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: AutoSizeText(
              homeButton!.title!,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
