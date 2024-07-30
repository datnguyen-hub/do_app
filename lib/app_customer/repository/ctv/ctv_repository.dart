import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/general_info_payment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/info_payment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/info_request.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/payment_ctv_history_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/report_rose_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/orders/order_history_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/success/success_response.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../model/ctv.dart';
import '../../remote/response-request/ctv/ctv_res.dart';

class CtvCustomerRepository {
  Future<SuccessResponse?> registerCtv(bool isCollab) async {
    try {
      var res = await CustomerServiceManager().service!.registerCTV(
          StoreInfo().getCustomerStoreCode(), {"is_collaborator": isCollab});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<InfoPaymentResponse?> updateInfoCTV(
      InfoPaymentRequest infoPaymentRequest) async {
    try {
      var res = await CustomerServiceManager().service!.updateInfoCTV(
          StoreInfo().getCustomerStoreCode(), infoPaymentRequest.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<InfoPaymentResponse?> getInfoCTV() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getInfoCTV(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

   Future<CtvRes?> updateCollaboratorInfo(
      {required Ctv ctv}) async {
    try {
      var res = await CustomerServiceManager().service!.updateCollaboratorInfo(
          StoreInfo().getCustomerStoreCode(), ctv.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

    Future<CtvRes?> getCollaboratorInfo(
      ) async {
    try {
      var res = await CustomerServiceManager().service!.getCollaboratorInfo(
          StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<OrderHistoryResponse?> getOrderCTVHistory({
    required int numberPage,
    String? search,
    String? fieldBy,
    String? filterByValue,
    String? sortBy,
    String? descending,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      var res = await CustomerServiceManager().service!.getOrderCTVHistory(
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
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PaymentCtvHistoryResponse?> getPaymentCtvHistory() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPaymentCtvHistory(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ReportRoseResponse?> getReportRose(int? page) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getReportRose(StoreInfo().getCustomerStoreCode(), page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> receiveMoneyCtv(int year, int month) async {
    try {
      var res = await CustomerServiceManager().service!.receiveMoneyCtv(
          StoreInfo().getCustomerStoreCode(), {"year": year, "month": month});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<GeneralInfoPaymentResponse?> getGeneralInfoPaymentCtv() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getGeneralInfoPaymentCtv(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> requestPayment() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .requestPayment(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
