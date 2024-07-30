import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyProducts extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyProducts({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "packages/sahashop_customer/assets/svg/box.svg",
            width: width ?? 100,
            height: height?? 100,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Không có sản phẩm nào")
        ],
      ),
    );
  }
}
