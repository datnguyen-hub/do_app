import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/response-request/education/all_history_submit_res.dart';
import '../../remote/response-request/education/all_quiz_res.dart';
import '../../remote/response-request/education/course_list_res.dart';
import '../../remote/response-request/education/history_submit_res.dart';
import '../../remote/response-request/education/list_chapter_and_lesson.dart';
import '../../remote/response-request/education/list_lesson_res.dart';
import '../../remote/response-request/education/quiz_res.dart';
import '../../remote/response-request/education/submit_req.dart';

class EducationRepository {
  Future<CourseListRes?> getAllCourseList({required int currentPage}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllCourseList(StoreInfo().getCustomerStoreCode(), currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ListChapterAndLessonRes?> getChaptersAndLessons(
      {required int idListCourses}) async {
    try {
      var res = await CustomerServiceManager().service!.getChaptersAndLessons(
          StoreInfo().getCustomerStoreCode(), idListCourses);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ListLessonRes?> getLesson({required int idLesson}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getLesson(StoreInfo().getCustomerStoreCode(), idLesson);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllQuizRes?> getAllQuiz({required int courseId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllQuiz(StoreInfo().getCustomerStoreCode(), courseId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<QuizRes?> getQuiz({required int courseId,required int quizId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getQuiz(StoreInfo().getCustomerStoreCode(), courseId,quizId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllHistorySubmitRes?> getAllHistorySubmit({required int courseId,required int quizId,required int page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllHistorySubmit(StoreInfo().getCustomerStoreCode(), courseId,quizId, page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<HistorySubmitRes?> submitQuiz({required int courseId,required int quizId, required SubmitReq submitReq}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .submitQuiz(StoreInfo().getCustomerStoreCode(), courseId,quizId, submitReq.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

}
