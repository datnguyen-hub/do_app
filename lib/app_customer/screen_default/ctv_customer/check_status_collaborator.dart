import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/ctv_customer/update_info_collaborator/update_info_collaborator_screen.dart';

import '../data_app_controller.dart';

class CheckStatusCollaboratorScreen extends StatelessWidget {
   CheckStatusCollaboratorScreen({super.key});
    DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cộng tác viên"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Column(
            children: [
              Text( dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 1 ? "Yêu cầu của bạn không được chấp thuận" : dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 0 ? 'Yêu cầu đang chờ duyệt':dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 3 ? "Đang yêu cầu duyệt lại":"Trạng thái khác"),
              const SizedBox(
                height: 20,
              ),
              if(dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 1)
              InkWell(
                onTap: (){
                  Get.to(()=>UpdateInfoCollaboratorScreen(isFromCheckStatus: true,));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Gửi lại",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
