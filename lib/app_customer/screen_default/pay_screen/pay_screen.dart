import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sahashop_customer/app_customer/const/env.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

class PayScreen extends StatelessWidget {
  final String? orderCode;
  PayScreen({this.orderCode});

  @override
  Widget build(BuildContext context) {
    print(
        "${DOMAIN_API_CUSTOMER}customer/${StoreInfo().getCustomerStoreCode()}/purchase/pay/$orderCode");
    return Scaffold(
        appBar: AppBar(
          title: Text("Thanh toán"),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(
                "${DOMAIN_API_CUSTOMER}customer/${StoreInfo().getCustomerStoreCode()}/purchase/pay/$orderCode"),
          ),
        ));
  }
}
