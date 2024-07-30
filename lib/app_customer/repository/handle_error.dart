import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sahashop_customer/app_customer/utils/color.dart';

String handleErrorCustomer(err) {
  var error;
  if (err is DioException) {
    print("DioErrorType : ${err.type}");
    if (err.type == DioExceptionType.unknown) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.sendTimeout) {
      throw "Kết nối yếu hoặc không có mạng";
    }
     if (err.type == DioExceptionType.receiveTimeout) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.badCertificate) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.connectionTimeout) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.connectionError) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.badResponse) {
      try {
        error = jsonDecode((err.response ?? "").toString())['msg'];
      } catch (e) {
        error = "Có lỗi xảy ra";
      }

      throw error;
    }
    print("ERROR Diooo: ${jsonDecode((err.response ?? "").toString())['msg']}");
    throw "${jsonDecode((err.response ?? "").toString())['msg']}";
  } else {
    print("ERROR: ${err.toString()}");
    throw "Có lỗi xảy ra";
  }
}
