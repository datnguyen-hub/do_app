import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/report_rose.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ReportRoseController extends GetxController {
  var listReportRose = RxList<ReportRose>();
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;

  ReportRoseController() {
    getReportRose();
  }

  Future<void> getReportRose({bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listReportRose([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var res = await CustomerRepositoryManager.agencyCustomerRepository
            .getReportAgencyRose(currentPage);

        res!.data!.data!.forEach((element) {
          listReportRose.add(element);
        });

        if (res.data!.nextPageUrl != null) {
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

  Future<void> receiveMoneyCtv({required int year, required int month}) async {
    try {
      var data = await CustomerRepositoryManager.ctvCustomerRepository
          .receiveMoneyCtv(year, month);
      SahaAlert.showSuccess(message: "Nhận thưởng thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
