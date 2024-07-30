import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config_controller.dart';
import 'package:ionicons/ionicons.dart';

class ContactScreen extends StatelessWidget {
  CustomerConfigController customerConfigController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Liên hệ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            itemList(
              title: "Điện thoại:",
              subText:
                  customerConfigController.configApp.contactPhoneNumber ?? "",
              icon: Icon(
                Ionicons.call_outline,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                launch(
                    "tel:${customerConfigController.configApp.contactPhoneNumber ?? ""}");
              },
            ),
            itemList(
              title: "Email:",
              icon: Icon(Ionicons.mail_outline,
                  color: Theme.of(context).primaryColor),
              subText: customerConfigController.configApp.contactEmail ?? "",
              svgAssets:
                  "packages/sahashop_customer/assets/icons/facebook-2.svg",
              onTap: () {
                launch(
                    "mailto::${customerConfigController.configApp.contactEmail ?? ""}");
              },
            ),
            itemList(
              title: "Thời gian làm việc:",
              icon: Icon(Ionicons.time_outline,
                  color: Theme.of(context).primaryColor),
              subText: customerConfigController.configApp.contactTimeWork ?? "",
              svgAssets:
                  "packages/sahashop_customer/assets/icons/facebook-2.svg",
              onTap: () {},
            ),
            itemList(
              title: "Địa chỉ:",
              icon: Icon(Ionicons.business_sharp,
                  color: Theme.of(context).primaryColor),
              subText: customerConfigController.configApp.contactAddress ?? "",
              svgAssets:
                  "packages/sahashop_customer/assets/icons/facebook-2.svg",
              onTap: () {},
            ),
            itemList(
              title: "Fanpage:",
              icon: Icon(Ionicons.logo_facebook,
                  color: Theme.of(context).primaryColor),
              svgAssets:
                  "packages/sahashop_customer/assets/icons/facebook-2.svg",
              onTap: () {
                launch(customerConfigController.configApp.contactFanpage ?? "");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemList(
      {required String title,
      String? svgAssets,
      required Function onTap,
      Color? colorSVG,
      Icon? icon,
      String? subText}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    shape: BoxShape.circle,
                  ),
                  child: icon != null
                      ? icon
                      : SvgPicture.asset(
                          svgAssets!,
                          color: colorSVG,
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  subText != null
                      ?  Expanded(
                        child: Text(
                              "$subText",
                              style: TextStyle(fontSize: 13),
                            ),
                      )
                      : Container(
                          height: 13,
                          width: 13,
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/right_arrow.svg",
                            color: Colors.black,
                          ))
                ],
              ),
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}
