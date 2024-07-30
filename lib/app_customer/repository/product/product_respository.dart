import 'package:sahashop_customer/app_customer/data/example/product.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/favorite/all_product_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/product/product_watched_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/product/query_product_response.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../model/product.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/attribute_search/list_attribute_search_res.dart';
import '../../remote/response-request/product/detail_product_response.dart';
import '../../remote/response-request/product/product_scan_response.dart';
import '../../repository/handle_error.dart';
import '../../utils/thread_data.dart';

class ProductCustomerRepository {
  Future<QueryProductResponse?> searchProduct({
    String? search ,
    int page = 1,
    String? idCategory,
    String? idCategoryChild,
    bool? descending = false,
    String? details,
    String? sortBy,
    String? listAttributeSearch,
    bool? hasDiscount,
  }) async {
    if (FlowData().isOnline()) {
      try {
        print(listAttributeSearch);
        var res = await CustomerServiceManager().service!.searchProduct(
              StoreInfo().getCustomerStoreCode(),
              page,
              search,
              idCategory,
              idCategoryChild,
              listAttributeSearch,
              descending,
              details,
              hasDiscount == false ? null : hasDiscount,
              sortBy,
            );
        return res;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      return QueryProductResponse(data: DataPageProduct(data: EXAMPLE_LIST_PRODUCT));
    }
    return null;
  }

  Future<DetailProductResponse?> getDetailProduct(int? idProduct) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getDetailProduct(StoreInfo().getCustomerStoreCode(), idProduct);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ListAttributeSearchRes?> getAttributeSearch() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAttributeSearch(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllProductFavorites?> getAllPurchasedProducts({int? page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPurchasedProducts(StoreInfo().getCustomerStoreCode()!, page!);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllProductResponse?> getSimilarProduct(int idProduct) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getSimilarProduct(StoreInfo().getCustomerStoreCode()!, idProduct);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ProductWatchedResponse?> getWatchedProduct() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getWatchedProduct(StoreInfo().getCustomerStoreCode()!);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ProductScanCusResponse?> scanProduct(String barcode) async {
    try {
      var res = await CustomerServiceManager().service!.scanProduct(
          StoreInfo().getCustomerStoreCode(), {"barcode": barcode});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
