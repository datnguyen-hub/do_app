import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../model/history_submit.dart';

class HistorySubmitDetailScreen extends StatelessWidget {
  HistorySubmit historySubmit;

  HistorySubmitDetailScreen({required this.historySubmit});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded)),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        Text(
                            'Số câu đúng: ${historySubmit.totalCorrectAnswer ?? 0}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        Text('Số câu sai: ${historySubmit.totalWrongAnswer}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: (historySubmit.totalCorrectAnswer ?? 0) /
                  (historySubmit.totalQuestions == 0
                      ? 1
                      : (historySubmit.totalQuestions ?? 1)),
              color: Colors.green,
              backgroundColor: Colors.green.withOpacity(0.2),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...List.generate(
                  (historySubmit.historySubmitQuizzes ?? []).length, (index) {
                var e = (historySubmit.historySubmitQuizzes ?? [])[index];
                return InkWell(
                  onTap: () {
                    showDialogQuestion(e);
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: e.isValid == true
                            ? Colors.green.withOpacity(0.8)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            color: e.isValid == true ? Colors.white : null,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }

  void showDialogQuestion(HistorySubmitQuizz historySubmitQuizz) {
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (historySubmitQuizz.question?.questionImage != null &&
                    historySubmitQuizz.question!.questionImage != "")
                  CachedNetworkImage(
                    height: 200,
                    width: Get.width,
                    fit: BoxFit.cover,
                    imageUrl: historySubmitQuizz.question?.questionImage ?? "",
                    errorWidget: (context, url, error) => SahaEmptyAvata(),
                  ),
                SizedBox(
                  height: 10,
                ),
                Text(historySubmitQuizz.question?.question ?? ""),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: historySubmitQuizz.answerRequest == 'A'
                        ? Colors.green.withOpacity(0.2)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: historySubmitQuizz.answerRequest == 'A'
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
                      Expanded(child: Text(historySubmitQuizz.answerA ?? ""))
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: historySubmitQuizz.answerRequest == 'B'
                        ? Colors.green.withOpacity(0.2)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: historySubmitQuizz.answerRequest == 'B'
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
                      Expanded(child: Text(historySubmitQuizz.answerB ?? ""))
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: historySubmitQuizz.answerRequest == 'C'
                        ? Colors.green.withOpacity(0.2)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: historySubmitQuizz.answerRequest == 'C'
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
                      Expanded(child: Text(historySubmitQuizz.answerC ?? ""))
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: historySubmitQuizz.answerRequest == 'D'
                        ? Colors.green.withOpacity(0.2)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: historySubmitQuizz.answerRequest == 'D'
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
                      Expanded(child: Text(historySubmitQuizz.answerD ?? ""))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('   Đáp án đúng: ${historySubmitQuizz.rightAnswer ?? ""}')
              ],
            ),
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
  //
  // void showDialogTimeOut() {
  //   // flutter defined function
  //   showDialog(
  //     barrierDismissible: false,
  //     context: Get.context!,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               "Câu hỏi",
  //               style: TextStyle(fontSize: 17),
  //             ),
  //           ],
  //         ),
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //         contentPadding:
  //         EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
  //         alignment: Alignment.center,
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'Đã hết thời gian làm bài \nnộp bài bạn nhé!',
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         ),
  //         titlePadding: EdgeInsets.only(bottom: 10, top: 20),
  //         actionsAlignment: MainAxisAlignment.center,
  //         actionsPadding: EdgeInsets.all(0),
  //         actions: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               TextButton(
  //                 child: new Text("Nộp bài"),
  //                 onPressed: () {
  //                   controller.submitQuiz();
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
