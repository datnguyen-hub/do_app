import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_order.dart';
import 'package:sahashop_customer/app_customer/screen_default/order_history/order_history_detail/order_detail_history_screen.dart';
import 'order_status_controller.dart';
import 'widget/order_item_widget.dart';
import 'widget/order_loading_item_widget.dart';

// ignore: must_be_immutable
class OrderStatusPage extends StatefulWidget {
  final String? fieldByValue;
  final String? fieldBy;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  OrderStatusPage(
      {Key? key, this.fieldBy, this.fieldByValue, this.dateFrom, this.dateTo})
      : super(key: key);

  OrderStatusController orderStatusController = OrderStatusController();

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late OrderStatusController orderStatusController;

  RefreshController _refreshController = RefreshController();
  late TabController tabController;
  @override
  void initState() {
    orderStatusController = widget.orderStatusController;
    orderStatusController.fieldBy = widget.fieldBy;
    orderStatusController.fieldByValue = widget.fieldByValue;
    orderStatusController.dateFrom = widget.dateFrom;
    orderStatusController.dateTo = widget.dateTo;
    orderStatusController.getAllOrder(isRefresh: true);
    tabController = new TabController(length: 10, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void didUpdateWidget(OrderStatusPage oldWidget) {
    orderStatusController = widget.orderStatusController;
    orderStatusController.fieldBy = widget.fieldBy;
    orderStatusController.fieldByValue = widget.fieldByValue;
    orderStatusController.dateFrom = widget.dateFrom;
    orderStatusController.dateTo = widget.dateTo;
    orderStatusController.getAllOrder(isRefresh: true);
    super.didUpdateWidget(oldWidget);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    print("abbbbb");
    // TODO: implement build
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (
          BuildContext context,
          LoadStatus? mode,
        ) {
          Widget body = Container();
          if (mode == LoadStatus.idle) {
            body = Obx(() => orderStatusController.isLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        await orderStatusController.getAllOrder(isRefresh: true);
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await orderStatusController.getAllOrder(isRefresh: false);
        _refreshController.loadComplete();
      },
      child: Obx(
        () => orderStatusController.isLoadRefresh.value
            ? ListView.builder(
                itemBuilder: (context, index) => OrderLoadingItemWidget(),
                itemCount: 2,
              )
            : SingleChildScrollView(
                child: orderStatusController.checkIsEmpty.value
                    ? SahaEmptyOrder()
                    : Column(
                        children: [
                          ...List.generate(
                            orderStatusController.listOrder.length,
                            (index) => OrderItemWidget(
                              order: orderStatusController.listOrder[index],
                              checkReview: orderStatusController
                                  .listCheckReviewed[index],
                              onTap: () {
                                Get.to(
                                  () => OrderHistoryDetailScreen(
                                    orderCode: orderStatusController
                                            .listOrder[index].orderCode ??
                                        "",
                                  ),
                                )!
                                    .then((value) => {
                                          if (value == "CANCELLED")
                                            {
                                              tabController.animateTo(6),
                                              orderStatusController.getAllOrder(
                                                  isRefresh: true),
                                            },
                                        });
                              },
                              thenReview: () {
                                orderStatusController.listCheckReviewed[index] =
                                    true;
                              },
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
