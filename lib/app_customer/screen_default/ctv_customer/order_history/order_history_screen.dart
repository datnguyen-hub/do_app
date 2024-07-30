import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'order_status_page/order_status_page.dart';

class OrderHistoryCtvScreen extends StatelessWidget {
  final int? initPage;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  const OrderHistoryCtvScreen(
      {Key? key, this.initPage, this.dateFrom, this.dateTo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
        child: OrderHistoryLoggedScreen(
      initPage: initPage,
      dateFrom: dateFrom,
      dateTo: dateTo,
    ));
  }
}

class OrderHistoryLoggedScreen extends StatefulWidget {
  final int? initPage;
   DateTime? dateFrom;
   DateTime? dateTo;

  OrderHistoryLoggedScreen(
      {Key? key, this.initPage, this.dateFrom, this.dateTo})
      : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryLoggedScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket bucket = PageStorageBucket();
  TabController? tabController;

  @override
  void initState() {
    tabController = new TabController(
        length: 11, vsync: this, initialIndex: widget.initPage ?? 0);
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đơn mua'),
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SizedBox(
                          width: Get.width * 0.9,
                          height: Get.height * 0.5,
                          child: SfDateRangePicker(
                            cancelText:
                                widget.dateFrom == null && widget.dateTo == null
                                    ? "Quay lại"
                                    : "Huỷ lọc",
                            onCancel: () {
                              if ( widget.dateFrom == null &&  widget.dateTo == null) {
                                Get.back();
                              } else {
                                 widget.dateFrom = null;
                                 widget.dateTo = null;
                                setState(() {});
                                Get.back();
                              }
                            },
                            onSubmit: (v) {
                              setState(() {});
                              Get.back();
                            },
                            showActionButtons: true,
                            onSelectionChanged: chooseRangeTime,
                            selectionMode: DateRangePickerSelectionMode.range,
                            initialSelectedRange: PickerDateRange(
                               widget.dateFrom,
                               widget.dateTo,
                            ),
                            maxDate: DateTime.now(),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.calendar_month_sharp,
                  color: Colors.white,
                ))
          ],
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [
              Tab(text: "Chờ xác nhận"),
              Tab(text: "Đang chuẩn bị hàng"),
              Tab(text: "Đang giao hàng"),
              Tab(text: "Đã hoàn thành"),
              Tab(text: "Hết hàng"),
              Tab(text: "Shop huỷ"),
              Tab(text: "Khách đã huỷ"),
              Tab(text: "Lỗi giao hàng"),
              Tab(text: "Chờ trả hàng"),
              Tab(text: "Đã trả hàng"),
              Tab(text: "Tất cả"),
            ],
          ),
        ),
        body: PageStorage(
          bucket: bucket,
          child: TabBarView(controller: tabController, children: [
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: WAITING_FOR_PROGRESSING,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: PACKING,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: SHIPPING,
              dateFrom:  widget.dateFrom,
              dateTo: widget. dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: COMPLETED,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: OUT_OF_STOCK,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: USER_CANCELLED,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_CANCELLED,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: DELIVERY_ERROR,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_RETURNING,
              dateFrom:  widget.dateFrom,
              dateTo: widget. dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_HAS_RETURNS,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: ALL,
              dateFrom:  widget.dateFrom,
              dateTo:  widget.dateTo,
            ),
          ]),
        ),
      ),
    );
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
       widget.dateFrom = args.value.startDate;
       widget.dateTo = args.value.endDate ?? args.value.startDate;
      print( widget.dateTo);
    }
  }
}
