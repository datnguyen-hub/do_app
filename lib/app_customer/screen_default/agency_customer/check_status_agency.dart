import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/update_info_agency/update_info_agency_screen.dart';

import '../data_app_controller.dart';

class CheckStatusAgencyScreen extends StatelessWidget {
   CheckStatusAgencyScreen({super.key});
    DataAppCustomerController dataAppCustomerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đại lý"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Column(
            children: [
              Text( dataAppCustomerController.badge.value.agencyRegisterRequest?.status == 1 ? "Yêu cầu của bạn không được chấp thuận" : dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 0 ? 'Yêu cầu đang chờ duyệt':dataAppCustomerController.badge.value.collaboratorRegisterRequest?.status == 3 ? "Đang yêu cầu duyệt lại":"Trạng thái khác"),
              const SizedBox(
                height: 20,
              ),
              if(dataAppCustomerController.badge.value.agencyRegisterRequest?.status == 1)
              InkWell(
                onTap: (){
                  Get.to(()=>UpdateInfoAgencyScreen(isFromCheckStatus: true,));
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
