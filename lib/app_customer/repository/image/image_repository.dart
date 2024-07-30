import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../handle_error.dart';

class ImageRepository {
  Future<String?> uploadImage(File? image) async {
    try {
      var res = await CustomerServiceManager().service!.uploadImage(
        StoreInfo().getCustomerStoreCode(),
        {
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
    Future<String?> uploadVideo({File? video, required String type}) async {
    try {
      var res = await CustomerServiceManager().service!.uploadVideo(
          StoreInfo().getCustomerStoreCode(),
        {
          "video":
          video == null ? null : await MultipartFile.fromFile(video.path),
          "type": type
        },
      );
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
