import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/socket/socket.dart';
import '../config_controller.dart';
import 'data_app_controller.dart';

class LoadAppScreen extends StatefulWidget {
  final String? logo;
  final String? slogan;
  final Color? sloganColor;

  const LoadAppScreen({Key? key, this.logo, this.slogan, this.sloganColor})
      : super(key: key);

  @override
  _LoadAppScreenState createState() => _LoadAppScreenState();
}

class _LoadAppScreenState extends State<LoadAppScreen> {
  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  var isInit = false;

  @override
  void initState() {
    loadInit(context);
    super.initState();
  }

  Future<void> loadInit(BuildContext context) async {
    isInit = true;
    await dataAppCustomerController.checkLogin();
    await dataAppCustomerController.getLayout();
    await Future.wait([
      configController.getAppTheme(),
      dataAppCustomerController.getBanner(),
      dataAppCustomerController.getWebTheme(),
      dataAppCustomerController.getHomeButton(),
      dataAppCustomerController.getAllCategory(),
      dataAppCustomerController.getBadge(),
      dataAppCustomerController.getProductDiscount(),
      dataAppCustomerController.getProductTopSale(),
      dataAppCustomerController.getProductNews(),
      dataAppCustomerController.getPostNew(),
      dataAppCustomerController.getPopup(),
      dataAppCustomerController.getBannerAdsApp(),
    ]);

    Get.offNamed('customer_home')!.then((value) {
      SocketCustomer().close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/logo_ios.png",
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              if (widget.slogan != null)
                Text(
                  widget.slogan!,
                  style: TextStyle(
                      color: widget.sloganColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )
            ],
          ),
        ),
      ),
    );
  }
}
