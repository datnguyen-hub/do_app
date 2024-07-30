import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/friend_request.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import '../../../../model/info_customer.dart';

class FriendsListController extends GetxController {
  int currentPage = 1;
  bool isEnd = false;
  var listFriend = RxList<InfoCustomer>();
  var listFriendRequest = RxList<FriendRequest>();
  var isLoading = false.obs;
  int customerId;
  String? textSearch;

  FriendsListController({required this.customerId}) {
    getAllFriends(isRefresh: true);
    getFriendRequest(isRefresh: true);
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
        isLoading.value = true;
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllFriends(
          currentPage: currentPage,
          customerId: customerId,
          search: textSearch,
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
  }

  Future<void> getFriendRequest({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllFriendRequest(
          currentPage: currentPage,
        );

        if (isRefresh == true) {
          listFriendRequest(data!.data!.data!);
          listFriendRequest.refresh();
        } else {
          listFriendRequest.addAll(data!.data!.data!);
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
  }

  Future<void> deleteFriend({required int toCustomerId}) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .deleteFriend(toCustomerId: toCustomerId);
      listFriendRequest.removeWhere((e) => e.toCustomerId == toCustomerId);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> handleFriendRequest(
      {required int requestId, required int status}) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .handleFriendRequest(requestId: requestId, status: status);
      getFriendRequest(isRefresh: true);
      getAllFriends(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
