import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../model/cart.dart';
import '../../model/order.dart';

import '../handle_error.dart';

class CartRepository {
  Future<Cart?> getItemCart(String? codeVoucher, bool isUsePoints,
      bool isUseBalanceCollaborator, double? totalShippingFee) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getItemCart(StoreInfo().getCustomerStoreCode(), {
        "code_voucher": codeVoucher,
        "is_use_points": isUsePoints,
        "is_use_balance_collaborator": isUseBalanceCollaborator,
        "total_shipping_fee": totalShippingFee,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<Cart?> addVoucherCart({required String codeVoucher,required bool isUsePoints,
    required bool isUseBalanceCollaborator,required double? totalShippingFee, required bool isUseBalanceAgency,required bool isOrderForCustomer}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .addVoucherCart(StoreInfo().getCustomerStoreCode(), {
        "code_voucher": codeVoucher,
        "is_use_points": isUsePoints,
        "is_use_balance_collaborator": isUseBalanceCollaborator,
        "is_use_balance_agency": isUseBalanceAgency,
        "total_shipping_fee": totalShippingFee,
        "is_order_for_customer": isOrderForCustomer
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<Cart?> updateItemCart(int? cartItemId, int productId, int quantity,
      List<DistributesSelected> listDistributes, String codeVoucher,String? note) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .updateItemCart(StoreInfo().getCustomerStoreCode(), {
        "line_item_id": cartItemId,
        "product_id": productId,
        "quantity": quantity,
        "distributes":
            List<dynamic>.from(listDistributes.map((x) => x.toJson())),
        "code_voucher": codeVoucher,
        "note":note
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<Cart?> addItemCart(
    int? idProduct,
    int quantity,
    List<DistributesSelected> listDistributes,
  ) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .addItemCart(StoreInfo().getCustomerStoreCode(), {
        "product_id": idProduct,
        "quantity": quantity,
        "distributes":
            List<dynamic>.from(listDistributes.map((x) => x.toJson())),
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
