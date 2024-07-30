import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/chapter.dart';
import 'package:sahashop_customer/app_customer/model/course_list.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/list_chapter/chapter_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/list_lesson/list_lesson_screen.dart';


class ChapterListScreen extends StatelessWidget {
  late ChapterController chapterController;
  CourseList courseList;

  ChapterListScreen({required this.idListCourses, required this.courseList}) {
    chapterController = ChapterController(
        idListCourses: idListCourses!, courseList: courseList);
  }

  int? idListCourses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách chương",
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: courseList.imageUrl ?? "",
                    width: Get.width,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    "${courseList.title ?? ""}".toUpperCase(),
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 5,
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
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  width: Get.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border(
                        left: BorderSide(
                          width: 8,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.9),
                        ),
                      ),
                    ),
                    child: Text(
                      "${courseList.shortDescription ?? ""}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ...chapterController.listChapter.map((e) {
                  return lessonList(chapter: e, context: context);
                }).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget lessonList({Chapter? chapter, required context}) {
    return InkWell(
      onTap: () {
        Get.to(() => ListLessonScreen(
              chapter: chapter!,
            ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    chapter?.title ?? "",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 2,
          ),
        ],
      ),
    );
  }
}
