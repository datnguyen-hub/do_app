import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/payment_ctv_history.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class PaymentHistoryController extends GetxController {
  var listPaymentCtvHtr = RxList<PaymentCtvHistory>();
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;

  PaymentHistoryController() {
    getPaymentCtvHistory();
  }

  Future<void> getPaymentCtvHistory({bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listPaymentCtvHtr([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var data = await CustomerRepositoryManager.ctvCustomerRepository
            .getPaymentCtvHistory();

        data!.data!.data!.forEach((element) {
          listPaymentCtvHtr.add(element);
        });

        if (data.data!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }

      } else {
        isLoadMore.value = false;
        return;
      }

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadMore.value = false;
    isLoadRefresh.value = false;
  }
}
