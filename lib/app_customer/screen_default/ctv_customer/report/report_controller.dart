import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/chart_customer.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/report/report_response.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'option_report/chart_business.dart';

class ReportController extends GetxController {
  var timeNow = DateTime.now().obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var isCompare = false.obs;
  var listChart = RxList<Chart?>();
  var indexOption = 0.obs;
  var isTotalChart = true.obs;

  var reportPrimeTime = DataPrimeTime().obs;
  var reportCompareTime = DataCompareTime().obs;
  var isOpenOrderDetail = false.obs;
  var isLoading = false.obs;

  var differenceTotalFinal = 0.0.obs;
  var differenceOrder = 0.0.obs;
  var differenceCTV = 0.0.obs;
  var percentTotalFinal = 0.0.obs;
  var percentOrder = 0.0.obs;
  var percentCTV = 0.0.obs;

  List<String> listNameChartType = ["Doanh thu:", "Số đơn:", "Số CTV tăng:"];
  List<String> listMonth = [
    "Tháng 1",
    "Tháng 2",
    "Tháng 3",
    "Tháng 4",
    "Tháng 5",
    "Tháng 6",
    "Tháng 7",
    "Tháng 8",
    "Tháng 9",
    "Tháng 10",
    "Tháng 11",
    "Tháng 12",
  ];

  var listLineChart = RxList<LineSeries<SalesData?, String>>();

  /// order report_ctv_agency

  var orderPartiallyPaid = Chart().obs;
  var orderUnPaid = Chart().obs;
  var orderWaitingProcess = Chart().obs;
  var orderShipping = Chart().obs;
  var orderCompleted = Chart().obs;
  var orderCustomerCancel = Chart().obs;
  var orderUserCancel = Chart().obs;
  var orderWaitingReturn = Chart().obs;
  var orderWaitingRefunds = Chart().obs;
  var indexChart = 0.obs;
  int? collaboratorByCustomerId;
  int? agencyByCustomerId;

  ReportController({this.collaboratorByCustomerId, this.agencyByCustomerId}) {
    fromDay.value = timeNow.value;
    toDay.value = timeNow.value;
    getReport();
  }

  Future<void> refresh() async {
    fromDay.value = timeNow.value;
    toDay.value = timeNow.value;
    getReport();
  }

  void changeTypeChart(int index) {
    indexChart.value = index;
  }

  void openAndCloseOrderDetail() {
    isOpenOrderDetail.value = !isOpenOrderDetail.value;
  }

  Future<void> getReport() async {
    isLoading.value = true;
    try {
      DetailsByPaymentStatus? detailsByPaymentStatus;
      DetailsByOrderStatus? detailsByOrderStatus;
      var res = await CustomerRepositoryManager.reportRepository.getReport(
        fromDay.value.toIso8601String(),
        toDay.value.toIso8601String(),
        fromDayCP.value.toIso8601String(),
        toDayCP.value.toIso8601String(),
      );

      reportPrimeTime.value = res!.data!.dataPrimeTime!;
      reportCompareTime.value = res.data!.dataCompareTime ??
          DataCompareTime(totalOrderCount: 1000000);
      differenceTotalFinal.value = reportPrimeTime.value.totalFinal! -
          reportCompareTime.value.totalFinal!;
      differenceOrder.value = reportPrimeTime.value.totalOrderCount! -
          reportCompareTime.value.totalOrderCount!;
      differenceCTV.value =
          reportPrimeTime.value.totalCollaboratorRegCount!.toDouble() -
              reportCompareTime.value.totalCollaboratorRegCount!.toDouble();
      percentTotalFinal.value = differenceTotalFinal.value.abs() *
          100 /
          (reportPrimeTime.value.totalFinal! + 1);
      percentOrder.value = differenceOrder.value.abs() *
          100 /
          (reportPrimeTime.value.totalOrderCount! + 1);
      percentCTV.value = differenceCTV.value.abs() *
          100 /
          (reportPrimeTime.value.totalCollaboratorRegCount! + 1);

      detailsByPaymentStatus = res.data!.dataPrimeTime!.detailsByPaymentStatus;
      detailsByOrderStatus = res.data!.dataPrimeTime!.detailsByOrderStatus;
      orderPartiallyPaid.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.partiallyPaid!;
      orderUnPaid.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.unpaid!;
      orderWaitingProcess.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!
              .waitingForProgressing!;
      orderShipping.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.shipping!;
      orderCompleted.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.completed!;
      orderCustomerCancel.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.customerCancelled!;
      orderUserCancel.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.userCancelled!;
      orderWaitingReturn.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.customerReturning!;
      orderWaitingRefunds.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.refunds!;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
