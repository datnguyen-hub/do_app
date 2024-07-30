import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/cart_model.dart';
import 'package:sahashop_customer/app_customer/model/step_bonus_agency.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class RewardAgencyScreen extends StatelessWidget {
  DataConfigBonus dataConfigBonus;
  RewardAgencyScreen({required this.dataConfigBonus});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cấu hình thưởng"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thời gian bắt đầu'),
                Row(
                  children: [
                    Text(
                      '${SahaDateUtils().getDDMMYY(dataConfigBonus.config?.startTime ?? DateTime.now())}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      '  ${SahaDateUtils().getHHMM(dataConfigBonus.config?.startTime ?? DateTime.now())}',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thời gian kết thúc'),
                Row(
                  children: [
                    Text(
                      '${SahaDateUtils().getDDMMYY(dataConfigBonus.config?.endTime ?? DateTime.now())}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      '  ${SahaDateUtils().getHHMM(dataConfigBonus.config?.endTime ?? DateTime.now())}',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ],
            ),
          ),
          ...dataConfigBonus.stepBonus!.map((e) => itemBonusStep(e)).toList(),
        ]),
      ),
    );
  }

  Widget itemBonusStep(StepBonusAgency stepBonus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      imageUrl: stepBonus.rewardImageUrl ?? "",
                      placeholder: (context, url) => new SahaLoadingWidget(
                        size: 20,
                      ),
                      errorWidget: (context, url, error) => SahaEmptyImage(),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(stepBonus.rewardName ?? ""),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Đạt mức: "),
                        Text(
                            "${SahaStringUtils().convertToMoney(stepBonus.threshold ?? "")}₫"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Thưởng: "),
                        Text(
                            "${SahaStringUtils().convertToMoney(stepBonus.rewardValue ?? "")}₫"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Giới hạn: "),
                        Text("${stepBonus.limit ?? ""}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (stepBonus.active == true)
              Icon(
                Icons.check,
                color: Colors.green,
                size: 40,
              ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 10),
          child: Text(
            stepBonus.rewardDescription ?? "",
            maxLines: 4,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          height: 5,
          color: Colors.grey[200],
        )
      ],
    );
  }
}
