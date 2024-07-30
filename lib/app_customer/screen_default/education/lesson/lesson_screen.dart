import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/model/lesson.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/lesson/lesson_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class LessonScreen extends StatelessWidget {
  late LessonController lessonController;
  int? idLesson;
  Lesson lessonInput;

  LessonScreen({required this.idLesson, required this.lessonInput}) {
    lessonController = LessonController(idLesson: idLesson!);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: Obx(
            () => lessonController.isLoading.value
                ? Center(child: SahaLoadingFullScreen())
                : youtubeLesson(context: context),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Bài học",
            ),
          ),
          body: Obx(
            () => lessonController.isLoading.value
                ? Center(child: SahaLoadingFullScreen())
                : youtubeLesson(context: context),
          ),
        );
      }
    });
  }

  youtubeLesson({required context}) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            if (lessonController.controller != null)
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: lessonController.controller!,
                  showVideoProgressIndicator: true,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      // some widgets
                      player,
                      //some other widgets
                    ],
                  );
                },
              ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bài học:',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          lessonInput.title ?? "",
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  HtmlWidget(
                    "${lessonController.lessonDetails.value.description ?? ""}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
