import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/community.dart';


class BackgroundCommunityPostScreen extends StatefulWidget {
  Function onTap;

  BackgroundCommunityPostScreen({required this.onTap});

  @override
  State<BackgroundCommunityPostScreen> createState() =>
      _BackgroundCommunityPostScreenState();
}

class _BackgroundCommunityPostScreenState
    extends State<BackgroundCommunityPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 3,
      padding: EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chọn phông nền',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close_rounded,
                ),
              ),
            ],
          ),
          Divider(),
          Container(
            height: Get.height / 2.2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: backgroundPost.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onTap(backgroundPost[index]);
                            Get.back();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              "${backgroundPost[index]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget background({required String image}) {
    return Container(
      width: 30,
      height: 30,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
