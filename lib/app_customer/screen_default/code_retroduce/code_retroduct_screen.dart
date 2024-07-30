import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../../components/loading/loading_full_screen.dart';
import '../../utils/store_info.dart';
import 'code_introduce_controller.dart';

class CodeRetroduceScreen extends StatelessWidget {
  CodeRetroduceController codeRetroduceController = CodeRetroduceController();
  DataAppCustomerController dataAppCustomerController = Get.find();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
   
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Mã giới thiệu"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]!),
                              color: Colors.grey[200],
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            'packages/sahashop_customer/assets/icons/group_empty.svg',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "Mã giới thiệu",
                              style: TextStyle(
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${dataAppCustomerController.infoCustomer.value.phoneNumber ?? "Chưa xác thực"}",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Center(
                                  child: Text(
                                'TẢI APP NGAY',
                                style: TextStyle(color: Colors.red),
                              )),
                              content: SizedBox(
                                height: 200,
                                width: 200,
                                child: BarcodeWidget(
                                  barcode: Barcode
                                      .qrCode(), // Barcode type and settings
                                  data:
                                      'https://${(dataAppCustomerController.badge.value.domain ?? "") == '' ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain!.contains('https://') ? dataAppCustomerController.badge.value.domain!.replaceAll('https://', '') : dataAppCustomerController.badge.value.domain}/qr-app?cid=${dataAppCustomerController.infoCustomer.value.id}',
                                  width: 60, // Content
                                  height: 50,
                                ),
                              ));
                        },
                      );
                    },
                    icon: Icon(
                      Icons.qr_code,
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    )),
                IconButton(
                    onPressed: () {
                      codeRetroduceController.onShare(
                          dataAppCustomerController
                              .infoCustomer.value.phoneNumber,
                          dataAppCustomerController.packageInfo.value.appName);
                    },
                    icon: Icon(
                      Icons.share,
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    )),
              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Danh sách đã giới thiệu:",
              style: TextStyle(
                  color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Obx(
              () => codeRetroduceController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: MaterialClassicHeader(),
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() =>
                                codeRetroduceController.isLoading.value
                                    ? CupertinoActivityIndicator()
                                    : Container());
                          } else if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                          }
                          return Container(
                            height: 100,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: refreshController,
                      onRefresh: () async {
                        await codeRetroduceController.getAllReferral(
                            isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await codeRetroduceController.getAllReferral();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                        itemCount:
                            codeRetroduceController.listInfoCustomer.length,
                        itemBuilder: (context, index) {
                          var e =
                              codeRetroduceController.listInfoCustomer[index];
                          return InkWell(
                            onTap: (){
                              
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      "${e.name ?? ''} ${e.phoneNumber ?? "Chưa rõ"}"),
                                ),
                                Divider(
                                  height: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
