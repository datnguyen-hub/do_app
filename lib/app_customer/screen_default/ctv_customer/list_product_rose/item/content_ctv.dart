import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_ios.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../components/image/show_image.dart';
import '../../../data_app_controller.dart';

class ContentCtv extends StatelessWidget {
  Product productShow;
  ContentCtv({required this.productShow});

  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
            Text(
              "Nội dung đăng bán",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "*Có thể thay đổi nội dung theo cá nhân đăng bán",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: (productShow.images ?? [])
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                ShowImage().seeImage(
                                    listImageUrl: (productShow.images ?? [])
                                        .map((e) => e.imageUrl ?? '')
                                        .toList(),
                                    index:
                                        (productShow.images ?? []).indexOf(e));
                              },
                              child: Container(
                                width: (Get.width - 50) / 4,
                                height: (Get.width - 50) / 4,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl: e.imageUrl ?? "",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          SahaEmptyImage(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Link mua hàng:"),
                  Text(
                    "${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("${productShow.contentForCollaborator ?? ""}")
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "Link mua hàng: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}"));
                          SahaAlert.showSuccess(
                            message: "Đã sao chép",
                          );
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              "SAO CHÉP",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge!
                                      .color),
                            ))),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () async {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "Link mua hàng: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}"));
                          urlToFile(productShow.images!
                              .map((e) => e.imageUrl)
                              .toList(),"${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}");
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.25),
                            ),
                            child: Center(
                                child: Text(
                              "ĐĂNG BÁN",
                              style: TextStyle(
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                              ),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          )),
    );
  }

  Future<void> urlToFile(List<String?>? listUrl,String? link) async {
    LoadingiOS().onLoading();

    final cache = DefaultCacheManager(); // Gives a Singleton instance
    imagePaths = [];
    for (var image in (listUrl ?? [])) {
      final file = await cache.getSingleFile(image);

      imagePaths.add(file.path);
    }
    Get.back();
    _onShare(link);
  }

  List<String> imagePaths = [];
  Future<void> _onShare(String? link) async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    // await  Share.share(
    //     "Link mua hàng: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/id-${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}",
    //     subject: "",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    await Share.shareFiles(imagePaths,text: link);
  }
}
