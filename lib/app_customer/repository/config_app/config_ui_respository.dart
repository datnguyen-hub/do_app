import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import '../../model/config_app.dart';

class ConfigUICustomerRepository {
  Future<ConfigApp?> getAppTheme() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAppTheme(StoreInfo().getCustomerStoreCode());
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
