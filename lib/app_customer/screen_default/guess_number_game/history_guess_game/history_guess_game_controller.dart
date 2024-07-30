import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/all_history_guess_number_res.dart';

import '../../../components/toast/saha_alert.dart';
import '../../../repository/repository_customer.dart';

class HistoryGuessGameController extends GetxController {
  var listHistory = RxList<HistoryGuessNumber>();
  int currentPage = 1;

  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  int gameId;

  HistoryGuessGameController({required this.gameId}) {
    getAllHistoryGuessNumber(isRefresh: true);
  }

  Future<void> getAllHistoryGuessNumber({
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
            .getAllHistoryGuessNumber(page: currentPage, gameId: gameId);

        if (isRefresh == true) {
          listHistory(data!.data!.data!);
          listHistory.refresh();
        } else {
          listHistory.addAll(data!.data!.data!);
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
