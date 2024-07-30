
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/info_customer.dart';

class CodeRetroduceController extends GetxController {
  DataAppCustomerController dataAppCustomerController = Get.find();

  CodeRetroduceController() {
    getAllReferral();
  }

  Future<void> onShare(
    String? phone,
    String? appName,
  ) async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    await Share.share(
        "Mời bạn tải ứng dụng ${appName ?? "DoApp"}, nhập mã giới thiệu $phone để nhận ngay các phần quà mới hấp dẫn. Tải ứng dụng tại đây https://${(dataAppCustomerController.badge.value.domain ?? "") == '' ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain!.contains('https://') ? dataAppCustomerController.badge.value.domain!.replaceAll('https://', '') : dataAppCustomerController.badge.value.domain}/qr-app?cid=${dataAppCustomerController.infoCustomer.value.id}",
        subject: "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  var listInfoCustomer = RxList<InfoCustomer>([]);
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;

  Future<void> getAllReferral({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data =
            await CustomerRepositoryManager.scoreRepository.getAllReferral(
          page: currentPage,
        );

        if (isRefresh == true) {
          listInfoCustomer(data!.data!.data!);
        } else {
          listInfoCustomer.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
