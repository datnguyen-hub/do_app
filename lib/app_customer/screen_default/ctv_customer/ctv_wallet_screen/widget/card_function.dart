import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartFunction extends StatelessWidget {
  String svgAssets;
  String title;
  Color? svgColor;
  String? subText;
  String? totalMoney;
  Function onTap;

  CartFunction(
      {required this.svgAssets,
      required this.title,
        required this.onTap,
        this.svgColor,
      this.subText,
      this.totalMoney});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        svgAssets,
                        color: svgColor,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(title, style: TextStyle(fontWeight: FontWeight.w600),),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                  ],
                ),
                if(subText != null && totalMoney != null)
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Text(subText!),
                        Spacer(),
                        Text("$totalMoney ₫"),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
