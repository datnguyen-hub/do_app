import 'package:get/get.dart';
import '../../components/toast/saha_alert.dart';
import '../../model/bonus_product.dart';
import '../../model/product.dart';
import '../../repository/repository_customer.dart';

class BonusProductController extends GetxController {
  var listBonus = RxList<BonusProduct>();
  var isLoading = false.obs;

  Product? product;

  BonusProductController({this.product}) {
    getBonus();
  }

  Future<void> getBonus() async {
    isLoading.value = true;
    try {
      var data = await CustomerRepositoryManager.marketingRepository
          .getBonusCustomer(productId:product?.id);

      if (product != null) {
        data!.data!.forEach((e) {
          if (e.ladderReward == false) {
            var checkHasInCombo = e.selectProducts!
                .indexWhere((element) => element.product!.id == product?.id);
            if (checkHasInCombo != -1) {
              listBonus.add(e);
            }
          } else {
            var checkHasInCombo = e.bonusProductsLadder!
                .indexWhere((element) => element.product!.id == product?.id);
            if (checkHasInCombo != -1) {
              listBonus.add(e);
            }
          }
        });
      } else {
        listBonus(data!.data!);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
