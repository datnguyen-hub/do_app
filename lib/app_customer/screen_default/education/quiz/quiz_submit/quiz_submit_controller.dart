import 'package:custom_timer/custom_timer.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/question.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/education/submit_req.dart';

import '../../../../components/toast/saha_alert.dart';
import '../../../../model/quiz.dart';
import '../../../../repository/repository_customer.dart';

class QuizSubmitController extends GetxController {
  CustomTimerController controllerTimer = CustomTimerController();

  var loading = true.obs;
  var indexCurrent = 0.obs;
  var isChoose = false.obs;
  var isSubmiting = false.obs;

  var quiz = Quiz().obs;

  var submitReq = SubmitReq().obs;

  var listQuestion = RxList<Question>();

  int courseId;
  int quizId;

  Duration durationWork = Duration();
  QuizSubmitController({required this.courseId, required this.quizId}) {
    submitReq.value.answers = [];
    print(controllerTimer.state);

    getQuiz();
  }
  @override
  onClose () {
    print("close");
    controllerTimer.dispose();
  }

  Future<void> submitQuiz() async {
    isSubmiting.value = true;
    submitReq.value.workTime =
        Duration(minutes: quiz.value.minute ?? 0).inSeconds -
            durationWork.inSeconds;
    print(submitReq.value.workTime);
    print(Duration(minutes: quiz.value.minute ?? 0).inSeconds);
    print(durationWork.inSeconds);
    submitReq.value.defineSortAnswers = quiz.value.defineSortAnswers;
    try {
      var data = await CustomerRepositoryManager.educationRepository.submitQuiz(
          courseId: courseId, quizId: quizId, submitReq: submitReq.value);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isSubmiting.value = false;
  }

  void chooseAnswer(AnswerReq answerReq, String answer) {
    if (checkChooseAnswer(answer)) {
      submitReq.value.answers!
          .removeWhere((e) => e.questionId == answerReq.questionId);
    } else {
      var index = (submitReq.value.answers ?? [])
          .map((e) => e.questionId)
          .toList()
          .indexWhere((e) => e == listQuestion[indexCurrent.value].questionId);

      if (index != -1) {
        submitReq.value.answers!.removeAt(index);
        submitReq.value.answers!.add(answerReq);
      } else {
        submitReq.value.answers!.add(answerReq);
      }
    }
    hasChoose();
    submitReq.refresh();
    listQuestion.refresh();
  }

  bool checkChooseAnswer(String answer) {
    var index = (submitReq.value.answers ?? [])
        .map((e) => e.questionId)
        .toList()
        .indexWhere((e) => e == listQuestion[indexCurrent.value].questionId);

    if (index != -1) {
      if ((submitReq.value.answers ?? [])[index].answer == answer) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool hasChoose() {
    if ((submitReq.value.answers ?? [])
        .map((e) => e.questionId)
        .contains(listQuestion[indexCurrent.value].questionId)) {
      isChoose.value = true;
      return true;
    } else {
      isChoose.value = false;
      return false;
    }
  }

  bool hasChooseQuestionId(int questionId) {
    if ((submitReq.value.answers ?? [])
        .map((e) => e.questionId)
        .contains(questionId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getQuiz() async {
    try {
      var data = await CustomerRepositoryManager.educationRepository
          .getQuiz(courseId: courseId, quizId: quizId);
      quiz.value = data!.data!;
      listQuestion(data.data!.questions);
      controllerTimer.start();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
