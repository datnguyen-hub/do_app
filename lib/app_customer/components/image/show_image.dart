import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../empty/saha_empty_image.dart';

class ShowImage {
  Future<void> downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'image.png'; // Tên tệp ảnh lưu trữ
        final filePath = '${appDir.path}/$fileName';

        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await GallerySaver.saveImage(file.path);
      } catch (e) {
        print("===& $e");
      }
    } else {
      throw Exception('Lỗi tải ảnh: ${response.statusCode}');
    }
  }

   void seeImage({
    List<String>? listImageUrl,
    int? index,
  }) {
    PageController _pageController = PageController(initialPage: index!);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        
        return Stack(
          children: [
            InkWell(
              onLongPress: () async {
                showModalBottomSheet(
                    context: Get.context!,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.download,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Tải ảnh',
                            ),
                            onTap: () async {
                              String path = listImageUrl[index];

                              await downloadImage(path);
                              SahaAlert.showSuccess(message: "Đã lưu");
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.download,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Tải toàn bộ ảnh',
                            ),
                            onTap: () {
                              listImageUrl.forEach((e) {
                                String path = e;
                                downloadImage(path);
                              });
                              SahaAlert.showSuccess(message: "Đã lưu");
                              Get.back();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    });
              },
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: _pageController,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    minScale: 0.0,
                    imageProvider: NetworkImage(listImageUrl[index] ?? ""),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: listImageUrl[index] ?? "error$index"),
                  );
                },
                itemCount: listImageUrl!.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.white,
                ),
              ),
              top: 60,
              right: 20,
            )
          ],
        );
      },
    );
  }

   static void seeImageWithVideo({
    List<String>? listImageUrl,
    String? linkVideo,
    int? index,
    Duration? durationInitVideo,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return PageViewVideoImage(
          linkVideo: linkVideo,
          listImageUrl: listImageUrl,
          index: index,
          durationInitVideo: durationInitVideo,
        );
      },
    );
  }
}

class PageViewVideoImage extends StatefulWidget {
  PageViewVideoImage(
      {Key? key,
      this.listImageUrl,
      this.linkVideo,
      this.index,
      this.durationInitVideo})
      : super(key: key);
  List<String>? listImageUrl;
  String? linkVideo;
  int? index;
  Duration? durationInitVideo;
  @override
  State<PageViewVideoImage> createState() => _PageViewVideoImageState();
}

class _PageViewVideoImageState extends State<PageViewVideoImage> {
  VideoPlayerController? controllerInit;
  late PageController pageController;
  late int indexImage;

   Future<void> downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'image.png'; // Tên tệp ảnh lưu trữ
        final filePath = '${appDir.path}/$fileName';

        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await GallerySaver.saveImage(file.path);
      } catch (e) {
        print("===& $e");
      }
    } else {
      throw Exception('Lỗi tải ảnh: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    indexImage = widget.index ?? 0;
    print(widget.linkVideo);
    pageController = PageController(initialPage: widget.index ?? 0);
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
      controllerInit!.setLooping(true);
      await controllerInit!.initialize();
      if (widget.durationInitVideo != null) {
        controllerInit!.seekTo(widget.durationInitVideo!);
      }

      controllerInit!.play();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose controller init');
    if (controllerInit != null) {
      controllerInit!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
   
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (v) {
              controllerInit?.pause();
            },
            controller: pageController,
            children: [
              if (widget.linkVideo != null)
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: controllerInit?.value.size.width ?? 0,
                      height: controllerInit?.value.size.height ?? 0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          VideoPlayer(controllerInit!),
                          ControlsOverlay(
                              controller: controllerInit!,
                              reload: (v) {
                                print(v);
                                setState(() {});
                              }),
                          VideoProgressIndicator(controllerInit!,
                              allowScrubbing: true),
                        ],
                      ),
                    ),
                  ),
                ),
              ...(widget.listImageUrl ?? [])
                  .map(
                    (e) => InkWell(
                      onLongPress: (){
                          showModalBottomSheet(
                    context: Get.context!,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // ListTile(
                          //   leading: Icon(
                          //     Icons.download,
                          //     color: Colors.blue,
                          //   ),
                          //   title: Text(
                          //     'Tải ảnh',
                          //   ),
                          //   onTap: () async {
                          //     String path = widget.listImageUrl![indexImage];
                          //     print(widget.listImageUrl![indexImage]);
                          //     await downloadImage(path);
                          //     SahaAlert.showSuccess(message: "Đã lưu");
                          //     Get.back();
                          //   },
                          // ),
                          ListTile(
                            leading: Icon(
                              Icons.download,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Tải toàn bộ ảnh',
                            ),
                            onTap: () async {
                                for (int i = 0;
                                  i < (widget.listImageUrl ?? []).length;
                                  i++) {
                                String path = widget.listImageUrl![i];
                              
                                await downloadImage(path);
                              }
                              SahaAlert.showSuccess(message: "Đã lưu");
                              Get.back();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    });
                      },
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 1.6,
                        child: CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          imageUrl: e,
                          //placeholder: (context, url) => const SahaLoadingContainer(),
                          errorWidget: (context, url, error) =>
                              const SahaEmptyImage(),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
          Positioned(
            top: 50,
            right: 10,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ))),
          ),
        ],
      ),
    );
  }
}

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay(
      {Key? key, required this.controller, required this.reload})
      : super(key: key);

  final VideoPlayerController controller;
  final Function reload;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
            reload(controller.value.isPlaying);
          },
        ),
      ],
    );
  }
}
