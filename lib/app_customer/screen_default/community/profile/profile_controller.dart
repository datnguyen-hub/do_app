import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../../model/community_customer_profile.dart';
import '../../../model/info_customer.dart';
import '../../data_app_controller.dart';

class PersonalCommunityPostController extends GetxController {
  int currentPage = 1;
  bool isEnd = false;
  var listPersonalCommunity = RxList<CommunityPost>();
  var listFriend = RxList<InfoCustomer>();
  var isLoading = true.obs;

  var communityCustomerProfile = CommunityCustomerProfile().obs;
  int customerId;

  DataAppCustomerController dataAppCustomerController = Get.find();

  PersonalCommunityPostController({required this.customerId}) {
    generalInformation();
    getPostCommunity(isRefresh: true);
    getAllFriend(isRefresh: true);
  }

  Future<void> addFriend(int toCustomerId) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .addFriend(toCustomerId: toCustomerId);
      generalInformation();
      SahaAlert.showSuccess(message: 'Đã gửi yêu cầu kết bạn');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteFriendRequest(int customerId) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .deleteFriendRequest(
        customerId: customerId,
      );
      generalInformation();
      SahaAlert.showSuccess(message: 'Đã huỷ yêu cầu kết bạn');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getCommunityPost(int communityPostId) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .getCommunityPost(communityPostId: communityPostId);

      var index =
          listPersonalCommunity.indexWhere((e) => e.id == data?.data?.id);

      if (index != -1) {
        listPersonalCommunity[index] = data!.data!;
        listPersonalCommunity.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void getPostCommunity({
    bool? isRefresh,
  }) {
    if (dataAppCustomerController.infoCustomer.value.id == customerId) {
      getPersonalCommunityPost(isRefresh: isRefresh);
    } else {
      getCustomerCommunityPost(isRefresh: isRefresh);
    }
  }

  void getAllFriend({
    bool? isRefresh,
  }) {
    if (dataAppCustomerController.infoCustomer.value.id == customerId) {
      getAllFriends(isRefresh: isRefresh);
    } else {
      getAllCustomerFriends(isRefresh: isRefresh);
    }
  }

  Future<void> getPersonalCommunityPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getPersonalCommunityPost(
          currentPage: currentPage,
        );

        if (isRefresh == true) {
          listPersonalCommunity(data!.data!.data!);
          listPersonalCommunity.refresh();
        } else {
          listPersonalCommunity.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }

  Future<void> getCustomerCommunityPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllCommunityCustomerPost(
          currentPage: currentPage,
          toCustomerId: customerId,
        );

        if (isRefresh == true) {
          listPersonalCommunity(data!.data!.data!);
          listPersonalCommunity.refresh();
        } else {
          listPersonalCommunity.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }

  Future<void> likePost(
      {required int communityPostId, required bool isLike}) async {
    try {
      var data =
          await CustomerRepositoryManager.customerCommunityRepository.sendLike(
        communityPostId: communityPostId,
        isLike: isLike,
      );

      var index =
          listPersonalCommunity.indexWhere((e) => e.id == data!.data!.id);
      if (index != -1) {
        listPersonalCommunity[index] = data!.data!;
        listPersonalCommunity.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteCommunityPost({required int communityPostId}) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .deleteCommnunityPost(communityPostId: communityPostId);
      listPersonalCommunity.removeWhere((e) => e.id == communityPostId);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllFriends({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllFriends(
          currentPage: currentPage,
          customerId: customerId,
        );

        if (isRefresh == true) {
          listFriend(data!.data!.data!);
          listFriend.refresh();
        } else {
          listFriend.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }

  Future<void> getAllCustomerFriends({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllCustomerFriend(
          currentPage: currentPage,
          customerId: customerId,
        );

        if (isRefresh == true) {
          listFriend(data!.data!.data!);
          listFriend.refresh();
        } else {
          listFriend.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }

  Future<void> generalInformation() async {
    try {
      var res = await CustomerRepositoryManager.customerCommunityRepository
          .generalInformation(
        idCustomer: customerId,
      );
      communityCustomerProfile.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> deleteFriend({required int toCustomerId}) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .deleteFriend(toCustomerId: toCustomerId);
      generalInformation();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
