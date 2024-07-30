import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/course_list.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/course_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/education/list_chapter/chapter_list_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';

import 'quiz/quiz_screen.dart';

class CourseLockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: CourseScreen());
  }
}

class CourseScreen extends StatefulWidget {
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  CourseController course = CourseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đào tạo",
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Danh sách khoá học',
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.9),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      ...course.listCourse.map((e) {
                        return unlearnedCourses(courseList: e);
                      }).toList()
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //     top: 50,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Các khoá chưa mua',
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.blue,
                //         ),
                //       ),
                //       Divider(
                //         color: Colors.grey.shade300,
                //       ),
                //       courseNotBuy(
                //           name: "Power Point - tin học văn phòng",
                //           lesson: '18 bài học',
                //           classmate: '105 bạn học',
                //           time: '120 phút'),
                //       courseNotBuy(
                //           name: "Word 2016 - tin học văn phòng",
                //           lesson: '18 bài học',
                //           classmate: '105 bạn học',
                //           time: '120 phút'),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget unlearnedCourses({CourseList? courseList}) {
    return InkWell(
      onTap: () {
        Get.to(() => ChapterListScreen(
              idListCourses: courseList!.id,
              courseList: courseList,
            ));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: courseList?.imageUrl ?? "",
              width: Get.width,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => SahaLoadingWidget(),
              errorWidget: (context, url, error) => SahaEmptyImage(),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseList?.title?.toUpperCase() ?? "",
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
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
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      courseList?.shortDescription ?? "",
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => QuizScreen(
                                courseId: courseList?.id ?? 0,
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Làm bài kiểm tra",
                              style: TextStyle(
                                  color: Theme.of(Get.context!).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => ChapterListScreen(
                                idListCourses: courseList!.id,
                                courseList: courseList,
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Học bài",
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
      ),
    );
  }
}
