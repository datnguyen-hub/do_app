import 'package:get/get.dart';

import '../../../components/toast/saha_alert.dart';
import '../../../model/info_customer.dart';
import '../../../repository/repository_customer.dart';

class CtvIntroduceController extends GetxController{
   var listInfoCustomer = RxList<InfoCustomer>();
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
    int indexTabTime = 0;
  int indexChooseTime = 0;
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  bool? isNeedHanding;

  CtvIntroduceController() {
    getAllCollaborator(isRefresh: true);
  }

  Future<void> getAllCollaborator({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await CustomerRepositoryManager.agencyCustomerRepository
            .getAllCollaborator(
          currentPage,
          timeFrom: fromDay.value,
          timeTo: toDay.value
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