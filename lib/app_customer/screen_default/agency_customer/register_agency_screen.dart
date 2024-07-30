import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/agency_customer/update_info_agency/update_info_agency_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import 'agency_wallet_screen/agency_wallet_controller.dart';

class RegisterAgencyScreen extends StatelessWidget {
  final Widget child;
  DataAppCustomerController dataAppCustomerController = Get.find();

  RegisterAgencyScreen({Key? key, required this.child}) : super(key: key);

  RegisterAgencyController registerAgencyController =
      RegisterAgencyController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => dataAppCustomerController.infoCustomer.value.isAgency == true &&
              dataAppCustomerController.infoCustomer.value.isAgency != null
          ? child
          : Scaffold(
              appBar: AppBar(
                title: Text("Điều khoản Đại lý"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Chính sách giá\n\nTrên ${StoreInfo().getCustomerStoreCode()}, toàn bộ sản phẩm đều có thể mua với giá được chiết khấu cao khi đăng ký trở thành Người Bán. Đồng thời Người Bán có thể nhận hoa hồng khi giới thiệu thành công cho bạn bè/ bên thứ ba mua sản phẩm trên ${StoreInfo().getCustomerStoreCode()}.\nBằng việc minh bạch thông tin sản phẩm và hướng dẫn chi tiết, ${StoreInfo().getCustomerStoreCode()} giúp người dùng tìm được sản phẩm tốt nhất cho mình và với những ai đam mê kinh doanh, ${StoreInfo().getCustomerStoreCode()} sẽ giúp bạn vận hành, tối ưu toàn diện công việc kinh doanh của mình."),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Chính sách đổi trả\n\nThời hạn đổi trả hàng hóa khi mua hàng tại ${StoreInfo().getCustomerStoreCode()} được thực hiện trong thời hạn 14 ngày kể từ khi nhận được yêu cầu đổi trả từ Khách hàng. ${StoreInfo().getCustomerStoreCode()} thực hiện theo phương thức một đổi một hoặc hoàn tiền bằng cách chuyển khoản vào tài khoản của khách hàng. Mọi chi phí phát sinh nếu có trong quá trình đổi trả hàng hóa sẽ do ${StoreInfo().getCustomerStoreCode()} chịu."),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Chính sách giao hàng\n\nViệc tính phí giao hàng sẽ được ${StoreInfo().getCustomerStoreCode()} niêm yết công khai rõ ràng cho mỗi lần giao sản phẩm. ${StoreInfo().getCustomerStoreCode()} sẽ thực hiện giao hàng đúng địa chỉ khách hàng yêu cầu và trong thời hạn từ 03 đến 07 ngày tùy địa điểm giao hàng được áp dụng. Nếu có bất kỳ sự phát sinh nào gây chậm trễ cho việc giao hàng, ${StoreInfo().getCustomerStoreCode()} sẽ thông báo ngay trong ngày cho Khách hàng để hai bên cùng giải quyết. "),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Nghĩa vụ chung của bên bán và bên mua\n\nMỗi giao dịch sẽ được thực hiện đầy đủ theo đúng quy định của pháp luật hiện hành. Mọi phát sinh khi mua bán hàng hóa được giao dịch theo phương thức thỏa thuận trực tiếp giữa hai bên hoặc theo Hợp đồng điện tử đã ký kết giữa bên bán và bên mua. Bên bán và bên mua phải thực hiện theo đúng quy định của pháp luật, thực hiện đầy đủ các quyền lợi và nghĩa vụ như cam kết khi phát sinh cho mỗi lần giao dịch mua bán hàng hóa."),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      text: "Chấp nhận điều khoản",
                      onPressed: () {
                         Get.to(()=>UpdateInfoAgencyScreen())!.then((value) {
                              if(value == "Success"){
                                registerAgencyController.registerAgency();
                              }
                            });
                        //registerAgencyController.registerAgency();
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class RegisterAgencyController extends GetxController {
  DataAppCustomerController dataAppCustomerController = Get.find();
  late AgencyWalletController agencyWalletController;
  Future<void> registerAgency() async {
    agencyWalletController = Get.find();
    try {
      var data = await CustomerRepositoryManager.agencyCustomerRepository
          .registerAgency(true);
      Future.delayed(Duration(milliseconds: 100), () async {
        await dataAppCustomerController.getInfoCustomer();
        await dataAppCustomerController.getBadge();
        agencyWalletController.getGeneralInfoPaymentAgency();
        agencyWalletController.getInfoAgency();
      });
     
      SahaAlert.showSuccess(message: "Đăng ký thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
