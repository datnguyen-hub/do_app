import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyChatWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyChatWidget({Key? key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            "packages/sahashop_customer/assets/icons/chat_empty.svg",
            width: width,
            height: height,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Chưa có user nào chat cả !")
        ],
      ),
    );
  }
}
