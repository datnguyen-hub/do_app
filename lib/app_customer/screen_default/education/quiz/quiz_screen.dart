import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/quiz/quiz_controller.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../model/quiz.dart';
import 'history_submit/history_submit_screen.dart';
import 'quiz_submit/quiz_submit_sreen.dart';

class QuizScreen extends StatelessWidget {
  int courseId;

  QuizScreen({required this.courseId}) {
    quizController = QuizController(courseId: courseId);
  }

  late QuizController quizController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách bài thi"),
      ),
      body: Obx(
        () => quizController.loading.value
            ? SahaLoadingFullScreen()
            : quizController.listQuiz.isEmpty
                ? Center(
                    child: Text('Chưa có bài thi'),
                  )
                : SingleChildScrollView(
                    child: Column(
                        children: quizController.listQuiz
                            .map((e) => itemQuiz(e))
                            .toList()),
                  ),
      ),
    );
  }

  Widget itemQuiz(Quiz quiz) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => QuizSubmitScreen(
                      courseId: courseId,
                      quizId: quiz.id ?? 0,
                    ))!
                .then((value) => {quizController.getAllQuiz()});
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bài thi: ${quiz.title ?? ""}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${quiz.shortDescription ?? ""}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Thời lượng: ${quiz.minute ?? "0"} phút'),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: (quiz.lastSubmitQuiz
                                            ?.totalCorrectAnswer ??
                                        1) /
                                    ((quiz.lastSubmitQuiz?.totalQuestions ?? 0) == 0 ? 1 : (quiz.lastSubmitQuiz?.totalQuestions ?? 1)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${((quiz.lastSubmitQuiz?.totalCorrectAnswer ?? 0) / ((quiz.lastSubmitQuiz?.totalQuestions ?? 0) == 0 ? 1 : (quiz.lastSubmitQuiz?.totalQuestions ?? 1))* 100)} % đã hoàn thành',
                            style: TextStyle(
                              color: Theme.of(Get.context!).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.navigate_next_rounded)
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Text('Làm bài thi'),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(() => HistorySubmitScreen(
                              courseId: courseId,
                              quizId: quiz.id ?? 0,
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Text('Lịch sử bài thi'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[200],
        )
      ],
    );
  }
}
