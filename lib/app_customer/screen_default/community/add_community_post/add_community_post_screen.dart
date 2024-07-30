import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/add_community_post/add_community_post_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/community/background_community_post/background_community_post_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import '../../../components/widget/image_post.dart';
import '../../../const/community.dart';
import '../images_community_post/images_edit_community_post_screen.dart';
import 'feel/fell_screen.dart';

class AddCommunityPostSceen extends StatefulWidget {
  CommunityPost? communityPostInput;
  bool? isUpImage;

  AddCommunityPostSceen({this.communityPostInput, this.isUpImage}) {
    addCommunityPostController =
        AddCommunityPostController(communityPostInput: communityPostInput);
  }

  late AddCommunityPostController addCommunityPostController;

  @override
  State<AddCommunityPostSceen> createState() => _AddCommunityPostSceenState();
}

class _AddCommunityPostSceenState extends State<AddCommunityPostSceen> {
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.isUpImage == true) {
        widget.addCommunityPostController.loadAssets();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          title: Text(
            'Tạo bài viết',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                print(widget.addCommunityPostController.communityPostRequest
                    .value.content);
                if (widget.addCommunityPostController.communityPostRequest.value
                            .content !=
                        null ||
                    widget.addCommunityPostController.communityPostRequest.value
                            .content !=
                        '') {
                  if (widget.communityPostInput != null) {
                    widget.addCommunityPostController.updateComunityPost();
                  } else {
                    widget.addCommunityPostController.addCommunityPost();
                  }
                }
              },
              child: Obx(
                () => Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: widget.addCommunityPostController
                                    .communityPostRequest.value.content ==
                                null ||
                            widget.addCommunityPostController
                                    .communityPostRequest.value.content ==
                                ''
                        ? Colors.grey
                        : Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      widget.communityPostInput != null ? 'Cập nhật' : 'Đăng',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          imageUrl: dataAppCustomerController
                                  .infoCustomer.value.avatarImage ??
                              "",
                          placeholder: (context, url) => SahaLoadingWidget(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyAvata(),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Obx(
                                () => Text.rich(TextSpan(
                                    text: dataAppCustomerController
                                            .infoCustomer.value.name ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: <InlineSpan>[
                                      if (widget
                                              .addCommunityPostController
                                              .communityPostRequest
                                              .value
                                              .feeling !=
                                          null)
                                        TextSpan(
                                            text:
                                                '  đang cảm thấy ${feelCommunity[int.parse(widget.addCommunityPostController.communityPostRequest.value.feeling!)].name}  ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      if (widget
                                              .addCommunityPostController
                                              .communityPostRequest
                                              .value
                                              .feeling !=
                                          null)
                                        WidgetSpan(
                                            child: Icon(
                                          feelCommunity[int.parse(widget
                                                  .addCommunityPostController
                                                  .communityPostRequest
                                                  .value
                                                  .feeling!)]
                                              .icon,
                                          size: 16,
                                        )),
                                    ])),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.public_sharp,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Align(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        'Công khai',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Obx(() {
                      return (widget
                                      .addCommunityPostController
                                      .communityPostRequest
                                      .value
                                      .backgroundColor ==
                                  null ||
                              widget.addCommunityPostController.maxLine > 7 ||
                              widget.addCommunityPostController.listImageFile
                                  .isNotEmpty)
                          ? Column(
                              children: [
                                TextField(
                                  controller: widget.addCommunityPostController
                                      .contentCommunityPost,
                                  textAlign: TextAlign.left,
                                  autofocus: true,
                                  style: TextStyle(
                                    color: widget
                                                    .addCommunityPostController
                                                    .communityPostRequest
                                                    .value
                                                    .backgroundColor !=
                                                null &&
                                            widget.addCommunityPostController
                                                    .maxLine <=
                                                7 &&
                                            widget.addCommunityPostController
                                                .listImageFile.isEmpty
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: widget
                                                    .addCommunityPostController
                                                    .communityPostRequest
                                                    .value
                                                    .backgroundColor !=
                                                null &&
                                            widget.addCommunityPostController
                                                    .maxLine <=
                                                7 &&
                                            widget.addCommunityPostController
                                                .listImageFile.isEmpty
                                        ? 25
                                        : 14,
                                    fontWeight: widget
                                                    .addCommunityPostController
                                                    .communityPostRequest
                                                    .value
                                                    .backgroundColor !=
                                                null &&
                                            widget.addCommunityPostController
                                                    .maxLine <=
                                                7 &&
                                            widget.addCommunityPostController
                                                .listImageFile.isEmpty
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Bạn đang nghĩ gì?",
                                    hintStyle: TextStyle(
                                      fontSize: 25,
                                      color: widget
                                                      .addCommunityPostController
                                                      .communityPostRequest
                                                      .value
                                                      .backgroundColor !=
                                                  '' &&
                                              widget.addCommunityPostController
                                                      .maxLine <=
                                                  7 &&
                                              widget.addCommunityPostController
                                                  .listImageFile.isEmpty
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                  ),
                                  onChanged: (v) {
                                    widget.addCommunityPostController
                                        .communityPostRequest.value.content = v;
                                    print(v.length);
                                    widget.addCommunityPostController.maxLine
                                        .value = '\n'.allMatches(v).length + 1;
                                    if (v.length >= 180) {
                                      widget.addCommunityPostController.maxLine
                                          .value = 8;
                                    }
                                    widget.addCommunityPostController
                                        .communityPostRequest
                                        .refresh();

                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                widget.communityPostInput != null
                                    ? ImagePost(
                                        listImageUrl: (widget
                                                    .addCommunityPostController
                                                    .communityPostRequest
                                                    .value
                                                    .images ??
                                                [])
                                            .map((e) => e.toString())
                                            .toList(),
                                        isEdit: true,
                                        onRemove: (e) {
                                          (widget
                                                      .addCommunityPostController
                                                      .communityPostRequest
                                                      .value
                                                      .images ??
                                                  [])
                                              .removeWhere((i) => i == e);
                                          widget.addCommunityPostController
                                              .communityPostRequest
                                              .refresh();
                                        })
                                    : imagesInput(),
                                SizedBox(
                                  height: 120,
                                ),
                              ],
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                (widget
                                                .addCommunityPostController
                                                .communityPostRequest
                                                .value
                                                .backgroundColor ==
                                            '' ||
                                        widget.addCommunityPostController
                                                .maxLine >
                                            7 ||
                                        widget.addCommunityPostController
                                            .listImageFile.isNotEmpty)
                                    ? Container()
                                    : Container(
                                        width: Get.width,
                                        child: Image.asset(
                                          widget
                                                  .addCommunityPostController
                                                  .communityPostRequest
                                                  .value
                                                  .backgroundColor ??
                                              "",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                TextField(
                                  controller: widget
                                      .addCommunityPostController
                                      .contentCommunityPost,
                                  textAlign: widget.addCommunityPostController
                                      .listImageFile.isEmpty &&
                                      widget
                                          .addCommunityPostController
                                          .communityPostRequest
                                          .value
                                          .backgroundColor !=
                                          ''
                                      ? TextAlign.center
                                      : TextAlign.left,
                                  style: TextStyle(
                                    color: widget
                                        .addCommunityPostController
                                        .communityPostRequest
                                        .value
                                        .backgroundColor !=
                                        '' &&
                                        widget.addCommunityPostController
                                            .maxLine <=
                                            7 &&
                                        widget.addCommunityPostController
                                            .listImageFile.isEmpty
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: widget
                                        .addCommunityPostController
                                        .communityPostRequest
                                        .value
                                        .backgroundColor !=
                                        '' &&
                                        widget.addCommunityPostController
                                            .maxLine <=
                                            7 &&
                                        widget.addCommunityPostController
                                            .listImageFile.isEmpty
                                        ? 25
                                        : 14,
                                    fontWeight: widget
                                        .addCommunityPostController
                                        .communityPostRequest
                                        .value
                                        .backgroundColor !=
                                        '' &&
                                        widget.addCommunityPostController
                                            .maxLine <=
                                            7 &&
                                        widget.addCommunityPostController
                                            .listImageFile.isEmpty
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Bạn đang nghĩ gì?",
                                    hintStyle: TextStyle(
                                      fontSize: 25,
                                      color: widget
                                          .addCommunityPostController
                                          .communityPostRequest
                                          .value
                                          .backgroundColor !=
                                          '' &&
                                          widget.addCommunityPostController
                                              .maxLine <=
                                              7 &&
                                          widget
                                              .addCommunityPostController
                                              .listImageFile
                                              .isEmpty
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                  ),
                                  onChanged: (v) {
                                    widget
                                        .addCommunityPostController
                                        .communityPostRequest
                                        .value
                                        .content = v;
                                    print(v.length);
                                    widget.addCommunityPostController.maxLine
                                        .value =
                                        '\n'.allMatches(v).length + 1;
                                   if (v.length >= 180) {
                                     widget.addCommunityPostController.maxLine
                                         .value = 8;
                                   }
                                    widget.addCommunityPostController
                                        .communityPostRequest
                                        .refresh();

                                  },
                                )
                              ],
                            );
                    }),
                  ),
                ),
              ],
            ),
            Obx(() => widget.addCommunityPostController.isLoading.value
                ? Positioned.fill(child: SahaLoadingFullScreen())
                : Container())
          ],
        ),
        bottomNavigationBar: Container(
          height: Get.width / 3.5,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                  left: 5,
                  right: 5,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          widget.addCommunityPostController.collapse.value =
                              !widget.addCommunityPostController.collapse.value;
                        },
                        child: Obx(
                          () => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 350),
                              transitionBuilder: (child, anim) =>
                                  RotationTransition(
                                    turns: child.key == ValueKey('icon1')
                                        ? Tween<double>(begin: 1, end: 0)
                                            .animate(anim)
                                        : Tween<double>(begin: 0.75, end: 1)
                                            .animate(anim),
                                    child: ScaleTransition(
                                        scale: anim, child: child),
                                  ),
                              child: widget.addCommunityPostController.collapse
                                          .value ==
                                      true
                                  ? Icon(
                                      Icons.chevron_left_rounded,
                                      key: const ValueKey('icon1'),
                                    )
                                  : Icon(
                                      Icons.view_carousel_rounded,
                                      key: const ValueKey('icon2'),
                                    )),
                        ),
                      ),
                    ),
                    Obx(
                      () => widget.addCommunityPostController.collapse.value ==
                              true
                          ? Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      margin: EdgeInsets.only(right: 5),
                                      child: InkWell(
                                        onTap: () {
                                          widget
                                              .addCommunityPostController
                                              .communityPostRequest
                                              .value
                                              .backgroundColor = null;
                                          widget.addCommunityPostController
                                              .communityPostRequest
                                              .refresh();
                                        },
                                        child: Icon(
                                          Icons.texture_rounded,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    background(),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 35,
                            ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return BackgroundCommunityPostScreen(
                                onTap: (v) {
                                  widget
                                      .addCommunityPostController
                                      .communityPostRequest
                                      .value
                                      .backgroundColor = v;

                                  widget.addCommunityPostController
                                      .communityPostRequest
                                      .refresh();
                                },
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.apps_rounded,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.addCommunityPostController.loadAssets();
                      },
                      child: Icon(
                        FontAwesomeIcons.images,
                        color: Colors.green,
                        size: 25,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Get.to(() => EmotionsActivityScreen(onChoose: (feel) {
                              widget
                                  .addCommunityPostController
                                  .communityPostRequest
                                  .value
                                  .feeling = feel.toString();
                              widget.addCommunityPostController
                                  .communityPostRequest
                                  .refresh();
                            }));
                      },
                      child: Icon(
                        Icons.mood_rounded,
                        color: Colors.yellow,
                        size: 25,
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     showModalBottomSheet<void>(
                    //       context: context,
                    //       elevation: 0,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(15),
                    //           topRight: Radius.circular(15),
                    //         ),
                    //       ),
                    //       builder: (BuildContext context) {
                    //         return ShowModalItemListScreen();
                    //       },
                    //     );
                    //   },
                    //   child: Icon(
                    //     Icons.pending_rounded,
                    //     color: Colors.grey,
                    //     size: 25,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget background() {
    return Expanded(
      child: Container(
        height: 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
          itemCount: backgroundPost.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () {
                  if (widget.addCommunityPostController.maxLine.value < 7) {
                    widget.addCommunityPostController.communityPostRequest.value
                        .backgroundColor = backgroundPost[index];
                    widget.addCommunityPostController.communityPostRequest
                        .refresh();
                  }
                },
                child: Image.asset(
                  backgroundPost[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget imagesInput() {
    return Container(
      child: widget.addCommunityPostController.listImageFile.length == 1
          ? GestureDetector(
              onTap: () {
                Get.to(
                  () => ImageEditCommunityPostScreen(
                    imagesInput: widget.addCommunityPostController.listImageFile
                        .map((e) => File(e.path))
                        .toList(),
                    onRemove: (i) {
                      widget.addCommunityPostController.listImageFile
                          .removeWhere((e) => e.path == i.path);
                    },
                  ),
                );
              },
              child: Image.file(
                widget.addCommunityPostController.listImageFile[0],
                fit: BoxFit.fitWidth,
              ),
            )
          : widget.addCommunityPostController.listImageFile.length == 2
              ? Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ImageEditCommunityPostScreen(
                              imagesInput: widget
                                  .addCommunityPostController.listImageFile
                                  .map((e) => File(e.path))
                                  .toList(),
                              onRemove: (i) {
                                widget.addCommunityPostController.listImageFile
                                    .removeWhere((e) => e.path == i.path);
                              },
                            ),
                          );
                        },
                        child: Image.file(
                          widget.addCommunityPostController.listImageFile[0],
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
                          Get.to(
                            () => ImageEditCommunityPostScreen(
                              imagesInput: widget
                                  .addCommunityPostController.listImageFile
                                  .map((e) => File(e.path))
                                  .toList(),
                              onRemove: (i) {
                                widget.addCommunityPostController.listImageFile
                                    .removeWhere((e) => e.path == i.path);
                              },
                            ),
                          );
                        },
                        child: Image.file(
                          widget.addCommunityPostController.listImageFile[1],
                          fit: BoxFit.cover,
                          width: Get.width / 2,
                          height: Get.width / 2,
                        ),
                      ),
                    ),
                  ],
                )
              : widget.addCommunityPostController.listImageFile.length == 3
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ImageEditCommunityPostScreen(
                                imagesInput: widget
                                    .addCommunityPostController.listImageFile
                                    .map((e) => File(e.path))
                                    .toList(),
                                onRemove: (i) {
                                  widget
                                      .addCommunityPostController.listImageFile
                                      .removeWhere((e) => e.path == i.path);
                                },
                              ),
                            );
                          },
                          child: Image.file(
                            widget.addCommunityPostController.listImageFile[0],
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
                              Image.file(
                                widget.addCommunityPostController
                                    .listImageFile[1],
                                width: Get.width / 2,
                                height: Get.width / 2,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ImageEditCommunityPostScreen(
                                      imagesInput: widget
                                          .addCommunityPostController
                                          .listImageFile
                                          .map((e) => File(e.path))
                                          .toList(),
                                      onRemove: (i) {
                                        widget.addCommunityPostController
                                            .listImageFile
                                            .removeWhere(
                                                (e) => e.path == i.path);
                                      },
                                    ),
                                  );
                                },
                                child: Image.file(
                                  widget.addCommunityPostController
                                      .listImageFile[2],
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
                  : widget.addCommunityPostController.listImageFile.length == 4
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
                                        Get.to(
                                          () => ImageEditCommunityPostScreen(
                                            imagesInput: widget
                                                .addCommunityPostController
                                                .listImageFile
                                                .map((e) => File(e.path))
                                                .toList(),
                                            onRemove: (i) {
                                              widget.addCommunityPostController
                                                  .listImageFile
                                                  .removeWhere(
                                                      (e) => e.path == i.path);
                                            },
                                          ),
                                        );
                                      },
                                      child: Image.file(
                                        widget.addCommunityPostController
                                            .listImageFile[0],
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
                                        Get.to(
                                          () => ImageEditCommunityPostScreen(
                                            imagesInput: widget
                                                .addCommunityPostController
                                                .listImageFile
                                                .map((e) => File(e.path))
                                                .toList(),
                                            onRemove: (i) {
                                              widget.addCommunityPostController
                                                  .listImageFile
                                                  .removeWhere(
                                                      (e) => e.path == i.path);
                                            },
                                          ),
                                        );
                                      },
                                      child: Image.file(
                                        widget.addCommunityPostController
                                            .listImageFile[2],
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
                                        Get.to(
                                          () => ImageEditCommunityPostScreen(
                                            imagesInput: widget
                                                .addCommunityPostController
                                                .listImageFile
                                                .map((e) => File(e.path))
                                                .toList(),
                                            onRemove: (i) {
                                              widget.addCommunityPostController
                                                  .listImageFile
                                                  .removeWhere(
                                                      (e) => e.path == i.path);
                                            },
                                          ),
                                        );
                                      },
                                      child: Image.file(
                                        widget.addCommunityPostController
                                            .listImageFile[1],
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
                                        Get.to(
                                          () => ImageEditCommunityPostScreen(
                                            imagesInput: widget
                                                .addCommunityPostController
                                                .listImageFile
                                                .map((e) => File(e.path))
                                                .toList(),
                                            onRemove: (i) {
                                              widget.addCommunityPostController
                                                  .listImageFile
                                                  .removeWhere(
                                                      (e) => e.path == i.path);
                                            },
                                          ),
                                        );
                                      },
                                      child: Image.file(
                                        widget.addCommunityPostController
                                            .listImageFile[3],
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
                      : widget.addCommunityPostController.listImageFile.length >
                              4
                          ? SizedBox(
                              height: Get.height / 2,
                              width: Get.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () =>
                                                  ImageEditCommunityPostScreen(
                                                imagesInput: widget
                                                    .addCommunityPostController
                                                    .listImageFile
                                                    .map((e) => File(e.path))
                                                    .toList(),
                                                onRemove: (i) {
                                                  widget
                                                      .addCommunityPostController
                                                      .listImageFile
                                                      .removeWhere((e) =>
                                                          e.path == i.path);
                                                },
                                              ),
                                            );
                                          },
                                          child: Image.file(
                                            widget.addCommunityPostController
                                                .listImageFile[0],
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
                                            Get.to(
                                              () =>
                                                  ImageEditCommunityPostScreen(
                                                imagesInput: widget
                                                    .addCommunityPostController
                                                    .listImageFile
                                                    .map((e) => File(e.path))
                                                    .toList(),
                                                onRemove: (i) {
                                                  widget
                                                      .addCommunityPostController
                                                      .listImageFile
                                                      .removeWhere((e) =>
                                                          e.path == i.path);
                                                },
                                              ),
                                            );
                                          },
                                          child: Image.file(
                                            widget.addCommunityPostController
                                                .listImageFile[2],
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
                                            Get.to(
                                              () =>
                                                  ImageEditCommunityPostScreen(
                                                imagesInput: widget
                                                    .addCommunityPostController
                                                    .listImageFile
                                                    .map((e) => File(e.path))
                                                    .toList(),
                                                onRemove: (i) {
                                                  widget
                                                      .addCommunityPostController
                                                      .listImageFile
                                                      .removeWhere((e) =>
                                                          e.path == i.path);
                                                },
                                              ),
                                            );
                                          },
                                          child: Image.file(
                                            widget.addCommunityPostController
                                                .listImageFile[1],
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
                                            Image.file(
                                              widget.addCommunityPostController
                                                  .listImageFile[3],
                                              width: Get.width / 2,
                                              height: Get.width / 2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned.fill(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        ImageEditCommunityPostScreen(
                                                      imagesInput: widget
                                                          .addCommunityPostController
                                                          .listImageFile
                                                          .map((e) =>
                                                              File(e.path))
                                                          .toList(),
                                                      onRemove: (i) {
                                                        widget
                                                            .addCommunityPostController
                                                            .listImageFile
                                                            .removeWhere((e) =>
                                                                e.path ==
                                                                i.path);
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                  child: Center(
                                                    child: Text(
                                                      '+ ${widget.addCommunityPostController.listImageFile.length - 4}',
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
                          : const SizedBox(),
    );
  }
}
