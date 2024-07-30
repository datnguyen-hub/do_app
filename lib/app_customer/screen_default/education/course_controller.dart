import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/course_list.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class CourseController extends GetxController {
  var listCourse = RxList<CourseList>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;

  CourseController() {
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
            .getAllCourseList(
          currentPage: currentPage,
        );

        if (isRefresh == true) {
          listCourse(data!.data!.data!);
          listCourse.refresh();
        } else {
          listCourse.addAll(data!.data!.data!);
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
