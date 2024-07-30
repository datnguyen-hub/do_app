import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

import '../list_home_button.dart';

class HomeButtonStyle2Widget extends StatelessWidget {
  HomeButtonStyle2Widget({Key? key, this.homeButton}) : super(key: key);
  HomeButton? homeButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 90,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    color: SahaColorUtils()
                        .colorPrimaryTextWithWhiteBackground())),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(7)),
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
          )
        ],
      ),
    );
  }
}
