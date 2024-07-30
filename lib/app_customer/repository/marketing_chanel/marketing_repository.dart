import 'package:sahashop_customer/app_customer/remote/response-request/marketing_chanel/all_product_voucher_res.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/marketing_chanel/bonus_customer_response.dart';
import '../../remote/response-request/marketing_chanel/combo_customer_response.dart';
import '../../remote/response-request/marketing_chanel/voucher_customer_response.dart';
import '../handle_error.dart';

class MarketingRepository {
  Future<CustomerComboResponse?> getComboCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getComboCustomer(StoreInfo().getCustomerStoreCode());
      return res; 
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<VoucherCustomerResponse?> getVoucherCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getVoucherCustomer(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

    Future<AllProductVoucherRes?> getAllProductVoucher({required int page, required int voucherId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllProductVoucher(StoreInfo().getCustomerStoreCode(),voucherId,page);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllBonusCustomerRes?> getBonusCustomer({int? productId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getBonusCustomer(StoreInfo().getCustomerStoreCode(), productId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
