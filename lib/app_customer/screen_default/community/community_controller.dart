import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../components/toast/saha_alert.dart';

class CommunityController extends GetxController {
  var listCommunityPost = RxList<CommunityPost>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = true.obs;

  CommunityController() {
    getAllCommunityPost(isRefresh: true);
  }

  Future<void> getCommunityPost(int communityPostId) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .getCommunityPost(communityPostId: communityPostId);

      var index = listCommunityPost.indexWhere((e) => e.id == data?.data?.id);

      if (index != -1) {
        listCommunityPost[index] = data!.data!;
        listCommunityPost.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllCommunityPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        var data = await CustomerRepositoryManager.customerCommunityRepository
            .getAllCommunityPost(
          numberPage: currentPage,
        );

        if (isRefresh == true) {
          listCommunityPost(data!.data!.data!);
          listCommunityPost.refresh();
        } else {
          listCommunityPost.addAll(data!.data!.data!);
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

      var index = listCommunityPost.indexWhere((e) => e.id == data!.data!.id);
      if (index != -1) {
        listCommunityPost[index] = data!.data!;
        listCommunityPost.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteCommunityPost({required int communityPostId}) async {
    try {
      var data = await CustomerRepositoryManager.customerCommunityRepository
          .deleteCommnunityPost(communityPostId: communityPostId);
      listCommunityPost.removeWhere((e) => e.id == communityPostId);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
