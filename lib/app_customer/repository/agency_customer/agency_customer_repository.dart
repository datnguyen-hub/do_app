import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/model/agency.dart';
import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/general_info_payment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/info_payment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/info_request.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/payment_agency_history_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/report_rose_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/orders/order_history_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/success/success_response.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/response-request/agency/agency_res.dart';
import '../../remote/response-request/agency/all_referral_agency_res.dart';
import '../handle_error.dart';

class AgencyCustomerRepository {
  Future<SuccessResponse?> registerAgency(bool isCollab) async {
    try {
      var res = await CustomerServiceManager().service!.registerAgency(
          StoreInfo().getCustomerStoreCode(), {"is_agency": isCollab});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllReferralAgencyRes?> getAllReferralAgency(int page,{DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllReferralAgency(StoreInfo().getCustomerStoreCode()!, page, timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
    Future<AllReferralAgencyRes?> getAllCollaborator(int page,{DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllCollaborator(StoreInfo().getCustomerStoreCode()!, page, timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<InfoPaymentAgencyResponse?> updateInfoAgency(
      InfoPaymentAgencyRequest infoPaymentRequest) async {
    try {
      var res = await CustomerServiceManager().service!.updateInfoAgency(
          StoreInfo().getCustomerStoreCode(), infoPaymentRequest.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<InfoPaymentAgencyResponse?> getInfoAgency() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getInfoAgency(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<OrderHistoryResponse?> getOrderAgencyHistory({
    required int numberPage,
    String? search,
    String? fieldBy,
    String? filterByValue,
    String? sortBy,
    String? descending,
    String? dateFrom,
    String? dateTo,
    required bool isCtv,
  }) async {
    try {
      if (isCtv) {
        var res = await CustomerServiceManager()
            .service!
            .getOrderAgencyCtvHistory(
                StoreInfo().getCustomerStoreCode(),
                numberPage,
                search,
                fieldBy,
                filterByValue,
                sortBy,
                descending,
                dateFrom,
                dateTo);
        return res;
      } else {
        var res = await CustomerServiceManager().service!.getOrderAgencyHistory(
            StoreInfo().getCustomerStoreCode(),
            numberPage,
            search,
            fieldBy,
            filterByValue,
            sortBy,
            descending,
            dateFrom,
            dateTo);
        return res;
      }
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PaymentAgencyHistoryResponse?> getPaymentAgencyHistory() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPaymentAgencyHistory(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ReportRoseAgencyResponse?> getReportAgencyRose(int? page) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getReportAgencyRose(StoreInfo().getCustomerStoreCode(), page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> receiveMoneyAgency(int year, int month) async {
    try {
      var res = await CustomerServiceManager().service!.receiveMoneyAgency(
          StoreInfo().getCustomerStoreCode(), {"year": year, "month": month});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<GeneralInfoPaymentAgencyResponse?>
      getGeneralInfoPaymentAgency() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getGeneralInfoPaymentAgency(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> requestPaymentAgency() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .requestPaymentAgency(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
   Future<AgencyRes?> updateAgencyInfo({required Agency agency}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .updateAgencyInfo(StoreInfo().getCustomerStoreCode(),agency.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
    Future<AgencyRes?> getAgencyInfo() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAgencyInfo(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
