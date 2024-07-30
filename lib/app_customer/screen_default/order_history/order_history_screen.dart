import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/widget/choose_time/choose_time_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/check_login/check_login.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../model/order.dart';
import 'order_status_page/order_status_controller.dart';
import 'order_status_page/order_status_page.dart';

class OrderHistoryScreen extends StatelessWidget {
  final int? initPage;
  bool? isAutoBackIcon;
  OrderHistoryScreen({Key? key, this.initPage, this.isAutoBackIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
        child: OrderHistoryLoggedScreen(
      initPage: initPage,
      isAutoBackIcon: isAutoBackIcon,
    ));
  }
}

class OrderHistoryLoggedScreen extends StatefulWidget {
  final int? initPage;
  bool? isAutoBackIcon;
  OrderHistoryLoggedScreen({Key? key, this.initPage, this.isAutoBackIcon})
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
  DateTime? dateFrom;
  DateTime? dateTo;
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
          automaticallyImplyLeading: widget.isAutoBackIcon ?? true,
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
                            cancelText: dateFrom == null && dateTo == null
                                ? "Quay lại"
                                : "Huỷ lọc",
                            onCancel: () {
                              if (dateFrom == null && dateTo == null) {
                                Get.back();
                              } else {
                                dateFrom = null;
                                dateTo = null;
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
                              dateFrom,
                              dateTo,
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
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: PACKING,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: SHIPPING,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: COMPLETED,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: OUT_OF_STOCK,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: USER_CANCELLED,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_CANCELLED,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: DELIVERY_ERROR,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_RETURNING,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_HAS_RETURNS,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: ALL,
              dateFrom: dateFrom,
              dateTo: dateTo,
            ),
          ]),
        ),
      ),
    );
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      dateFrom = args.value.startDate;
      dateTo = args.value.endDate ?? args.value.startDate;
      print(dateTo);
    }
  }
}
