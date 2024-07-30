import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/call/call.dart';
import '../../components/modal/modal_bottom_sheet.dart';
import '../../config_controller.dart';
import '../../screen_default/chat_customer_screen/chat_user_screen.dart';
import '../../screen_default/data_app_controller.dart';
import '../../utils/color_utils.dart';

class BuyMedicine extends StatelessWidget {
  BuyMedicine({super.key});
  DataAppCustomerController dataAppCustomerController = Get.find();
  CustomerConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () {
                Get.to(() => ChatCustomerScreen());
              },
              child: Container(
                  height: 50,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    "Gửi tin nhắn",
                    style: TextStyle(
                        fontSize: 12,
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground()),
                  ))),
            ),
          ),
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () {
                // ModalBottomSheet().showModelOption();
                Call.call(
                    "${configController.configApp.phoneNumberHotline ?? ""}");
                print("${configController.configApp.phoneNumberHotline ?? ""}");
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                    ],
                  ),
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tư vấn ngay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color:
                                SahaColorUtils().colorTextWithPrimaryColor()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
