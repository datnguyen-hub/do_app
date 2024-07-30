import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/chapter.dart';
import 'package:sahashop_customer/app_customer/model/lesson.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/lesson/lesson_screen.dart';

class ListLessonScreen extends StatelessWidget {
  Chapter chapter;

  ListLessonScreen({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách bài học",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Danh sách bài học của: ${chapter.title ?? ""}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              ...chapter.lessons!.map((e) {
                return listLesson(lesson: e, context: context);
              }).toList()
            ],
          ),
        ),
      ),
    );
  }

  Widget listLesson({required Lesson? lesson, required context}) {
    return InkWell(
      onTap: () {
        Get.to(() => LessonScreen(
              idLesson: lesson!.id,
              lessonInput: lesson,
            ));
      },
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${lesson?.title ?? ""}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${lesson?.shortDescription ?? ""}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.smart_display_rounded,
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  size: 30,
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
