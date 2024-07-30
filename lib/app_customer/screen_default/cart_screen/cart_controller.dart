import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/cart_model.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/home/popup_res.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/login_screen.dart';
import 'package:sahashop_customer/app_customer/utils/appflyer.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/cart.dart';
import '../../model/combo.dart';
import '../../model/info_address_customer.dart';
import '../../model/order.dart';
import '../../model/shipment_method.dart';
import '../data_app_controller.dart';

class CartController extends GetxController {
  var listOrder = RxList<LineItem>();
  var voucherCodeChoose = "".obs;
  var listQuantityProduct = RxList<int>();
  var listCombo = RxList<Combo>();
  var listUsedCombo = RxList<UsedCombo>();
  var enoughCondition = RxList<bool>([]);
  var enoughConditionCB = RxList<bool>([]);
  var cartData = CartModel().obs;
  var balanceCollaboratorCanUse = 0.0.obs;
  var balanceCollaboratorUsed = 0.0.obs;
  var balanceAgencyCanUse = 0.0.obs;
  var balanceAgencyUsed = 0.0.obs;
  var isUseBalanceCollaborator = false.obs;
  var isUseBalanceAgency = false.obs;
  var isLoadingRefresh = false.obs;

  CartController() {
    shipmentMethodCurrent.value.fee = 0;
  }

  void increaseItem(index, List<DistributesSelected>? listDistributes) {
    listQuantityProduct[index] = listQuantityProduct[index] + 1;
    updateItemCart(
        listOrder[index].id,
        listOrder[index].product!.id!,
        listQuantityProduct[index],
        listDistributes ?? [],
        listOrder[index].note);
  }

  void decreaseItem(index, List<DistributesSelected>? listDistributes) {
    if (listQuantityProduct[index] > 1) {
      listQuantityProduct[index] = listQuantityProduct[index] - 1;
      updateItemCart(
          listOrder[index].id,
          listOrder[index].product!.id!,
          listQuantityProduct[index],
          listDistributes ?? [],
          listOrder[index].note);
    } else {
      return;
    }
  }

  Future<void> refresh() async {
    isLoadingRefresh.value = true;
    listCombo([]);
    listUsedCombo([]);
    listOrder([]);
    listQuantityProduct([]);
    // getComboCustomer();
    getItemCart();
  }

