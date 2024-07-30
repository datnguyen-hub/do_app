import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../product_qr/share_qr_screen.dart';
import 'input_model_post.dart';
import 'read_post_controller.dart';

// ignore: must_be_immutable
class ReadPostScreen extends StatelessWidget {
  InputModelPost? inputModelPost;
  late PostController postController;

  ReadPostScreen({this.inputModelPost}) {
    postController = PostController(inputModelPost);
  }

  //Html? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tin tức"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => ShareQrScreen(
                                    idPost:
                                        postController.postShow.value.id ?? 0,
                                  ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Chia sẻ bằng QR",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              postController.onShare([
                                postController.postShow.value.imageUrl ?? ""
                              ]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Chia sẻ khác",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Obx(
        () => postController.isLoadingPost.value
            ? SahaLoadingWidget()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      height: Get.height * 0.24,
                      width: Get.width,
                      fit: BoxFit.cover,
                      imageUrl: postController.postShow.value.imageUrl ?? "",
                      errorWidget: (context, url, error) => SahaEmptyImage(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tin tức ngày: ${SahaDateUtils().getDDMMYY(postController.postShow.value.updatedAt ?? DateTime.now())}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "${postController.postShow.value.title ?? ""}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: HtmlWidget(
                         postController.postShow.value.content ?? "",
                        // postController.removeIframesFromHtmlString(
                        //     postController.postShow.value.content ?? ""),
                        onTapUrl: (v) async {
                          print("=======<<<<<<>>>>>> $v");
                          final url = Uri.parse(v);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                          return true;
                        },
                        onTapImage:(ImageMetadata v) async{
                           final url = Uri.parse(v.sources.first.url);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                          return null;
                        },
                        factoryBuilder: () {
                          return WidgetFactory();
                        },
                      ),
                    ),

                    //               SizedBox(
                    //                   height: 300,
                    //                   width: Get.width,
                    //                   child: InAppWebView(
                    //                     initialUrlRequest: URLRequest(
                    //                       url: Uri.dataFromString(
                    //                         '''
                    //   <!DOCTYPE html>
                    //   <html>
                    //     <body>
                    //       <iframe width="560" height="315" src="https://www.youtube.com/embed/40hBQox16YE" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    //     </body>
                    //   </html>
                    // ''',
                    //                         mimeType: 'text/html',
                    //                       ),
                    //                     ),
                    //                   )),
                    // SizedBox(
                    //   height: 300,
                    //   child: InAppWebView(
                    //     // initialFile: htmlFilePath,
                    //     // key: Key(
                    //     //     "${timekeepingHistoryDetailController.detail.value.mapLong}"),
                    //     initialData: InAppWebViewInitialData(
                    //       data: ''' <!DOCTYPE html>
                    //     <html>
                    //       <body>
                    //         <iframe width="560" height="315" src="https://www.youtube.com/embed/40hBQox16YE" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    //       </body>
                    //     </html>
                    //   ''',
                    //     ),
                    //     initialOptions: InAppWebViewGroupOptions(
                    //       crossPlatform: InAppWebViewOptions(
                    //         // debuggingEnabled: true,
                    //         javaScriptEnabled: true,
                    //         userAgent:
                    //             "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
                    //       ),
                    //     ),

                    //     onLoadError: (controller, error, a, s) {
                    //       print("load error ${error.toString()} , $a, $s");
                    //     },
                    //   ),
                    // ),
                    // ...postController.listLinkVideo
                    //     .map((e) => videoPlayer(linkVideo: e))
                  ],
                ),
              ),
      ),
    );
  }

  Widget videoPlayer({required String linkVideo}) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(linkVideo) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        print('in fullscreen');
      },
      onExitFullScreen: () {
        print('out fullscreen');
      },
      builder: (context, player) {
        return player;
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
