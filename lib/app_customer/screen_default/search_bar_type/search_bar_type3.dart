import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/components/icon_button/iconbtn_counter_type2.dart';


class SearchBarType3 extends StatelessWidget {
  final Function? onSearch;

  const SearchBarType3({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF3E4067),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.16),
                  spreadRadius: -2,
                )
              ],
            ),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: "Search your destination…",
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF464A7E),
                ),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            IconBtnWithCounterType2(
              svgSrc: "packages/sahashop_customer/assets/icons/cart_icon.svg",
              press: () {},
            ),
            SizedBox(
              width: 10,
            ),
            IconBtnWithCounterType2(
              svgSrc: "packages/sahashop_customer/assets/icons/bell.svg",
              numOfitem: 3,
              press: () {},
            ),
          ],
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
