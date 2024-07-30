import 'package:sahashop_customer/app_customer/remote/response-request/orders/all_branches_res.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/orders/cancel_order_response.dart';
import '../../remote/response-request/orders/order_history_response.dart';
import '../../remote/response-request/orders/order_request.dart';
import '../../remote/response-request/orders/order_response.dart';
import '../../remote/response-request/orders/state_history_order_customer_response.dart';
import '../../repository/handle_error.dart';

class OrderCustomerRepository {
  Future<OrderResponse?> createOrder(OrderRequest orderRequest) async {
    try {
      var res = await CustomerServiceManager().service!.createOrder(
            StoreInfo().getCustomerStoreCode(),
            orderRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<OrderHistoryResponse?> getOrderHistory({
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
      var res = await CustomerServiceManager().service!.getOrderHistory(
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

  Future<StateHistoryOrderCustomerResponse?> getStateHistoryCustomerOrder(
      int? idOrder) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getStateHistoryCustomerOrder(
              StoreInfo().getCustomerStoreCode(), idOrder);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CancelOrderResponse?> cancelOrder(
      String? orderCode, String reasonCancel) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .cancelOrder(StoreInfo().getCustomerStoreCode(), {
        "order_code": orderCode,
        "note": reasonCancel,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<OrderResponse?> getOneOrderHistory(String? orderCode) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getOneOrderHistory(StoreInfo().getCustomerStoreCode(), orderCode);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CancelOrderResponse?> changePaymentMethod(
      String? orderCode, int? paymentMethodId, int? paymentPartnerId) async {
    try {
      var res = await CustomerServiceManager().service!.changePaymentMethod(
          StoreInfo().getCustomerStoreCode(),
          {
            "payment_method_id": paymentMethodId,
            "payment_partner_id": paymentPartnerId,
          },
          orderCode);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllBranchesRes?> getAllBranches() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllBranches(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
