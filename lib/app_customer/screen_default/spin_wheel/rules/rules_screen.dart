import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/mini_game.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/image/show_image.dart';
import '../../../components/loading/loading_container.dart';
import '../../../components/loading/loading_widget.dart';

class RulesScreen extends StatelessWidget {
  RulesScreen({super.key, required this.miniGame});
  MiniGame miniGame;
  var nameApp = StoreInfo().name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thể lệ trò chơi')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((miniGame.images ?? []).isNotEmpty)
              Container(
                height: 300,
                width: Get.width,
                child: Swiper(
                  itemBuilder: (context, index) {
                    final image = miniGame.images![index];
                    return CachedNetworkImage(
                      width: Get.width,
                      fit: BoxFit.cover,
                      imageUrl: image ?? '',
                      placeholder: (context, url) => SahaLoadingContainer(),
                      errorWidget: (context, url, error) => SahaEmptyImage(),
                    );
                  },
                  indicatorLayout: PageIndicatorLayout.COLOR,
                  autoplay: true,
                  itemCount: miniGame.images!.length,
                  pagination: const SwiperPagination(),
                ),
              ),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey[300]),
              width: Get.width,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/bingo.svg",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'THỂ LỆ',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(30.0),
                  //   child: SvgPicture.asset(
                  //     "assets/icons/bingo.svg",
                  //   ),
                  // ),

                  Positioned.fill(
                    child:
                        // miniGame.description == null
                        //     ? Center(
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Text(
                        //               miniGame.description ?? 'Chưa có thông tin'),
                        //         ),
                        //       )
                        //     :
                        SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: 'Quy tắc chung của trò chơi : \n\n',
                                      style: TextStyle(fontSize: 20)),
                                  TextSpan(
                                    text:
                                        '1. Đối tượng chơi: Đây là trò chơi tích điểm và được áp dụng dành cho tất cả người sử dụng app, những phần thưởng trong trò chơi có thể được sử dụng trong app.\n\n',
                                  ),
                                  TextSpan(
                                      text:
                                          '2. Quy tắc tham gia: Để tham gia trò chơi, người dùng cần đăng nhập và ấn vào biểu tượng hình tay cầm chơi game trong phần ”Tiện ích của tôi”.\n\n'),
                                  TextSpan(
                                      text:
                                          '3. Quy tắc phần thưởng: Các phần thưởng nhận được có thể sử dụng trong phạm vi của úng dụng . người dùng có thể vào phần Tích điểm để tìm hiểu quy tắc đổi điểm.\n\n'),
                                  TextSpan(
                                      text:
                                          '4 . Trò chơi này được tạo ra và quản lý bởi ${nameApp} một cách độc lập, không có sự hỗ trợ hay liên kết với bất kỳ bên thứ ba nào và Apple không phải là nhà tài trợ của chương trình này, và không tham dưới bất kỳ hình thức nào. \n\n',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),

                                ],
                              ),
                            ),
                            if( miniGame.description == null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Quy tắc của trò chơi : \n',
                                        style: TextStyle(fontSize: 20)),
                                    TextSpan(
                                      text: miniGame.description ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            // Obx(() => miniGame.description == null
                            //     ? Container()
                            //     : RichText(
                            //         text: TextSpan(
                            //           children: [
                            //             TextSpan(
                            //                 text: 'Quy tắc của trò chơi : \n',
                            //                 style: TextStyle(fontSize: 20)),
                            //             TextSpan(
                            //               text: miniGame.description ?? "",
                            //               style: TextStyle(
                            //                 fontSize: 16,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   'Thể lệ của trò chơi',
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w700,
            //     color: Theme.of(context).primaryColor,
            //   ),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Text(miniGame.description ?? "Trò chơi này chưa có thể lệ"),
            // Divider(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Ảnh mô tả',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w700,
            //         color: Theme.of(context).primaryColor,
            //       ),
            //     ),
            //     Wrap(
            //       children: [
            //         ...(miniGame.images ?? []).map((e) => imagesRules(e ?? ''))
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget imagesRules(String images) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          ShowImage().seeImage(
              listImageUrl: (miniGame.images ?? []),
              index: (miniGame.images ?? []).toList().indexOf(images));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: images,
            placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => SahaEmptyImage(),
          ),
        ),
      ),
    );
  }
}
