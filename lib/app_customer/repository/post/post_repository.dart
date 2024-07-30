import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../model/category_post.dart';
import '../../model/post.dart';
import '../handle_error.dart';

class PostCustomerRepository {
  Future<List<CategoryPost>?> getAllCategoryPost() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllCategoryPost(StoreInfo().getCustomerStoreCode());
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<List<Post>?> searchPost(
      {String search = "",
      String idCategory = "",
      bool descending = false,
      String sortBy = ""}) async {

      try {
        var res = await CustomerServiceManager().service!.searchPost(
            StoreInfo().getCustomerStoreCode(),
            search,
            idCategory,
            descending,
            sortBy);
        return res.data!.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
      return null;

  }

  Future<Post?> getDetailPost(int? idPost) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getDetailPost(StoreInfo().getCustomerStoreCode(), idPost);
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
