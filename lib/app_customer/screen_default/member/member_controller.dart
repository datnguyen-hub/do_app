import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/reward_point_ctm.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import '../../components//toast/saha_alert.dart';
import '../../model/score_history_item.dart';

import '../data_app_controller.dart';

class MemberController extends GetxController {
  var listScoreHistory = RxList<ScoreHistoryItem>();
  var isScoreHistory = false.obs;
  var memberType = "Bạc".obs;
  var memberTypeNext = "Vàng".obs;
  var scoreTarget = 2000000.0.obs;
  var rewardPointCtm = RewardPointCtm().obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  MemberController() {
    getHistoryScore();
    getRewardPointCtm();
    checkMemberType();
  }

  void seeScoreHistory() {
    isScoreHistory.value = !isScoreHistory.value;
  }

  void checkMemberType() {
    if (dataAppCustomerController.badge.value.totalBoughtAmount! >= 2000000 &&
        dataAppCustomerController.badge.value.totalBoughtAmount! < 4000000) {
      memberType.value = "Vàng";
      memberTypeNext.value = "Bạch kim";
      scoreTarget.value = 4000000;
    } else if (dataAppCustomerController.badge.value.totalBoughtAmount! >=
            4000000 &&
        dataAppCustomerController.badge.value.totalBoughtAmount! < 8000000) {
      memberType.value = "Bạch kim";
      memberTypeNext.value = "Kim cương";
      scoreTarget.value = 8000000;
    } else if (dataAppCustomerController.badge.value.totalBoughtAmount! >=
        8000000) {
      memberType.value = "Kim cương";
      memberTypeNext.value = "Hạng cao nhất";
      scoreTarget.value = 999999999;
    }
  }

  Future<void> getHistoryScore() async {
    try {
      var data =
          await CustomerRepositoryManager.scoreRepository.getScoreHistory(page: 1);
      listScoreHistory(data!.data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


  Future<void> getRewardPointCtm() async {
    try {
      var data =
      await CustomerRepositoryManager.pointRepository.getRewardPointCtm();
      rewardPointCtm.value = data!.rewardPoint!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
