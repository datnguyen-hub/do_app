import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import '../../../components/toast/saha_alert.dart';
import '../../../model/quiz.dart';

class QuizController extends GetxController {
  var listQuiz = RxList<Quiz>();

  var loading = true.obs;

  int courseId;
  QuizController({required this.courseId}) {
    getAllQuiz();
  }

  Future<void> getAllQuiz() async {

    try {
      var data = await CustomerRepositoryManager.educationRepository
          .getAllQuiz(courseId: courseId);
      listQuiz(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
