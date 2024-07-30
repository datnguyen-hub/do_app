import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config_controller.dart';
import '../../utils/color_utils.dart';
import '../call/call.dart';

class ModalBottomSheet {
  CustomerConfigController configController = Get.find();
  
  showModelOption() {
    return showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              button("Liên hệ hotline", null,() {
                Call.call("${configController.configApp.phoneNumberHotline ?? ""}");
                Get.back();
              }),
              button("Liên hệ Zalo", "packages/sahashop_customer/assets/icons/zalo.svg", () {
                // launchURL(configController.configApp.idZalo ?? "");
                Get.back();
              }),
              button(
                  "Liên hệ facebook",  "packages/sahashop_customer/assets/icons/facebook-2.svg", ()  async{
                         if (configController.configApp.idFacebook != null &&
                  configController.configApp.idFacebook!.contains("https://")) {
                await launchUrl(Uri.parse(configController.configApp.idFacebook!));
                return;
              }
              var messengerUrl = "http://m.me/${configController.configApp.idFacebook}";

              final Uri messengerUri = Uri.parse(messengerUrl);
              if (await canLaunchUrl(messengerUri)) {
                await launchUrl(messengerUri);
              } else {
                await launchUrl(Uri.parse(
                    "https://www.facebook.com/${configController.configApp.idFacebook}"));
                // throw 'Could not launchhh $messengerUrl';
              }
                     Get.back();
                  }),
            ],
          );
        });
  }

  Widget button(String title, String? icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon == null ? Icon(
              Icons.phone,
              size: 45,
              color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
            ):
            SvgPicture.asset(
              icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '$title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
    void launchURL(String phone) async { 
    var tel = Uri(
      scheme: "tel",
      path: phone
    );
    await canLaunchUrl(tel)
      ? await launchUrl(tel)
      : throw 'Could not launch $phone';}
}
