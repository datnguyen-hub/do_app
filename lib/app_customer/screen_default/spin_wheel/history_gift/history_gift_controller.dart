import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/all_history_gift_res.dart';

import '../../../components/toast/saha_alert.dart';
import '../../../repository/repository_customer.dart';

class HistoryGiftController extends GetxController {
  var listGift = RxList<HistoryGift>();
  int currentPage = 1;

  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  int gameId;

  HistoryGiftController({required this.gameId}) {
    getAllHistoryGift(isRefresh: true);
  }

  Future<void> getAllHistoryGift({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await CustomerRepositoryManager.miniGameRepository
            .getAllHistoryGift(page: currentPage, gameId: gameId);

        if (isRefresh == true) {
          listGift(data!.data!.data!);
          listGift.refresh();
        } else {
          listGift.addAll(data!.data!.data!);
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
    ;
  }
}
