import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_widget_to_image/flutter_widget_to_image.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sahashop_customer/app_customer/screen_default/product_qr/share_qr_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/toast/saha_alert.dart';
import '../data_app_controller.dart';

class ShareQrScreen extends StatelessWidget {
  ShareQrScreen({super.key, this.idProduct, this.idPost, this.listImage});

  final DataAppCustomerController dataAppCustomerController = Get.find();
  final int? idProduct;
  final int? idPost;
  final List<String>? listImage;
  ProductQrController productQrController = ProductQrController();
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(idProduct == null ? 'Chia sẻ bài đăng' : 'Chia sẻ sản phẩm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hãy chia sẻ mã QR này cho người khác',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: BarcodeWidget(
                      barcode: Barcode.qrCode(), // Barcode type and settings
                      data: idProduct != null
                          ? productQrController.linkQr(productId: idProduct)
                          : idPost != null
                          ? productQrController.linkQr(postId: idPost)
                          : '',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Divider(),
                Row(
                     //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(
                        child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Link chia sẻ:',
                              style:
                              TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                             const SizedBox(
                            height: 4,
                          ),
                          Text(
                            idProduct != null
                                ? productQrController.linkQr(
                                    productId: idProduct)
                                : idPost != null
                                    ? productQrController.linkQr(postId: idPost)
                                    : '',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: idProduct != null
                                        ? productQrController.linkQr(
                                            productId: idProduct)
                                        : idPost != null
                                            ? productQrController.linkQr(
                                                postId: idPost)
                                            : ''));
                                SahaAlert.showSuccess(
                                    message: 'Copy thành công');
                              },
                              child: Text(
                                "[Sao chép]",
                                style: TextStyle(color: Colors.blue),
                              ))

                          ],
                        )),
                    IconButton(
                        onPressed: () async {
                            // await Clipboard.setData(ClipboardData(
                          //     text: idProduct != null
                          //         ? productQrController.linkQr(
                          //             productId: idProduct)
                          //         : idPost != null
                          //             ? productQrController.linkQr(
                          //                 postId: idPost)
                          //             : ''));
                          print(idProduct != null
                              ? productQrController.linkQr(productId: idProduct)
                              : idPost != null
                                  ? productQrController.linkQr(postId: idPost)
                                  : '');
                          _onShareLink(
                            listImage,
                            idProduct != null
                                ? productQrController.linkQr(
                                    productId: idProduct)
                                : idPost != null
                                    ? productQrController.linkQr(postId: idPost)
                                    : '',
                          );

                        },
                        icon: Icon(Icons.share)),
                  ],
                ),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                          'Chia sẻ mã QR:',
                          style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                        )),
                    IconButton(
                        onPressed: () async {
                          var test = Container(
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green),
                            ),
                            child: BarcodeWidget(
                              barcode:
                              Barcode.qrCode(), // Barcode type and settings
                              data: idProduct != null
                                  ? productQrController.linkQr(
                                  productId: idProduct)
                                  : idPost != null
                                  ? productQrController.linkQr(
                                  postId: idPost)
                                  : '',
                            ),
                          ).build(context);
                          var qrImage = await QrPainter(
                            data:  idProduct != null
                                ? productQrController.linkQr(
                                productId: idProduct)
                                : idPost != null
                                ? productQrController.linkQr(
                                postId: idPost)
                                : '',
                            version: QrVersions.auto,
                            errorCorrectionLevel: QrErrorCorrectLevel.L,
                          ).toImageData(200);
                          var file = await saveByteDataToFile(qrImage!);
                          String path = file.path;
                          GallerySaver.saveImage(path).then((bool? success) {
                            if (success == true) {
                              SahaAlert.showSuccess(message: "Đã lưu");
                            }
                          });
                          await Clipboard.setData(ClipboardData(
                              text: idProduct != null
                                  ? productQrController.linkQr(
                                  productId: idProduct)
                                  : idPost != null
                                  ? productQrController.linkQr(
                                  postId: idPost)
                                  : ''));
                          _onShare(path);
                        },
                        icon: Icon(Icons.share)),
                  ],
                ),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                          'Lưu vào thư viện ảnh:',
                          style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                        )),
                    IconButton(
                        onPressed: () async {
                          var test = Container(
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green),
                            ),
                            child: BarcodeWidget(
                              barcode:
                              Barcode.qrCode(), // Barcode type and settings
                              data: idProduct != null
                                  ? productQrController.linkQr(
                                  productId: idProduct)
                                  : idPost != null
                                  ? productQrController.linkQr(
                                  postId: idPost)
                                  : '',
                            ),
                          ).build(context);
                          var qrImage = await QrPainter(
                            data:  idProduct != null
                                ? productQrController.linkQr(
                                productId: idProduct)
                                : idPost != null
                                ? productQrController.linkQr(
                                postId: idPost)
                                : '',
                            version: QrVersions.auto,
                            errorCorrectionLevel: QrErrorCorrectLevel.L,
                          ).toImageData(200);
                          var file = await saveByteDataToFile(qrImage!);
                          String path = file.path;
                          GallerySaver.saveImage(path).then((bool? success) {
                            if (success == true) {
                              SahaAlert.showSuccess(message: "Đã lưu");
                            }
                          });
                        },
                        icon: Icon(Icons.get_app)),
                  ],
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onShare(String path) async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    // await  Share.share(
    //     "Link mua hàng: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/id-${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}",
    //     subject: "",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    await Share.shareFiles([path]);
  }

  Future<void> _onShareLink(List<String>? listUrl, String text) async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    final cache = DefaultCacheManager(); // Gives a Singleton instance
    var imagePaths = <String>[];
    for (var image in (listUrl ?? [])) {
      final file = await cache.getSingleFile(image);

      imagePaths.add(file.path);
    }
    // await  Share.share(
//     "Link mua hàng: ${dataAppCustomerController.badge.value.domain == null || dataAppCustomerController.badge.value.domain == "" ? "${StoreInfo().getCustomerStoreCode()}.myiki.vn" : dataAppCustomerController.badge.value.domain}/san-pham/id-${productShow.id}?cowc_id=${dataAppCustomerController.infoCustomer.value.id}\n\n${productShow.contentForCollaborator ?? ""}",
    //     subject: "",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    await Share.shareFiles(imagePaths, text: text);
  }
  Future<File> saveByteDataToFile(ByteData byteData,) async {
    final buffer = byteData.buffer;
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final file = File('$tempPath/qr_code.png');
    await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
}