import 'package:sahashop_customer/app_customer/model/home_data.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/home/web_theme_res.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import 'package:sahashop_customer/app_customer/utils/thread_data.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/home/banner_ads_app_res.dart';
import '../../remote/response-request/home/banner_res.dart';
import '../../remote/response-request/home/home_button_res.dart';
import '../../remote/response-request/home/layout_res.dart';
import '../../remote/response-request/home/popup_res.dart';
import '../../remote/response-request/home/post_new_res.dart';
import '../../remote/response-request/home/product_by_category_res.dart';
import '../../remote/response-request/home/product_discount_res.dart';
import '../../repository/handle_error.dart';

class HomeDataRepository {
  Future<HomeData?> getHomeData() async {
    try {
      if (FlowData().isOnline()) {
        var res = await CustomerServiceManager()
            .service!
            .getHomeApp(StoreInfo().getCustomerStoreCode(), "FROM_APP");
        return res.data;
      } else {
        print(
          StoreInfo().getCustomerStoreCode(),
        );
        var res = await CustomerServiceManager()
            .service!
            .getHomeApp(StoreInfo().getCustomerStoreCode(), "FROM_APP");
        return res.data;
      }
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<BannerRes?> getBanner() async {
    try {
      var res = await CustomerServiceManager().service!.getBanner(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
   Future<WebThemeRes?> getWebTheme() async {
    try {
      var res = await CustomerServiceManager().service!.getWebTheme(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<BannerAdsAppRes?> getBannerAdsApp() async {
    try {
      var res = await CustomerServiceManager().service!.getBannerAdsApp(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ProductHomeRes?> getProductDiscount() async {
    try {
      var res = await CustomerServiceManager().service!.getProductDiscount(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ProductHomeRes?> getProductTopSale() async {
    try {
      var res = await CustomerServiceManager().service!.getProductTopSale(
        StoreInfo().getCustomerStoreCode(),
      );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ProductByCategoryRes?> getProductByCategory() async {
    try {
      var res = await CustomerServiceManager().service!.getProductByCategory(
        StoreInfo().getCustomerStoreCode(),
      );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<ProductHomeRes?> getProductNews() async {
    try {
      var res = await CustomerServiceManager().service!.getProductNews(
        StoreInfo().getCustomerStoreCode(),
      );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PostNewRes?> getPostNew() async {
    try {
      var res = await CustomerServiceManager().service!.getPostNew(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<LayoutRes?> getLayout() async {
    try {
      var res = await CustomerServiceManager().service!.getLayout(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<HomeButtonRes?> getHomeButton() async {
    try {
      var res = await CustomerServiceManager().service!.getHomeButton(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PopupRes?> getPopup() async {
    try {
      var res = await CustomerServiceManager().service!.getPopup(
            StoreInfo().getCustomerStoreCode(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
