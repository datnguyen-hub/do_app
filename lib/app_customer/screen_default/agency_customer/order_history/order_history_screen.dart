import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'order_status_page/order_status_page.dart';

class OrderHistoryAgencyScreen extends StatelessWidget {
  final int? initPage;
  bool isCtv;
  DateTime? dateFrom;
  DateTime? dateTo;
  OrderHistoryAgencyScreen(
      {Key? key,
      this.initPage,
      required this.isCtv,
      this.dateFrom,
      this.dateTo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
        child: OrderHistoryLoggedScreen(initPage: initPage, isCtv: isCtv,dateFrom: dateFrom,dateTo: dateTo,));
  }
}

class OrderHistoryLoggedScreen extends StatefulWidget {
  final int? initPage;
  bool isCtv;
  DateTime? dateFrom;
  DateTime? dateTo;

  OrderHistoryLoggedScreen(
      {Key? key,
      this.initPage,
      required this.isCtv,
      this.dateFrom,
      this.dateTo})
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
      length: 11,
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
                            cancelText: widget.dateFrom == null && widget.dateTo == null
                                ? "Quay lại"
                                : "Huỷ lọc",
                            onCancel: () {
                              if (widget.dateFrom == null && widget.dateTo == null) {
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
              Tab(
                text: "Tất cả",
              ),
            ],
          ),
        ),
        body: PageStorage(
          bucket: bucket,
          child: TabBarView(controller: tabController, children: [
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: WAITING_FOR_PROGRESSING,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: PACKING,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: SHIPPING,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: COMPLETED,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: OUT_OF_STOCK,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: USER_CANCELLED,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_CANCELLED,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: DELIVERY_ERROR,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_RETURNING,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_HAS_RETURNS,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: ALL,
              isCtv: widget.isCtv,
              dateFrom: widget.dateFrom,
              dateTo: widget.dateTo,
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
      print(widget.dateTo);
    }
  }
}
