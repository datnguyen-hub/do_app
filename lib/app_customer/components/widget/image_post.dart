import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/images_community_post/image_detail_cmnt_post_screen.dart';

import '../../screen_default/community/images_community_post/images_edit_community_post_screen.dart';

class ImagePost extends StatelessWidget {
  List<String> listImageUrl;
  Function? onRemove;
  Function? onEdit;
  bool? isEdit;

  ImagePost({required this.listImageUrl, this.isEdit,  this.onRemove});

  void toScreen() {
    if (isEdit == true) {
      Get.to(
        () => ImageEditCommunityPostScreen(
          imagesStringInput: listImageUrl,
          onEdit: () {
            if (onEdit != null) onEdit!;
          },
          onRemove: (e) {
            if (onRemove != null) onRemove!(e);
          },
        ),
      );
    } else {
      Get.to(() => ImageDetailCommunityPostScreen(images: listImageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: listImageUrl.length == 1
          ? GestureDetector(
              onTap: () {
                toScreen();
              },
              child: CachedNetworkImage(
                imageUrl: listImageUrl[0],
                fit: BoxFit.fitWidth,
              ),
            )
          : listImageUrl.length == 2
              ? Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          toScreen();
                        },
                        child: CachedNetworkImage(
                          imageUrl: listImageUrl[0],
                          fit: BoxFit.cover,
                          width: Get.width / 2,
                          height: Get.width / 2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          toScreen();
                        },
                        child: CachedNetworkImage(
                          imageUrl: listImageUrl[1],
                          fit: BoxFit.cover,
                          width: Get.width / 2,
                          height: Get.width / 2,
                        ),
                      ),
                    ),
                  ],
                )
              : listImageUrl.length == 3
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            toScreen();
                          },
                          child: CachedNetworkImage(
                            imageUrl: listImageUrl[0],
                            fit: BoxFit.fitHeight,
                            height: Get.width + 3,
                            width: Get.width / 2,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  toScreen();
                                },
                                child: CachedNetworkImage(
                                  imageUrl: listImageUrl[1],
                                  width: Get.width / 2,
                                  height: Get.width / 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              GestureDetector(
                                onTap: () {
                                  toScreen();
                                },
                                child: CachedNetworkImage(
                                  imageUrl: listImageUrl[2],
                                  width: Get.width / 2,
                                  height: Get.width / 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : listImageUrl.length == 4
                      ? SizedBox(
                          height: Get.width + 3,
                          width: Get.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        toScreen();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: listImageUrl[0],
                                        width: Get.width / 2,
                                        height: Get.width / 2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        toScreen();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: listImageUrl[2],
                                        width: Get.width / 2,
                                        height: Get.width / 2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        toScreen();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: listImageUrl[1],
                                        width: Get.width / 2,
                                        height: Get.width / 2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        toScreen();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: listImageUrl[3],
                                        width: Get.width / 2,
                                        height: Get.width / 2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : listImageUrl.length > 4
                          ? SizedBox(
                              width: Get.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            toScreen();
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: listImageUrl[0],
                                            width: Get.width / 2,
                                            height: Get.width / 2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            toScreen();
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: listImageUrl[2],
                                            width: Get.width / 2,
                                            height: Get.width / 2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            toScreen();
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: listImageUrl[1],
                                            width: Get.width / 2,
                                            height: Get.width / 2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: listImageUrl[3],
                                              width: Get.width / 2,
                                              height: Get.width / 2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned.fill(
                                              child: GestureDetector(
                                                onTap: () {
                                                  toScreen();
                                                },
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                  child: Center(
                                                    child: Text(
                                                      '+ ${listImageUrl.length - 4}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
    );
  }
}
