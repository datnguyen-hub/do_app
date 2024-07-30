import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/home_data.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

import '../../../../components/widget/blinking_text.dart';
import '../../../../model/product.dart';
import '../../../../utils/action_tap.dart';
import '../../../product_item_widget/product_item_sale/product_item_sale.dart';
import '../../../product_item_widget/product_item_widget.dart';

class FlashSale extends StatefulWidget {
  LayoutHome layoutHome;

  FlashSale({
    required this.layoutHome,
  });

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale>
    with SingleTickerProviderStateMixin {
  DataAppCustomerController dataAppCustomerController = Get.find();
  CustomTimerController controllerTimer = CustomTimerController();

  @override
  void initState() {
    checkSale();
    super.initState();
  }

  void checkSale() {
    if (widget.layoutHome.list!.cast<Product>().isEmpty) {
      return;
    } else {
      if (widget.layoutHome.list!
              .cast<Product>()
              .first
              .productDiscount
              ?.endTime ==
          null) {
        return;
      }

      controllerTimer.start();
    }
  }

  @override
  dispose() {
    controllerTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 15, left: 5, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Góc trên trái
            bottomLeft: Radius.circular(20.0), // Góc trên phải
          ),
          color: Theme.of(context).primaryColor),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Image.asset(
                  "packages/sahashop_customer/assets/images/flashsale_hot.webp",
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                BlinkText("FLASH SALE".toUpperCase(),
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                    beginColor: Colors.yellow,
                    endColor: Colors.red,
                    times: 1000,
                    duration: Duration(milliseconds: 500)),
                SizedBox(
                  width: 10,
                ),
                if (widget.layoutHome.list!
                        .cast<Product>()
                        .first
                        .productDiscount
                        ?.endTime !=
                    null)
                  CustomTimer(
                    controller: controllerTimer,
                    begin: widget.layoutHome.list!
                        .cast<Product>()
                        .first
                        .productDiscount!
                        .endTime!
                        .difference(DateTime.now()),
                    end: Duration(),
                    builder: (time) {
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "${time.hours}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "${time.minutes}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "${time.seconds}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                Spacer(),
                InkWell(
                  onTap: () {
                    ActionTap.onTap(
                      typeAction:
                          widget.layoutHome.typeLayout == 'PRODUCT_BY_CATEGORY'
                              ? 'PRODUCT_BY_CATEGORY'
                              : widget.layoutHome.typeActionMore ??
                                  "CATEGORY_PRODUCT",
                      value: widget.layoutHome.value,
                    );
                  },
                  child: Text(
                    "Tất cả",
                    style: TextStyle(
                      color: SahaColorUtils().colorTextWithPrimaryColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 8, right: 0, bottom: 0),
            child: Container(
              height: dataAppCustomerController
                              .infoCustomer.value.isCollaborator ==
                          true ||
                      dataAppCustomerController.infoCustomer.value.isAgency ==
                          true
                  ? 330
                  : 300,
              width: widget.layoutHome.list!.cast<Product>().length * 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.layoutHome.list!.cast<Product>().length,
                  itemBuilder: (context, index) {
                    return ProductItemWidget(
                      width: 180,
                      product: widget.layoutHome.list!.cast<Product>()[index],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
