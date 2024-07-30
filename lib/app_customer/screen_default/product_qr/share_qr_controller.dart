import 'package:get/get.dart';

import '../../utils/store_info.dart';
import '../data_app_controller.dart';

class ProductQrController extends GetxController {
  DataAppCustomerController dataAppCustomerController = Get.find();
  String linkQr({int? productId, int? postId}) {
    if (productId != null) {
      if (dataAppCustomerController.isLogin.value == true) {
        return 'https://${(dataAppCustomerController.badge.value.domain ?? "") == '' ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain!.contains('https://') ? dataAppCustomerController.badge.value.domain!.replaceAll('https://', '') : dataAppCustomerController.badge.value.domain}/qr-app?action=product&references_id=${productId}&cid=${dataAppCustomerController.infoCustomer.value.id}';
      } else {
        return 'https://${(dataAppCustomerController.badge.value.domain ?? "") == '' ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain!.contains('https://') ? dataAppCustomerController.badge.value.domain!.replaceAll('https://', '') : dataAppCustomerController.badge.value.domain}/qr-app?action=product&references_id=${productId}';
      }
    }

    if (postId != null) {
      if (dataAppCustomerController.isLogin.value == true) {
        return 'https://${(dataAppCustomerController.badge.value.domain ?? "") == '' ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain!.contains('https://') ? dataAppCustomerController.badge.value.domain!.replaceAll('https://', '') : dataAppCustomerController.badge.value.domain}/qr-app?action=post&references_id=${postId}&cid=${dataAppCustomerController.infoCustomer.value.id}';
      } else {
        return 'https://${(dataAppCustomerController.badge.value.domain ?? "") == '' ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain!.contains('https://') ? dataAppCustomerController.badge.value.domain!.replaceAll('https://', '') : dataAppCustomerController.badge.value.domain}/qr-app?action=post&references_id=${postId}';
      }
    } else {
      return '';
    }
  }
  
}