  Future<void> getComboCustomer() async {
    List<Combo> listComboNew = [];
    List<bool> enoughConditionNew = [];
    List<bool> enoughConditionCBNew = [];
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res!.data!.forEach((e) {
        bool checkInCombo = false;
        for (int i = 0; i < listOrder.length; i++) {
          int checkHasInCombo = e.productsCombo!.indexWhere(
              (element) => element.product!.id == listOrder[i].product!.id);
          if (checkHasInCombo != -1) {
            checkInCombo = true;
            break;
          } else {}
        }
        if (checkInCombo == true) {
          listComboNew.add(e);
          enoughConditionNew.add(false);
          enoughConditionCBNew.add(false);
        }
      });
      enoughCondition(enoughConditionNew);
      enoughConditionCB(enoughConditionCBNew);
      listCombo(listComboNew);

      for (int i = 0; i < listCombo.length; i++) {
        var checkEnough = listUsedCombo
            .indexWhere((element) => element.combo!.id == listCombo[i].id);
        if (checkEnough != -1) {
          enoughCondition[i] = true;
          for (int j = 0; j < listOrder.length; j++) {
            var index = listUsedCombo[checkEnough]
                .combo!
                .productsCombo!
                .indexWhere((el) => el.product!.id == listOrder[j].product!.id);
            if (index != -1) {
              if (listUsedCombo[checkEnough]
                      .combo!
                      .productsCombo![index]
                      .quantity! <=
                  listOrder[j].quantity!) {
                enoughConditionCB[i] = true;
              } else {
                enoughConditionCB[i] = false;
                break;
              }
            }
          }
        } else {
          enoughCondition[i] = false;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    enoughCondition.refresh();
    enoughConditionCB.refresh();
    cartData.refresh();
  }

  Rx<InfoAddressCustomer?> infoAddressCustomer = InfoAddressCustomer().obs;
  var isLoadingAddress = false.obs;

  Future<void> getAllAddressCustomer() async {
    isLoadingAddress.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .getAllAddressCustomer();
      infoAddressCustomer.value =
          res!.data!.isEmpty ? InfoAddressCustomer() : res.data![0];
      res.data!.forEach((element) {
        if (element.isDefault!) {
          infoAddressCustomer.value = element;
        }
      });
      await chargeShipmentFee(idAddressCustomer :infoAddressCustomer.value!.id);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  var shipmentMethodCurrent = ShipmentMethod().obs;
  var listShipmentFast = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;

  Future<void> chargeShipmentFee({int? idAddressCustomer,int? branchId}) async {
    isLoadingShipmentMethod.value = true;
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .chargeShipmentFee(idAddressCustomer : idAddressCustomer,branchId: branchId);
      shipmentMethodCurrent.value = res!.data!.data!.isEmpty
          ? ShipmentMethod(fee: 0)
          : res.data!.data![0];
      addVoucherCart('', (v) {});
    } catch (err) {
      //infoAddressCustomer.value = InfoAddressCustomer(id: 0);
      // SahaAlert.showError(message: "Chưa chọn địa chỉ");
    }
    isLoadingShipmentMethod.value = false;
  }

  Future<void> getItemCart() async {
    if (Get.find<DataAppCustomerController>().isLogin.value == false) {
      return;
    }
    List<int> listQuantityProductNew = [];
    listOrder([]);
    try {
      var res = await CustomerRepositoryManager.cartRepository.getItemCart(
        voucherCodeChoose.value,
        cartData.value.isUsePoints!,
        isUseBalanceCollaborator.value,
        shipmentMethodCurrent.value.fee,
      );

      sortLineItem(res!);

      listUsedCombo(res.data!.usedCombos!);
      listOrder.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });

      cartData.value = res.data!;
      balanceCollaboratorCanUse.value =
          res.data!.balanceCollaboratorCanUse ?? 0;
      balanceAgencyCanUse.value = res.data!.balanceAgencyCanUse ?? 0;
      balanceCollaboratorUsed.value = res.data!.balanceCollaboratorUsed ?? 0;
      balanceAgencyUsed.value = res.data!.balanceAgencyUsed ?? 0;
      listQuantityProduct(listQuantityProductNew);
      getComboCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingRefresh.value = false;
  }

  Future<void> addVoucherCart(String codeVoucher, Function callbackErr) async {
    List<int> listQuantityProductNew = [];
    cartData.value.voucherDiscountAmount = 0.0;
    try {
      var res = await CustomerRepositoryManager.cartRepository.addVoucherCart(
          codeVoucher: codeVoucher,
          isUsePoints: cartData.value.isUsePoints!,
          isUseBalanceCollaborator: isUseBalanceCollaborator.value,
          isUseBalanceAgency: isUseBalanceAgency.value,
          totalShippingFee: shipmentMethodCurrent.value.fee,
          isOrderForCustomer: cartData.value.isOrderForCustomer ?? false);
      sortLineItem(res!);
      listUsedCombo(res.data!.usedCombos!);
      listOrder.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew);
      cartData.value = res.data!;
      balanceCollaboratorCanUse.value =
          res.data!.balanceCollaboratorCanUse ?? 0;
      balanceAgencyCanUse.value = res.data!.balanceAgencyCanUse ?? 0;
      balanceCollaboratorUsed.value = res.data!.balanceCollaboratorUsed ?? 0;
      balanceAgencyUsed.value = res.data!.balanceAgencyUsed ?? 0;
      print("=======================${cartData.value.isUsePoints}");
     getComboCustomer();
      callbackErr('success');
    } catch (err) {
      print(err);
      callbackErr(err.toString());
      // SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateItemCart(int? lineItemId, int productId, int quantity,
      List<DistributesSelected> listDistributes, String? note) async {
    print("ssss");
    List<int> listQuantityProductNew = [];
    try {
      var res = await CustomerRepositoryManager.cartRepository.updateItemCart(
          lineItemId,
          productId,
          quantity,
          listDistributes,
          voucherCodeChoose.value,
          note);
      sortLineItem(res!);
      listUsedCombo(res.data!.usedCombos!);
      listOrder.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew);
      cartData.value = res.data!;
      getComboCustomer();
    } catch (err) {
      voucherCodeChoose.value = "";
      refresh();
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addItemCart(int? idProduct, int quantity,
      List<DistributesSelected> listDistributes) async {
    DataAppCustomerController dataAppCustomerController = Get.find();
    print(dataAppCustomerController.isLogin.value);
    if (dataAppCustomerController.isLogin.value == true) {
      List<int> listQuantityProductNew = [];
      try {
        var res = await CustomerRepositoryManager.cartRepository
            .addItemCart(idProduct, quantity, listDistributes);
        sortLineItem(res!);
        listUsedCombo(res.data!.usedCombos!);
        listOrder.forEach((element) {
          listQuantityProductNew.add(element.quantity!);
        });
        listQuantityProduct(listQuantityProductNew);
        cartData.value = res.data!;
        getComboCustomer();
        if(AppFlyer().isUseAppFlyer == true){
          print("Thêm vào giỏ hàng");
          AppFlyer().logEvent("Thêm vào giỏ hàng", {});
        }
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    } else {
      Get.to(() => LoginScreenCustomer())!
          .then((value) => {dataAppCustomerController.getBadge()});
    }
  }

  void sortLineItem(Cart? res) {
    listOrder([]);
    List<LineItem> listBonus =
        (res!.data!.lineItems ?? []).where((e) => e.isBonus == true).toList();

    listBonus.sort((a, b) => (b.parentCartItemIds ?? '')
        .length
        .compareTo((a.parentCartItemIds ?? '').length));

    if (listBonus.isNotEmpty) {
      for (int i = 0; i < listBonus.length; i++) {
        var listId = (listBonus[i].parentCartItemIds ?? '').split(";");
        listId.removeWhere((e) => e == '');
        print('sản phẩm thưởng ========= ${listBonus[i].id}');
        print("danh sách cha ========== $listId");
        var indexInsert = 0;

        for (var id in listId) {
          // print('check = $id');
          //
          // print(listOrder.map((e) => e.id.toString()).contains(id));

          indexInsert = listOrder
              .map((e) => e.id.toString())
              .toList()
              .indexWhere((e) => e == id);

          print(indexInsert);

          if (indexInsert == -1) {
            listOrder.add(
                res.data!.lineItems!.where((e) => e.id.toString() == id).first);
            print('thêm vào show: $id');
          }

          // if (listOrder.map((e) => e.id.toString()).contains(id) == false) {
          //   listOrder.add(
          //       res.data!.lineItems!.where((e) => e.id.toString() == id).first);
          //   print('thêm vào show: $id');
          // } else {
          //
          // }
        }
        if (indexInsert != -1) {
          print('======== $indexInsert');
          for (int ins = indexInsert + 1; ins < listOrder.length; ins++) {
            if (listOrder[ins].isBonus == true) {
              print('gặp isbonus ở vị trí : $ins');
              listOrder.insert(ins, listBonus[i]);
              break;
            }
          }
        } else {
          listOrder.add(listBonus[i]);
        }

        print('danh sách show: ${listOrder.map((e) => e.id)}');
      }

      for (int i = 0; i < res.data!.lineItems!.length; i++) {
        if (!listOrder.map((e) => e.id).contains(res.data!.lineItems![i].id)) {
          listOrder.add(res.data!.lineItems![i]);
        }
      }
    } else {
      listOrder(res.data!.lineItems!);
    }
  }
}
