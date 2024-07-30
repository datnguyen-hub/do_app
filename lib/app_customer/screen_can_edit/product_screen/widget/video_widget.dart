import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import '../../../components/image/show_image.dart';

class VideoProduct extends StatefulWidget {
  VideoProduct({super.key, this.linkVideo,this.listImageUrl});

  final String? linkVideo;
  final List<String>? listImageUrl;

  @override
  State<VideoProduct> createState() => _VideoProductState();
}

class _VideoProductState extends State<VideoProduct> {
   late VideoPlayerController controllerInit;
    @override
  void initState() {

    initVideo();
    super.initState();
  }

  Future<void> initVideo() async {
    if (widget.linkVideo != null) {
      print(widget.linkVideo);
      controllerInit = VideoPlayerController.network(
        widget.linkVideo ?? "",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
     controllerInit.setLooping(true);

      await controllerInit.initialize();
      //await widget.controllerInit!.play();
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      controllerInit.pause();
        ShowImage.seeImageWithVideo(
            listImageUrl: widget.listImageUrl,
            linkVideo: widget.linkVideo,
            durationInitVideo: controllerInit.value.position,
            index: 0);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                width: controllerInit.value.size.width ,
                height: controllerInit.value.size.height ,
                child: VideoPlayer(controllerInit),
              ),
            ),
          ),
          // ControlsOverlay(
          //     controller: controllerInit!,
          //     reload: (v) {
          //       print(v);
          //       setState(() {});
          //     }),
          VideoProgressIndicator(controllerInit, allowScrubbing: true),
        ],
      ),
    );
  }
}
