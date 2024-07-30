import 'package:sahashop_customer/app_customer/data/example/category.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import '../../utils/thread_data.dart';
import '../../model/category.dart';

class CategoryRepository {
  Future<List<Category>?> getAllCategory() async {
    if (FlowData().isOnline()) {
      try {
        var res = await CustomerServiceManager()
            .service!
            .getAllCategory(StoreInfo().getCustomerStoreCode());
        return res.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      return LIST_CATEGORY_EXAMPLE;
    }
    return null;
  }
}
