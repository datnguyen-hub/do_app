import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/shipment/all_shipping_company_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/shipment/shipment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/shipment/type_ship_res.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../handle_error.dart';

class ShipmentRepository {
  Future<ShipmentCustomerResponse?> chargeShipmentFee(
      {int? idAddressCustomer,int? branchId}) async {
    try {
      var res = await CustomerServiceManager().service!.chargeShipmentFee(
          StoreInfo().getCustomerStoreCode(),
          {
            "id_address_customer": idAddressCustomer,
            "branch_id": branchId
          });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

   Future<AllShippingCompanyRes?> getAllShippingCompany(
      int? idAddressCustomer) async {
    try {
      var res = await CustomerServiceManager().service!.getAllShippingCompany(
          StoreInfo().getCustomerStoreCode(),
          {"id_address_customer": idAddressCustomer});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

    Future<TypeShipRes?> getTypeShip(
      {int? idAddressCustomer,required int idCompany}) async {
    try {
      var res = await CustomerServiceManager().service!.getTypeShip(
          StoreInfo().getCustomerStoreCode(),
          idCompany,
          {"id_address_customer": idAddressCustomer});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
