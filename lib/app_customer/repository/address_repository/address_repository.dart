import 'package:sahashop_customer/app_customer/remote/response-request/address/address_respone.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/address_customer/address_customer_request.dart';
import '../../remote/response-request/address_customer/all_address_customer_response.dart';
import '../../remote/response-request/address_customer/create_update_address_customer_response.dart';
import '../../remote/response-request/address_customer/delete_address_customer_response.dart';

import '../handle_error.dart';

class AddressRepository {
  Future<AddressResponse?> getProvince() async {
    try {
      var res = await CustomerServiceManager().service!.getProvince();
      return res;
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AddressResponse?> getDistrict(int? idProvince) async {
    try {
      var res = await CustomerServiceManager().service!.getDistrict(idProvince);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AddressResponse?> getWard(int? idDistrict) async {
    try {
      var res = await CustomerServiceManager().service!.getWard(idDistrict);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllIAddressCustomerResponse?> getAllAddressCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllAddressCustomer(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CreateUpdateAddressCustomerResponse?> createAddressCustomer(
      AddressCustomerRequest addressCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service!.createAddressCustomer(
          StoreInfo().getCustomerStoreCode(), addressCustomerRequest.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CreateUpdateAddressCustomerResponse> updateAddressCustomer(
      int? idAddressCustomer,
      AddressCustomerRequest addressCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service!.updateAddressCustomer(
          StoreInfo().getCustomerStoreCode(),
          idAddressCustomer,
          addressCustomerRequest.toJson());
      return res;
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<DeleteAddressCustomerResponse?> deleteAddressCustomer(
      int? idAddressCustomer) async {
    try {
      var res = await CustomerServiceManager().service!.deleteAddressCustomer(
          StoreInfo().getCustomerStoreCode(), idAddressCustomer);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
