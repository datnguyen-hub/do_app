import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BestTutorSite { a, b }

class ArticleObjectScreen extends StatefulWidget {
  const ArticleObjectScreen({Key? key}) : super(key: key);

  @override
  State<ArticleObjectScreen> createState() => _ArticleObjectScreenState();
}

class _ArticleObjectScreenState extends State<ArticleObjectScreen> {
  BestTutorSite _site = BestTutorSite.a;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Đối tượng của bài viết",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ai có thể xem bài viết của bạn?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bài viết của bạn sẽ hiện ở Bảng feed, trang cá nhân và kết quả tìm kiếm. \n \n'
                "Tuỳ đối tượng mặc định là công khai, nhưng bạn có thể thay đổi đối tượng của triêng bài viết này",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Chọn đối tượng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio<BestTutorSite>(
                          groupValue: _site,
                          value: BestTutorSite.a,
                          onChanged: (value) {
                            setState(() {
                              _site = value!;
                            });
                          },
                        ),
                        Icon(
                          Icons.public_rounded,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Công khai',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Mọi người công khai trên Ikiteck',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<BestTutorSite>(
                          groupValue: _site,
                          value: BestTutorSite.b,
                          onChanged: (value) {
                            setState(() {
                              _site = value!;
                            });
                          },
                        ),
                        Icon(
                          Icons.lock_rounded,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chỉ mình tôi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Chỉ mình tôi',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: Get.width,
        padding: EdgeInsets.all(10),
        child: InkWell(
          child: Text(
            'Xong',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
