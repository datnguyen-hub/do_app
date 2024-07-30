import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/cart_model.dart';
import 'package:sahashop_customer/app_customer/model/step_bonus_agency.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/bonus_config_detail/reward_agency_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class ItemBonus extends StatefulWidget {
  StepBonusAgency? stepBonus;
  DataConfigBonus? dataConfigBonus;
  bool isExpanded;
  ItemBonus({this.stepBonus, required this.isExpanded, this.dataConfigBonus});

  @override
  _ItemBonusState createState() => _ItemBonusState();
}

class _ItemBonusState extends State<ItemBonus> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.stepBonus == null
        ? InkWell(
            onTap: () {
              Get.to(() => RewardAgencyScreen(
                    dataConfigBonus: widget.dataConfigBonus!,
                  ));
            },
            child: Container(
              child: Row(
                children: [
                  SvgPicture.asset(
                    "packages/sahashop_customer/assets/icons/gift_color.svg",
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Chương trình đổi quà"),
                  Spacer(),
                  Text(
                    "Xem thêm",
                    style: TextStyle(
                        fontSize: 13,
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground()),
                  ),
                ],
              ),
            ),
          )
        : widget.isExpanded == false
            ? InkWell(
                onTap: () {
                  setState(() {
                    widget.isExpanded = true;
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/gift_color.svg",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Phần thưởng được tặng"),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.dataConfigBonus != null)
                          InkWell(
                            onTap: () {
                              Get.to(() => RewardAgencyScreen(
                                    dataConfigBonus: widget.dataConfigBonus!,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "Các chương trình khác",
                                    style: TextStyle(
                                        color: SahaColorUtils()
                                            .colorPrimaryTextWithWhiteBackground()),
                                  )
                                ],
                              ),
                            ),
                          ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                  widget.stepBonus!.rewardImageUrl ??
                                      "",
                                  placeholder: (context, url) =>
                                  new SahaLoadingWidget(
                                    size: 20,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      SahaEmptyImage(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Chương trình: ${widget.stepBonus!.rewardName ?? " "}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text("Đạt mức: "),
                                        Spacer(),
                                        Text(
                                            "${SahaStringUtils().convertToMoney(widget.stepBonus!.threshold ?? "")}₫"),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text("Thưởng: "),
                                        Spacer(),
                                        Text(
                                            "${SahaStringUtils().convertToMoney(widget.stepBonus!.rewardValue ?? "")}₫"),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 10),
                          child: Text(
                            widget.stepBonus!.rewardDescription ?? "",
                            maxLines: 4,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        right: 10,
                        bottom: 10,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.isExpanded = false;
                              });
                            },
                            child: Text(
                              "Rút gọn",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )))
                  ],
                ),
              );
  }
}
