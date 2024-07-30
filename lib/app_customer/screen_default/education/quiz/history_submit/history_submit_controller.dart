import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/history_submit.dart';

import '../../../../components/toast/saha_alert.dart';
import '../../../../repository/repository_customer.dart';

class HistorySubmitController extends GetxController {

  var listHistorySubmit = RxList<HistorySubmit>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  int courseId;
  int quizId;

  HistorySubmitController({required this.courseId, required this.quizId}) {
    getAllCourse(isRefresh: true);
  }

  Future<void> getAllCourse({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await CustomerRepositoryManager.educationRepository
            .getAllHistorySubmit(
          courseId: courseId, quizId:quizId,
          page: currentPage,
        );

        if (isRefresh == true) {
          listHistorySubmit(data!.data!.data!);
          listHistorySubmit.refresh();
        } else {
          listHistorySubmit.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }
}