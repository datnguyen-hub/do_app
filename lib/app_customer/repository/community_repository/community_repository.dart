import 'package:sahashop_customer/app_customer/model/comment_community.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/all_community_customer_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/all_customer_friend_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/comment_community_post_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/community_customer_profile_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/friend_request_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/friends_list_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/post_an_articles_res.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/community/all_community_post_res.dart';
import '../../remote/response-request/community/comment_community_res.dart';
import '../../remote/response-request/community/community_post_like_res.dart';
import '../../remote/response-request/community/community_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../utils/store_info.dart';
import '../handle_error.dart';

class CustomerCommunityRepository {
  Future<AllCommunityPost?> getAllCommunityPost(
      {required int numberPage}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllCommunityPost(StoreInfo().getCustomerStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CommunityLikePostRes?> sendLike(
      {required int communityPostId, required bool isLike}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .sendLike(StoreInfo().getCustomerStoreCode(), {
        "community_post_id": communityPostId,
        "is_like": isLike,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteCommnunityPost(
      {required int communityPostId}) async {
    try {
      var res = await CustomerServiceManager().service!.deleteCommnunityPost(
          StoreInfo().getCustomerStoreCode(), communityPostId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PostArticlesRes?> addCommunityPost(
      {required CommunityPost communityPost}) async {
    try {
      var res = await CustomerServiceManager().service!.addCommunityPost(
          StoreInfo().getCustomerStoreCode(), communityPost.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<PostArticlesRes?> updateComunityPost(
      {required CommunityPost communityPost}) async {
    try {
      var res = await CustomerServiceManager().service!.updateComunityPost(
          StoreInfo().getCustomerStoreCode(),
          communityPost.id,
          communityPost.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllCommentCommunityRes?> getAllCommentCommunity(
      {required int currentPage, required int communityPostId}) async {
    try {
      var res = await CustomerServiceManager().service!.getAllCommentCommunity(
          StoreInfo().getCustomerStoreCode(), currentPage, communityPostId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CommentCommunityPost?> addCommentCommunityPost({
    required int communityPostId,
    required String content,
  }) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .addCommentCommunityPost(StoreInfo().getCustomerStoreCode(), {
        "community_post_id": communityPostId,
        "content": content,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CommentCommunityPost?> deleteCommentCommunityPost(
      {required int commentCommunityPostId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .deleteCommentCommunityPost(
              StoreInfo().getCustomerStoreCode(), commentCommunityPostId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CommentCommunityPost?> updateCommentCommunity(
      int? idComment, CommentPost commentPost) async {
    try {
      var res = await CustomerServiceManager().service!.updateCommentCommunity(
            StoreInfo().getCustomerStoreCode(),
            idComment,
            commentPost.toJson(),
          );
      return res;
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<AllCommunityPost?> getPersonalCommunityPost(
      {required int currentPage}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPersonalCommunityPost(
              StoreInfo().getCustomerStoreCode(), currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<FriendsListRes?> getAllFriends(
      {required int currentPage,
      required int customerId,
      String? search}) async {
    try {
      var res = await CustomerServiceManager().service!.getAllFriends(
          StoreInfo().getCustomerStoreCode(), currentPage, customerId, search);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CommunityCustomerProfileRes?> generalInformation(
      {int? idCustomer}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .generalInformation(StoreInfo().getCustomerStoreCode(), idCustomer);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<FriendRequestRes?> getAllFriendRequest(
      {required int currentPage}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllFriendRequest(StoreInfo().getCustomerStoreCode(), currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteFriend({required int toCustomerId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .deleteFriend(StoreInfo().getCustomerStoreCode(), toCustomerId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllCommunityCustomerRes?> getAllCommunityCustomerPost(
      {required int currentPage, required int toCustomerId}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllCommunityCustomerPost(
              StoreInfo().getCustomerStoreCode(), toCustomerId, currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllCustomerFriendRes?> getAllCustomerFriend({
    required int currentPage,
    required int customerId,
  }) async {
    try {
      var res = await CustomerServiceManager().service!.getAllCustomerFriend(
          StoreInfo().getCustomerStoreCode(), customerId, currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<CommunityPostRes?> getCommunityPost({
    required int communityPostId,
  }) async {
    try {
      var res = await CustomerServiceManager().service!.getCommunityPost(
          StoreInfo().getCustomerStoreCode(), communityPostId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> addFriend({
    required int toCustomerId,
  }) async {
    try {
      var res = await CustomerServiceManager().service!.addFriend(
          StoreInfo().getCustomerStoreCode(), {'to_customer_id': toCustomerId});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteFriendRequest({
    required int customerId,
  }) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .deleteFriendRequest(StoreInfo().getCustomerStoreCode(), customerId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SuccessResponse?> handleFriendRequest({
    required int requestId,
    required int status,
  }) async {
    try {
      var res = await CustomerServiceManager().service!.handleFriendRequest(
          StoreInfo().getCustomerStoreCode(), requestId, {"status": status});
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}
