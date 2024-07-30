import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:video_player/video_player.dart';

import '../image/show_image.dart';

class VideoReview extends StatefulWidget {
  const VideoReview({super.key, required this.linkVideo});
  final String linkVideo;
  @override
  State<VideoReview> createState() => _VideoReviewState();
}

class _VideoReviewState extends State<VideoReview> {
  VideoPlayerController? controllerInit;
  @override
  void initState() {
    initVideo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controllerInit!.dispose();
  }

  Future<void> initVideo() async {
    try {
      controllerInit = VideoPlayerController.network(
        widget.linkVideo,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
      )..initialize().then((value) => Future.delayed(const Duration(milliseconds: 500),(){
        setState(() {
          
        });
      }));

   

    
    } catch (e) {
      print("============>${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 60,
      width: 60,
      child: controllerInit!.value.isInitialized ? InkWell(
        onTap: () {
          ShowImage.seeImageWithVideo(
              listImageUrl: [],
              linkVideo: widget.linkVideo,
              //durationInitVideo: widget.controllerInit?.value.position,
              index: 0);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: VideoPlayer(controllerInit!),
                ),
              ),
            ),
            // ControlsOverlay(
            //     controller: controllerInit!,
            //     reload: (v) {
            //       print(v);
            //       setState(() {});
            //     }),
            // VideoProgressIndicator(
            //     VideoPlayerController
            //         .network(
            //       starPageController
            //               .listReview[
            //                   indexCustomer]
            //               .videoUrl ??
            //           "",
            //       videoPlayerOptions:
            //           VideoPlayerOptions(
            //               mixWithOthers:
            //                   true),
            //     )..initialize(),
            //     allowScrubbing:
            //         true),
          ],
        ),
      ): SahaLoadingWidget()
    ) ;
  }
}
