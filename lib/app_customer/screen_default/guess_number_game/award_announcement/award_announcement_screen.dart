import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';

import '../../../components/loading/loading_widget.dart';
import '../../../model/guess_number_game.dart';
import 'cuswin_screen.dart';

class AwardAnnouncementScreen extends StatelessWidget {
  AwardAnnouncementScreen({super.key, required this.guessGameNumber});

  GuessNumberGame guessGameNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "packages/sahashop_customer/assets/images/background_award.png"))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.8)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(10),
              //   // decoration: BoxDecoration(
              //   //     color: Colors.grey.withOpacity(0.5),
              //   //     borderRadius: BorderRadius.circular(10)),
              //   child: Text(
              //     'Công bố kết quả',
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 30,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        guessGameNumber.isGuessNumber == true
                            ? 'Con số may mắn là ${guessGameNumber.finalResultAnnounced?.gameResulted?.textResult ?? "Chưa có thông tin"}'
                            : 'Đáp án là ${guessGameNumber.finalResultAnnounced?.gameResulted?.textResult ?? "Chưa có thông tin"}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30.0),
                      child: Text(
                        (guessGameNumber.finalResultAnnounced?.customerWin ??
                                    [])
                                .isEmpty
                            ? 'Ban tổ chức rất lấy làm tiếc khi lần này không có ai trúng thưởng, chúc quý khách may mắn lần sau'
                            : 'Xin được chúc mừng người may mắn trúng giải lần này là bạn ${guessGameNumber.finalResultAnnounced?.customerWin?[0].name ?? "Chưa có thông tin"}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (guessGameNumber.finalResultAnnounced?.customerWin !=
                            null &&
                        guessGameNumber
                            .finalResultAnnounced!.customerWin!.isNotEmpty)
                      ClipOval(
                        child: CachedNetworkImage(
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          imageUrl: guessGameNumber.finalResultAnnounced
                                  ?.customerWin?[0].avatarImage ??
                              '',
                          placeholder: (context, url) => SahaLoadingWidget(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyAvata(),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (guessGameNumber.finalResultAnnounced?.customerWin !=
                            null &&
                        guessGameNumber
                            .finalResultAnnounced!.customerWin!.isNotEmpty)
                      Text(
                        'Phần thưởng bạn nhận được là ${guessGameNumber.finalResultAnnounced?.gameResulted?.valueGift ?? "Chưa có thông tin"}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    if (guessGameNumber.isShowAllPrizer == true &&
                        guessGameNumber.finalResultAnnounced?.customerWin !=
                            null &&
                        guessGameNumber
                            .finalResultAnnounced!.customerWin!.isNotEmpty)
                      Column(
                        children: [
                          SahaButtonFullParent(
                            text: 'Danh sách người chơi có cùng đáp án',
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Get.to(() => CustomerWinScrene(
                                  listCusWin: guessGameNumber
                                          .finalResultAnnounced?.customerWin ??
                                      []));
                            },
                          )
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //         color: Colors.blue,
                          //         borderRadius: BorderRadius.circular(20)),
                          //     child: Center(
                          //       child: Text(
                          //         'Danh sách những bạn có cùng đáp án đúng',
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     child: Column(
                          //       children: [
                          //         ...(guessGameNumber.finalResultAnnounced
                          //                     ?.customerWin ??
                          //                 [])
                          //             .map((e) => customer(
                          //                 e,
                          //                 (guessGameNumber.finalResultAnnounced
                          //                             ?.customerWin ??
                          //                         [])
                          //                     .indexOf(e))),
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
