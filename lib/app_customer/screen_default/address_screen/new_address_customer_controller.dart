import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import '../../remote/response-request/address_customer/address_customer_request.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/location_address.dart';

class NewAddressCustomerController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var isLoadingCreate = false.obs;
  var isDefault = false.obs;

  TextEditingController nameTextEditingController =
      TextEditingController(text: "");
  TextEditingController phoneTextEditingController =
      TextEditingController(text: "");
  TextEditingController emailTextEditingController =
      TextEditingController(text: "");
  TextEditingController addressDetailTextEditingController =
      TextEditingController(text: "");

  Future<void> createAddressCustomer() async {
    isLoadingCreate.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .createAddressCustomer(AddressCustomerRequest(
        name: nameTextEditingController.text,
        addressDetail: addressDetailTextEditingController.text,
        country: 1,
        province: locationProvince.value.id,
        district: locationDistrict.value.id,
        wards: locationWard.value.id,
        email: emailTextEditingController.text.removeAllWhitespace,
        phone: phoneTextEditingController.text.removeAllWhitespace,
        isDefault: isDefault.value,
      ));
      Get.back();
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}
