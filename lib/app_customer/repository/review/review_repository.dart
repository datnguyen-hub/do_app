import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../model/review.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/review/review_of_product_response.dart';
import '../../remote/response-request/review/review_response.dart';

import '../handle_error.dart';

class ReviewCustomerRepository {
  Future<ReviewResponse?> review(
   {required Review review,required int idProduct}
  ) async {
    try {
      var res = CustomerServiceManager().service!.review(
          StoreInfo().getCustomerStoreCode(), idProduct, review.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ReviewOfProResponse?> getReviewProduct(int idProduct, String? filterBy,
      String? filterByValue, bool? hasImage) async {
    try {
      var res = await CustomerServiceManager().service!.getReviewProduct(
          StoreInfo().getCustomerStoreCode(),
          idProduct,
          filterBy,
          filterByValue,
          hasImage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
