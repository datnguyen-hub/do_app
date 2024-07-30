import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/image_edit/image_editor.dart';

class ImageEditCommunityPostScreen extends StatefulWidget {
  final List<File>? imagesInput;
  final List<String>? imagesStringInput;
  final Function? onRemove;
  final Function? onEdit;

  ImageEditCommunityPostScreen(
      {this.imagesInput, this.imagesStringInput, this.onEdit, this.onRemove});

  @override
  State<ImageEditCommunityPostScreen> createState() =>
      _ImageEditCommunityPostScreenState();
}

class _ImageEditCommunityPostScreenState
    extends State<ImageEditCommunityPostScreen> {
  var images = [];

  @override
  void initState() {
    if (widget.imagesInput != null) {
      images = widget.imagesInput!;
    } else {
      images = widget.imagesStringInput!;
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return true;
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
              "Chỉnh sửa",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: images
                  .map((e) => Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                widget.imagesInput == null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.fitWidth,
                                        imageUrl: e,
                                        placeholder: (context, url) =>
                                            new SahaLoadingWidget(
                                          size: 20,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            SahaEmptyImage(),
                                      )
                                    : Image.file(
                                        e,
                                        width: Get.width,
                                      ),
                                Positioned(
                                  top: 7,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (widget.onRemove != null) {
                                        widget.onRemove!(e);
                                      }
                                      setState(() {
                                        images.remove(e);
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   right: 40,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       toImageEditor(e);
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //         color: Colors.black54,
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: Row(
                                //         children: [
                                //           Icon(
                                //             Icons.edit,
                                //             color: Colors.white,
                                //             size: 20,
                                //           ),
                                //           Text(
                                //             'Chỉnh sửa',
                                //             style: TextStyle(color: Colors.white),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )),
    );
  }

  Future<void> toImageEditor(
    File origin,
  ) async {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImageEditor(
        originImage: origin,
        //this is nullable, you can custom new file's save postion
        // savePath: customDirectory
      );
    })).then((result) {
      if (result is EditorImageResult) {
        setState(() {
          var index = images.indexOf(origin);

          images[index] = result.newFile;
        });
      }
    }).catchError((er) {
      debugPrint(er);
    });
  }
}
