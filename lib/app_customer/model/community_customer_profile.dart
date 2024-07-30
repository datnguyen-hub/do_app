import 'info_customer.dart';

class CommunityCustomerProfile {
  CommunityCustomerProfile({
    this.totalFriends,
    this.totalImages,
    this.sentFriendRequest,
    this.isFriend,
    this.customer,
  });

  int? totalFriends;
  int? totalImages;
  bool? sentFriendRequest;
  bool? isFriend;
  InfoCustomer? customer;

  factory CommunityCustomerProfile.fromJson(Map<String, dynamic> json) =>
      CommunityCustomerProfile(
        totalFriends:
            json["total_friends"] == null ? null : json["total_friends"],
        totalImages: json["total_images"] == null ? null : json["total_images"],
        sentFriendRequest: json["sent_friend_request"] == null
            ? null
            : json["sent_friend_request"],
        isFriend: json["is_friend"] == null ? null : json["is_friend"],
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
      );
}
