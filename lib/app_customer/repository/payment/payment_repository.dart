import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/payment_customer/payment_method_response.dart';
import '../handle_error.dart';

class PaymentRepository {
  Future<PaymentMethodCustomerResponse?> getPaymentMethod() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPaymentMethod(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
