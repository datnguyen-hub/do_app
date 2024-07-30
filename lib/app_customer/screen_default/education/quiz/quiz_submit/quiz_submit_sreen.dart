import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../remote/response-request/education/submit_req.dart';
import '../../../../utils/debounce.dart';
import 'quiz_submit_controller.dart';

class QuizSubmitScreen extends StatefulWidget {
  int courseId;
  int quizId;

  QuizSubmitScreen({required this.courseId, required this.quizId}) {
    controller = QuizSubmitController(courseId: courseId, quizId: quizId);
  }
  late QuizSubmitController controller;

  @override
  State<QuizSubmitScreen> createState() => _QuizSubmitScreenState();
}

class _QuizSubmitScreenState extends State<QuizSubmitScreen> {
  @override
  void dispose() {
    widget.controller.controllerTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => widget.controller.loading.value
          ? Scaffold(body: SahaLoadingFullScreen())
          : Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                Obx(
                                  () => Text(
                                      'Đã trả lời: ${widget.controller.submitReq.value.answers?.length ?? 0}'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                Obx(
                                  () => Text(
                                      'Chưa trả lời: ${widget.controller.listQuestion.length - (widget.controller.submitReq.value.answers?.length ?? 0)}'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (widget.controller.listQuestion.length ==
                                      widget.controller.submitReq.value.answers!
                                          .length) {
                                  } else {
                                    SahaDialogApp.showDialogYesNo(
                                        mess:
                                            'Bạn chưa hoàn thành bài thi, Vẫn muốn nộp bài',
                                        onOK: () {
                                          if (widget.controller.isSubmiting
                                                  .value ==
                                              false) {
                                            widget.controller.submitQuiz();
                                          }
                                        });
                                  }
                                },
                                child: Text('Nộp bài')),
                            CustomTimer(
                              controller: widget.controller.controllerTimer,
                              begin: Duration(
                                  minutes:
                                      widget.controller.quiz.value.minute ?? 0),
                              end: Duration(),
                              builder: (time) {
                                widget.controller.durationWork = Duration(
                                    hours: int.parse(time.hours),
                                    minutes: int.parse(time.minutes),
                                    seconds: int.parse(time.seconds));

                                if (widget.controller.durationWork.inSeconds ==
                                    1) {
                                  EasyDebounce.debounce('debounce_timer_edu',
                                      Duration(milliseconds: 500), () {
                                    Future.delayed(Duration(milliseconds: 1000),
                                        () {
                                      showDialogTimeOut();
                                    });
                                  });
                                }

                                return Text(
                                    "${time.hours} : ${time.minutes} : ${time.seconds}",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogYesNo(
                                  mess:
                                      'Bạn chưa hoàn thành bài thi bạn vẫn muốn dừng chứ ?',
                                  onOK: () {
                                    Get.back();
                                  });
                            },
                            child: Icon(
                              Icons.pause,
                              color: Colors.red,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => LinearProgressIndicator(
                        value: (widget
                                .controller.submitReq.value.answers!.length) /
                            (widget.controller.listQuestion.length == 0
                                ? 1
                                : widget.controller.listQuestion.length),
                        color: Colors.green,
                        backgroundColor: Colors.green.withOpacity(0.2),
                      ),
                    ),
                  ),
                  Expanded(child: boxQuestion()),
                ],
              ),
              bottomNavigationBar: Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    Obx(
                      () => SahaButtonFullParent(
                        text: widget.controller.listQuestion.length ==
                                widget
                                    .controller.submitReq.value.answers!.length
                            ? 'NỘP BÀI'
                            : widget.controller.isChoose.value == true
                                ? "CÂU TIẾP THEO"
                                : "BỎ QUA",
                        textColor: widget.controller.listQuestion.length ==
                                widget
                                    .controller.submitReq.value.answers!.length
                            ? Colors.white
                            : widget.controller.isChoose.value == true
                                ? Colors.white
                                : Colors.black87,
                        onPressed: widget.controller.isSubmiting.value
                            ? null
                            : () {
                                if (widget.controller.indexCurrent.value <
                                    widget.controller.listQuestion.length - 1) {
                                  widget.controller.indexCurrent.value =
                                      widget.controller.indexCurrent.value + 1;
                                  widget.controller.listQuestion.refresh();
                                  widget.controller.hasChoose();
                                }
                                if (widget.controller.listQuestion.length ==
                                    widget.controller.submitReq.value.answers!
                                        .length) {
                                  widget.controller.submitQuiz();
                                }
                              },
                        color: widget.controller.listQuestion.length ==
                                widget
                                    .controller.submitReq.value.answers!.length
                            ? Colors.green
                            : widget.controller.isChoose.value == true
                                ? Colors.green.withOpacity(0.9)
                                : Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget boxQuestion() {
    return Obx(
      () => widget.controller.listQuestion.isEmpty
          ? Text("Không có câu hỏi")
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Câu ${widget.controller.indexCurrent.value + 1}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              showDialogQuestion();
                            },
                            child: Text(
                              'Tất cả',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((widget
                                .controller
                                .listQuestion[
                                    widget.controller.indexCurrent.value]
                                .questionImage) !=
                            null &&
                        widget
                                .controller
                                .listQuestion[
                                    widget.controller.indexCurrent.value]
                                .questionImage !=
                            "")
                      CachedNetworkImage(
                        height: 300,
                        width: Get.width,
                        fit: BoxFit.cover,
                        imageUrl: widget
                                .controller
                                .listQuestion[
                                    widget.controller.indexCurrent.value]
                                .questionImage ??
                            "",
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget
                                .controller
                                .listQuestion[
                                    widget.controller.indexCurrent.value]
                                .question ??
                            "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.chooseAnswer(
                            AnswerReq(
                                questionId: widget
                                    .controller
                                    .listQuestion[
                                        widget.controller.indexCurrent.value]
                                    .questionId,
                                answer: 'A'),
                            'A');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.controller.checkChooseAnswer('A')
                              ? Colors.green.withOpacity(0.2)
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      widget.controller.checkChooseAnswer('A')
                                          ? Colors.green
                                          : Colors.grey[400],
                                  shape: BoxShape.circle),
                              child: Text(
                                'A',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(widget
                                        .controller
                                        .listQuestion[widget
                                            .controller.indexCurrent.value]
                                        .answers
                                        ?.a ??
                                    ""))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.chooseAnswer(
                            AnswerReq(
                                questionId: widget
                                    .controller
                                    .listQuestion[
                                        widget.controller.indexCurrent.value]
                                    .questionId,
                                answer: 'B'),
                            'B');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.controller.checkChooseAnswer('B')
                              ? Colors.green.withOpacity(0.2)
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      widget.controller.checkChooseAnswer('B')
                                          ? Colors.green
                                          : Colors.grey[400],
                                  shape: BoxShape.circle),
                              child: Text(
                                'B',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(widget
                                        .controller
                                        .listQuestion[widget
                                            .controller.indexCurrent.value]
                                        .answers
                                        ?.b ??
                                    ""))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.chooseAnswer(
                            AnswerReq(
                                questionId: widget
                                    .controller
                                    .listQuestion[
                                        widget.controller.indexCurrent.value]
                                    .questionId,
                                answer: 'C'),
                            'C');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.controller.checkChooseAnswer('C')
                              ? Colors.green.withOpacity(0.2)
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      widget.controller.checkChooseAnswer('C')
                                          ? Colors.green
                                          : Colors.grey[400],
                                  shape: BoxShape.circle),
                              child: Text(
                                'C',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(widget
                                        .controller
                                        .listQuestion[widget
                                            .controller.indexCurrent.value]
                                        .answers
                                        ?.c ??
                                    ""))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.chooseAnswer(
                            AnswerReq(
                                questionId: widget
                                    .controller
                                    .listQuestion[
                                        widget.controller.indexCurrent.value]
                                    .questionId,
                                answer: 'D'),
                            'D');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.controller.checkChooseAnswer('D')
                              ? Colors.green.withOpacity(0.2)
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      widget.controller.checkChooseAnswer('D')
                                          ? Colors.green
                                          : Colors.grey[400],
                                  shape: BoxShape.circle),
                              child: Text(
                                'D',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(widget
                                        .controller
                                        .listQuestion[widget
                                            .controller.indexCurrent.value]
                                        .answers
                                        ?.d ??
                                    ""))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void showDialogQuestion() {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Câu hỏi",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(
                    widget.controller.listQuestion.length,
                    (index) => InkWell(
                      onTap: () {
                        widget.controller.indexCurrent.value = index;
                        widget.controller.listQuestion.refresh();
                        Get.back();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: widget.controller.hasChooseQuestionId(widget
                                    .controller.listQuestion[index].questionId!)
                                ? Colors.green.withOpacity(0.8)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                color: widget.controller.hasChooseQuestionId(
                                        widget.controller.listQuestion[index]
                                            .questionId!)
                                    ? Colors.white
                                    : null,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          titlePadding: EdgeInsets.only(bottom: 10, top: 20),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: new Text("Thoát"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showDialogTimeOut() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Câu hỏi",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Đã hết thời gian làm bài \nnộp bài bạn nhé!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          titlePadding: EdgeInsets.only(bottom: 10, top: 20),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: new Text("Nộp bài"),
                  onPressed: () {
                    if (widget.controller.isSubmiting.value == false) {
                      widget.controller.submitQuiz();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
