import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/chapter.dart';
import 'package:sahashop_customer/app_customer/model/course_list.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ChapterController extends GetxController {
  var listChapter = RxList<Chapter>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  int idListCourses;
  CourseList courseList;

  ChapterController({required this.idListCourses, required this.courseList}) {
    getChaptter(isRefresh: true);
  }

  Future<void> getChaptter({
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
            .getChaptersAndLessons(
          idListCourses: idListCourses,
        );

        if (isRefresh == true) {
          listChapter(data!.data!);
          listChapter.refresh();
        } else {
          listChapter.addAll(data!.data!);
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }
}
