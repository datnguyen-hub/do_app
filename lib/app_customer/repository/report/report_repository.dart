import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/report/report_response.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

class ReportRepository {
  Future<ReportResponse?> getReport(
    String timeFrom,
    String timeTo,
    String dateFromCompare,
    String dateToCompare,
  ) async {
    try {
      var res = await CustomerServiceManager().service!.getReport(
            StoreInfo().getCustomerStoreCode()!,
            timeFrom,
            timeTo,
            dateFromCompare,
            dateToCompare,
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ReportResponse?> getReportAgency(
    String timeFrom,
    String timeTo,
    String dateFromCompare,
    String dateToCompare,
    bool isCtv,
  ) async {
    try {
      if (isCtv) {
        var res = await CustomerServiceManager().service!.getReportAgencyCvt(
              StoreInfo().getCustomerStoreCode()!,
              timeFrom,
              timeTo,
              dateFromCompare,
              dateToCompare,
            );
        return res;
      } else {
        var res = await CustomerServiceManager().service!.getReportAgency(
              StoreInfo().getCustomerStoreCode()!,
              timeFrom,
              timeTo,
              dateFromCompare,
              dateToCompare,
            );
        return res;
      }
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
