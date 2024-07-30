
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/widget/view_image.dart';

class ImageDetailCommunityPostScreen extends StatefulWidget {
  final List<String> images;

  ImageDetailCommunityPostScreen({required this.images});

  @override
  State<ImageDetailCommunityPostScreen> createState() =>
      _ImageDetailCommunityPostScreenState();
}

class _ImageDetailCommunityPostScreenState extends State<ImageDetailCommunityPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Ảnh",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: widget.images
                .map((e) => InkWell(
              onTap: (){
                ViewListImages.seeImage(
                  listImageUrl: widget.images,
                  index: widget.images.indexOf(e),
                );
              },
                  child: Container(
              margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
              ),
              child: Column(
                  children: [
                    CachedNetworkImage(
                        imageUrl: e,
                        width: Get.width,
                        fit: BoxFit.fitWidth,
                        errorWidget: (context, url, error) =>
                            SahaEmptyImage()
                    ),
                    SizedBox(height: 10),
                  ],
              ),
            ),
                ))
                .toList(),
          ),
        ));
  }
}
