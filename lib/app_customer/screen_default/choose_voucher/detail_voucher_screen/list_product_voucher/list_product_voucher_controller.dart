import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ListProductVoucherController extends GetxController {
  final int voucherId;
  var loadInit = true.obs;
  var listProductVoucher = RxList<Product>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  ListProductVoucherController({required this.voucherId}) {
    getAllProductVoucher(isRefresh: true);
  }
  Future<void> getAllProductVoucher({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await CustomerRepositoryManager.marketingRepository
            .getAllProductVoucher(page: currentPage, voucherId: voucherId);

        if (isRefresh == true) {
          listProductVoucher(data!.data!.data!);
        } else {
          listProductVoucher.addAll(data!.data!.data!);
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
