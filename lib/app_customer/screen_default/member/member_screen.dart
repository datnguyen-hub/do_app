import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';
import '../../screen_default/member/member_controller.dart';
import '../../model/score_history_item.dart';
import '../../utils/date_utils.dart';

class MemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: MemberLoggedScreen());
  }
}

class MemberLoggedScreen extends StatefulWidget {
  @override
  _MemberLoggedScreenState createState() => _MemberLoggedScreenState();
}

class _MemberLoggedScreenState extends State<MemberLoggedScreen> {
  late MemberController memberController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memberController = MemberController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Xu tích luỹ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Obx(() {
                        //     var memberType = memberController.memberType.value;
                        //     return Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SvgPicture.asset(
                        //           "packages/sahashop_customer/assets/icons/star_around.svg",
                        //           height: 10,
                        //           width: 10,
                        //           color: memberType == "Bạc"
                        //               ? Colors.grey
                        //               : memberType == "Vàng"
                        //                   ? Color(0xffe6b92f)
                        //                   : memberType == "Bạch kim"
                        //                       ? Colors.cyan
                        //                       : memberType == "Kim cương"
                        //                           ? Colors.lightBlueAccent
                        //                           : Colors.transparent,
                        //         ),
                        //
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         SvgPicture.asset(
                        //           "packages/sahashop_customer/assets/icons/star_around.svg",
                        //           height: 10,
                        //           width: 10,
                        //           color: memberType == "Bạc"
                        //               ? Colors.grey
                        //               : memberType == "Vàng"
                        //                   ? Color(0xffe6b92f)
                        //                   : memberType == "Bạch kim"
                        //                       ? Colors.cyan
                        //                       : memberType == "Kim cương"
                        //                           ? Colors.lightBlueAccent
                        //                           : Colors.transparent,
                        //         ),
                        //       ],
                        //     );
                        //   }),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]!),
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                "packages/sahashop_customer/assets/icons/wallet_color.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Xu tích luỹ: ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Color(0xffe6b92f))),
                          child: Center(
                            child: Text(
                              "${SahaStringUtils().convertToMoney(memberController.dataAppCustomerController.badge.value.customerPoint ?? 0)} Xu",
                              style: TextStyle(
                                  color: Color(0xffe6b92f),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        memberController.seeScoreHistory();
                      },
                      child: Text(
                        "Lịch sử tích điểm",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffe6b92f),
                        ),
                      ))
                ],
              ),
            ),
            Obx(
              () => AnimatedContainer(
                height: memberController.isScoreHistory.value
                    ? memberController.listScoreHistory.length * 55 >
                            Get.height ~/ 2
                        ? Get.height / 2
                        : memberController.listScoreHistory.length * 55
                    : 0,
                width: Get.width,
                duration: Duration(milliseconds: 300),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                          memberController.listScoreHistory.length,
                          (index) => historyItem(
                              memberController.listScoreHistory[index]))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]!),
                              color: Colors.grey[200],
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/coin.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Chính sách tích Xu",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Color(0xffe6b92f))),
                            child: Center(
                                child: Text(
                              "1 Xu = ${(memberController.rewardPointCtm.value.moneyAPoint ?? 0).toPrecision(3)} VNĐ",
                              style: TextStyle(
                                  color: Color(0xffe6b92f),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                          boxItem(
                            svgPath:
                                "packages/sahashop_customer/assets/icons/check_list_new.svg",
                            title: "Hoàn xu đơn hàng",
                            isGrey: false,
                            description:
                                "${(memberController.rewardPointCtm.value.percentRefund ?? 0).toPrecision(3)}% ${memberController.rewardPointCtm.value.isSetOrderMaxPoint == true ? "Giới hạn ${SahaStringUtils().convertToMoney(memberController.rewardPointCtm.value.orderMaxPoint ?? 0)} Xu" : ""}",
                            exam:
                                "VD: 100k hoàn 10% = 10k = 10k Xu (1Xu = 1VNĐ)",
                          ),
                          boxItem(
                              svgPath:
                                  "packages/sahashop_customer/assets/icons/ribbon3.svg",
                              title: "Đánh giá sản phẩm",
                              isGrey: false,
                              description:
                                  "+${SahaStringUtils().convertToMoney(memberController.rewardPointCtm.value.pointReview ?? 0)} Xu"),
                          boxItem(
                              svgPath:
                                  "packages/sahashop_customer/assets/icons/group_empty.svg",
                              title: "Giới thiệu bạn bè",
                              isGrey: false,
                              description:
                                  "+${SahaStringUtils().convertToMoney(memberController.rewardPointCtm.value.pointIntroduceCustomer ?? 0)} Xu"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            // Container(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Row(
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                   border: Border.all(color: Colors.grey[400]!),
            //                   color: Colors.grey[200],
            //                   shape: BoxShape.circle),
            //               padding: EdgeInsets.all(5),
            //               child: SvgPicture.asset(
            //                 "packages/sahashop_customer/assets/icons/unlock.svg",
            //                 height: 20,
            //                 width: 20,
            //               ),
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Obx(
            //               () => Text(
            //                 "Để thăng hạng ${memberController.memberTypeNext.value}",
            //                 style: TextStyle(
            //                     fontSize: 15, fontWeight: FontWeight.w600),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         height: 115,
            //         width: Get.width * 0.9,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(3),
            //           border: Border.all(color: Colors.grey[400]!),
            //         ),
            //         child: Obx(
            //           () => Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   children: [
            //                     Text(
            //                       "Chi tiêu",
            //                       style: TextStyle(fontWeight: FontWeight.w600),
            //                     ),
            //                     Spacer(),
            //                     Container(
            //                       decoration: BoxDecoration(
            //                           border: Border.all(color: Colors.red),
            //                           borderRadius: BorderRadius.circular(2)),
            //                       height: 18,
            //                       width: 60,
            //                       child: Center(
            //                         child: Text(
            //                           "Chưa đạt",
            //                           style: TextStyle(
            //                               fontSize: 12, color: Colors.red),
            //                         ),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   children: [
            //                     SahaMoneyText(
            //                       price: memberController
            //                           .dataAppCustomerController
            //                           .badge
            //                           .value
            //                           .totalBoughtAmount,
            //                       sizeText: 13,
            //                       sizeVND: 12,
            //                       color: Colors.red,
            //                     ),
            //                     Text(" / "),
            //                     SahaMoneyText(
            //                       price: memberController.scoreTarget.value,
            //                       sizeText: 13,
            //                       sizeVND: 12,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   children: [
            //                     Text("Mua thêm "),
            //                     SahaMoneyText(
            //                       price: memberController.scoreTarget.value -
            //                           memberController.dataAppCustomerController
            //                               .badge.value.totalBoughtAmount!,
            //                       sizeText: 13,
            //                       sizeVND: 12,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                     Text(" Để được nâng hạng")
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   height: 8,
            //   color: Colors.grey[200],
            // ),
            // boxItem(
            //     svgPath:
            //         "packages/sahashop_customer/assets/icons/coupon_color.svg",
            //     title: "Voucher hấp dẫn",
            //     description: "Liên hệ shop nhận ưu đãi"),
            // boxItem(
            //     svgPath:
            //         "packages/sahashop_customer/assets/icons/birthday-cake.svg",
            //     title: "Sinh nhật đổi quà",
            //     description: "Liên hệ shop nhận ưu đãi"),
            // boxItem(
            //     svgPath:
            //         "packages/sahashop_customer/assets/icons/free-delivery.svg",
            //     title: "Miễn phí vận chuyển",
            //     description: "Liên hệ shop nhận ưu đãi"),
            // boxItem(
            //     svgPath:
            //         "packages/sahashop_customer/assets/icons/gift_color.svg",
            //     title: "Giảm giá hoá đơn",
            //     description: "Liên hệ shop nhận ưu đãi"),
            // boxItem(
            //     svgPath: "packages/sahashop_customer/assets/icons/top.svg",
            //     title: "Thăng hạng đổi quà",
            //     description: "Liên hệ shop nhận ưu đãi"),
          ],
        ),
      ),
    );
  }

  Widget historyItem(ScoreHistoryItem scoreHistoryItem) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    scoreHistoryItem.content == null ||
                            scoreHistoryItem.content == ""
                        ? Container()
                        : Text("${scoreHistoryItem.content}"),
                    Text(
                        "Xu hiện tại : ${SahaStringUtils().convertToMoney(scoreHistoryItem.currentPoint ?? 0)}"),
                    Text(
                      "${SahaDateUtils().getDDMMYY(scoreHistoryItem.createdAt ?? DateTime.now())}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Spacer(),
              Text(
                "${(scoreHistoryItem.point ?? 0) > 0 ? "+" : ""}${SahaStringUtils().convertToMoney(scoreHistoryItem.point ?? 0)}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: (scoreHistoryItem.point ?? 0) > 0
                        ? Colors.green
                        : Colors.red),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  Widget boxItem({
    String? svgPath,
    String? title,
    String? description,
    String? exam,
    bool? isGrey = true,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    color: Colors.grey[200],
                    shape: BoxShape.circle),
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  svgPath!,
                  height: 20,
                  width: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      description!,
                      style: TextStyle(
                          color:
                              isGrey == true ? Colors.grey[500] : Colors.green,
                          fontSize: 15),
                    ),
                    if (exam != null)
                      Text(
                        exam,
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 12.5),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
