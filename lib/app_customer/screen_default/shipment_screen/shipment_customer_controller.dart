import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/info_address_customer.dart';
import '../../model/shipment_method.dart';

class ShipmentCustomerController extends GetxController {
  InfoAddressCustomer? infoAddressCustomer = InfoAddressCustomer();
  ShipmentMethod? shipmentCurrentInput;
  var shipmentMethodChoose = ShipmentMethod().obs;
  int? branchId;
  ShipmentCustomerController(
      {this.infoAddressCustomer, this.shipmentCurrentInput,this.branchId}) {
    chargeShipmentFee(idAddressCustomer :infoAddressCustomer!.id,branchId: branchId);
    if (shipmentCurrentInput != null) {
      shipmentMethodChoose(shipmentCurrentInput);
    }
  }

  var listShipment = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;

  Future<void> chargeShipmentFee({int? idAddressCustomer,int? branchId}) async {
    isLoadingShipmentMethod.value = true;
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .chargeShipmentFee(idAddressCustomer : idAddressCustomer,branchId: branchId);
      listShipment(res!.data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingShipmentMethod.value = false;
  }
}
