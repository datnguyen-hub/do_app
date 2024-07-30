import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/history_submit.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'detail/history_submit_detail_screen.dart';
import 'history_submit_controller.dart';

class HistorySubmitScreen extends StatelessWidget {
  int courseId;
  int quizId;

  HistorySubmitScreen({required this.courseId, required this.quizId}) {
    historySubmitController =
        HistorySubmitController(courseId: courseId, quizId: quizId);
  }

  late HistorySubmitController historySubmitController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử bài thi"),
      ),
      body: Obx(
        () => historySubmitController.isLoading.value
            ? SahaLoadingWidget()
            : historySubmitController.listHistorySubmit.isEmpty
                ? Center(child: Text('Chưa có lịch sử thi'))
                : SingleChildScrollView(
                    child: Column(
                      children: historySubmitController.listHistorySubmit
                          .map((e) => itemHistory(e))
                          .toList(),
                    ),
                  ),
      ),
    );
  }

  Widget itemHistory(HistorySubmit historySubmit) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => HistorySubmitDetailScreen(
                  historySubmit: historySubmit,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Thời gian làm bài:'),
                    Spacer(),
                    Text(
                        ' ${SahaDateUtils().secondsToHours(historySubmit.workTime ?? 0)}'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.all_inbox,
                      color: Colors.green,
                    ),
                    Text('Tổng số câu hỏi:'),
                    Spacer(),
                    Text(' ${historySubmit.totalQuestions ?? 0}'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Tổng số câu trả lời đúng:'),
                    Spacer(),
                    Text(' ${historySubmit.totalCorrectAnswer ?? 0}'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Thời gian nộp bài:'),
                    Spacer(),
                    Text(
                        ' ${SahaDateUtils().getHHMM(historySubmit.updatedAt ?? DateTime.now())} ${SahaDateUtils().getDDMMYY(historySubmit.updatedAt ?? DateTime.now())}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
