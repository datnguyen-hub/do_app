import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/lesson.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonController extends GetxController {
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;

  int idLesson;
  YoutubePlayerController? controller;
  var lessonDetails = Lesson().obs;

  LessonController({required this.idLesson}) {
    getLesson();
  }

  Future<void> getLesson() async {
    isLoading.value = true;
    try {
      var res = await CustomerRepositoryManager.educationRepository.getLesson(
        idLesson: idLesson,
      );
      lessonDetails.value = res!.data!;
      var a = YoutubePlayer.convertUrlToId(
          lessonDetails.value.linkVideoYoutube ?? "");
      if (a != null) {
        controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(
                  lessonDetails.value.linkVideoYoutube ?? "") ??
              "",
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
      }
      print(lessonDetails.value.linkVideoYoutube);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void runYoutubePlayer() {}
}
