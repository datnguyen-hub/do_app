import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_customer/app_customer/model/cart.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/agency_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/agency/info_payment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/chat/all_message_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/chat/all_person_chat_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/all_community_customer_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/all_customer_friend_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/comment_community_post_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/comment_community_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/community_customer_profile_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/friend_request_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/friends_list_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/community/post_an_articles_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/ctv_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/ctv/info_payment_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/home/home_button_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/home/web_theme_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/marketing_chanel/all_product_voucher_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/all_history_gift_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/all_history_guess_number_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/get_turn_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/gift_winning_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/guess_number_game_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/join_guess_number_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/join_mini_game_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/mini_game_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/mini_game/play_guess_game_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/orders/all_branches_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/shipment/all_shipping_company_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/shipment/type_ship_res.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../app_customer/const/env.dart';
import '../remote/response-request/address_customer/all_address_customer_response.dart';
import '../remote/response-request/address_customer/create_update_address_customer_response.dart';
import '../remote/response-request/address_customer/delete_address_customer_response.dart';
import '../remote/response-request/category/all_category_response.dart';
import '../remote/response-request/config_ui/app_theme_response.dart';
import '../remote/response-request/favorite/all_product_response.dart';
import '../remote/response-request/favorite/favorite_response.dart';
import '../remote/response-request/home/home_response.dart';
import '../remote/response-request/info_customer/info_customer_response.dart';
import '../remote/response-request/login/login_response.dart';
import '../remote/response-request/marketing_chanel/combo_customer_response.dart';
import '../remote/response-request/marketing_chanel/voucher_customer_response.dart';
import '../remote/response-request/orders/cancel_order_response.dart';
import '../remote/response-request/orders/order_history_response.dart';
import '../remote/response-request/orders/order_response.dart';
import '../remote/response-request/orders/state_history_order_customer_response.dart';
import '../remote/response-request/payment_customer/payment_method_response.dart';
import '../remote/response-request/product/all_product_response.dart';
import '../remote/response-request/product/detail_product_response.dart';
import '../remote/response-request/product/query_product_response.dart';
import '../remote/response-request/register/register_response.dart';
import '../remote/response-request/review/review_of_product_response.dart';
import '../remote/response-request/review/review_response.dart';
import '../remote/response-request/shipment/shipment_response.dart';
import '../remote/response-request/store/all_store_response.dart';
import '../remote/response-request/store/type_store_respones.dart';
import 'response-request/address/address_respone.dart';
import 'response-request/agency/all_referral_agency_res.dart';
import 'response-request/agency/general_info_payment_response.dart';
import 'response-request/agency/payment_agency_history_response.dart';
import 'response-request/agency/report_rose_response.dart';
import 'response-request/attribute_search/list_attribute_search_res.dart';
import 'response-request/badge/badge_response.dart';
import 'response-request/chat/all_mesage_person_chat_res.dart';
import 'response-request/chat/message_person_chat_res.dart';
import 'response-request/chat/send_message_customer_response.dart';
import 'response-request/community/all_community_post_res.dart';
import 'response-request/community/community_post_like_res.dart';
import 'response-request/community/community_res.dart';
import 'response-request/ctv/general_info_payment_response.dart';
import 'response-request/ctv/payment_ctv_history_response.dart';
import 'response-request/ctv/report_rose_response.dart';
import 'response-request/device_token/device_token_customer_response.dart';
import 'response-request/education/all_history_submit_res.dart';
import 'response-request/education/all_quiz_res.dart';
import 'response-request/education/course_list_res.dart';
import 'response-request/education/history_submit_res.dart';
import 'response-request/education/list_chapter_and_lesson.dart';
import 'response-request/education/list_lesson_res.dart';
import 'response-request/education/quiz_res.dart';
import 'response-request/home/banner_ads_app_res.dart';
import 'response-request/home/banner_res.dart';
import 'response-request/home/layout_res.dart';
import 'response-request/home/popup_res.dart';
import 'response-request/home/post_new_res.dart';
import 'response-request/home/product_by_category_res.dart';
import 'response-request/home/product_discount_res.dart';
import 'response-request/image/upload_image_response.dart';
import 'response-request/login/exists_response.dart';
import 'response-request/marketing_chanel/bonus_customer_response.dart';
import 'response-request/notification_history/all_notification_response.dart';
import 'response-request/point/reward_pionts_ctm_response.dart';
import 'response-request/post/all_category_post_response.dart';
import 'response-request/post/all_post_response.dart';
import 'response-request/post/post_response.dart';
import 'response-request/product/product_scan_response.dart';
import 'response-request/product/product_watched_response.dart';
import 'response-request/report/report_response.dart';
import 'response-request/score/check_in_response.dart';
import 'response-request/score/history_score_response.dart';
import 'response-request/score/roll_call_response.dart';
import 'response-request/search_history/add_history_search_response.dart';
import 'response-request/search_history/all_search_history_response.dart';
import 'response-request/search_history/search_history_response.dart';
import 'response-request/success/success_response.dart';

part 'customer_service.g.dart';

@RestApi(baseUrl: "$DOMAIN_API_CUSTOMER")
abstract class CustomerService {
  /// Retrofit factory
  factory CustomerService(Dio dio, {String? baseUrl}) => _CustomerService(dio,
      baseUrl: StoreInfo().getIsRelease() == null
          ? "https://main.doapp.vn/api/"
          : "https://dev.doapp.vn/api/");

  @GET("customer/store")
  Future<AllStoreResponse> getAllStore();

  /// Product

  @GET("customer/store/{storeCode}/products")
  Future<AllProductResponse> getAllProduct(@Path("storeCode") String storeCode);

  @GET("customer/{storeCode}/products/{idProduct}/similar_products")
  Future<AllProductResponse> getSimilarProduct(
      @Path("storeCode") String storeCode, @Path("idProduct") int idProduct);

  @GET("customer/{storeCode}/watched_products")
  Future<ProductWatchedResponse> getWatchedProduct(
    @Path("storeCode") String storeCode,
  );

  @GET("customer/type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @GET("customer/{storeCode}/app-theme")
  Future<GetAppThemeResponse> getAppTheme(@Path("storeCode") String? storeCode);

  @GET("customer/{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(
      @Path("storeCode") String? storeCode);

  @GET("customer/{storeCode}/products")
  Future<QueryProductResponse> getProductWithCategory(
      @Path("storeCode") String storeCode, int idCategory);

  @GET("customer/{storeCode}/products?=")
  Future<QueryProductResponse> searchProduct(
      @Path("storeCode") String? storeCode,
      @Query("page") int page,
      @Query("search") String? search,
      @Query("category_ids") String? idCategory,
      @Query("category_children_ids") String? idCategoryChild,
      @Query("attribute_search_children_ids") String? listAttributeSearch,
      @Query("descending") bool? descending,
      @Query("details") String? details,
      @Query("has_discount") bool? hasDiscount,
      @Query("sort_by") String? sortBy);

  @GET("customer/{storeCode}/products/{idProduct}")
  Future<DetailProductResponse> getDetailProduct(
    @Path("storeCode") String? storeCode,
    @Path() int? idProduct,
  );

  @GET("customer/{storeCode}/attribute_searches")
  Future<ListAttributeSearchRes> getAttributeSearch(
    @Path("storeCode") String? storeCode,
  );

  @POST("customer/{storeCode}/scan_product")
  Future<ProductScanCusResponse> scanProduct(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("customer/{storeCode}/posts/{idPost}")
  Future<PostResponse> getDetailPost(
    @Path("storeCode") String? storeCode,
    @Path() int? idPost,
  );

  @GET("customer/{storeCode}/post_categories")
  Future<AllCategoryPostResponse> getAllCategoryPost(
      @Path("storeCode") String? storeCode);

  @GET("customer/{storeCode}/posts?=")
  Future<AllPostResponse> searchPost(
      @Path("storeCode") String? storeCode,
      @Query("search") String search,
      @Query("category_ids") String idCategory,
      @Query("descending") bool descending,
      @Query("sort_by") String sortBy);

  @GET("customer/{storeCode}/home_app")
  Future<HomeResponse> getHomeApp(
    @Path("storeCode") String? storeCode,
    @Query("from") String from,
  );

  @GET("customer/{storeCode}/home_web/banners")
  Future<BannerRes> getBanner(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/web-theme")
  Future<WebThemeRes> getWebTheme(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_web/ads")
  Future<PopupRes> getPopup(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_app/ads")
  Future<BannerAdsAppRes> getBannerAdsApp(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_web/product_discounts")
  Future<ProductHomeRes> getProductDiscount(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_web/product_top_sales")
  Future<ProductHomeRes> getProductTopSale(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_web/product_news")
  Future<ProductHomeRes> getProductNews(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_web/product_by_category")
  Future<ProductByCategoryRes> getProductByCategory(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_web/posts_new")
  Future<PostNewRes> getPostNew(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_app/layouts")
  Future<LayoutRes> getLayout(
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/home_app/buttons")
  Future<HomeButtonRes> getHomeButton(
    @Path("storeCode") String? storeCode,
  );

  @POST("customer/{storeCode}/carts/orders")
  Future<OrderResponse> createOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/register")
  Future<RegisterResponse> registerAccount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("customer/{storeCode}/profile")
  Future<InfoCustomerResponse> updateAccount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("customer/{storeCode}/profile/referral_phone_number")
  Future<InfoCustomerResponse> updateReferralPhoneNumber(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/login")
  Future<LoginResponse> loginAccount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/login/check_exists")
  Future<ExistsLoginResponse> checkExists(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/reset_password")
  Future<SuccessResponse> resetPassword(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/change_password")
  Future<SuccessResponse> changePassword(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/profile")
  Future<InfoCustomerResponse> getInfoCustomer(
      @Path("storeCode") String? storeCode);

  /// marketing chanel

  @GET("customer/{storeCode}/bonus_products")
  Future<AllBonusCustomerRes> getBonusCustomer(
    @Path("storeCode") String? storeCode,
    @Query("product_id") int? productId,
  );

  @GET("customer/{storeCode}/combos")
  Future<CustomerComboResponse> getComboCustomer(
      @Path("storeCode") String? storeCode);

  @GET("customer/{storeCode}/vouchers")
  Future<VoucherCustomerResponse> getVoucherCustomer(
      @Path("storeCode") String? storeCode);

  @GET("customer/{storeCode}/vouchers/{voucherId}/products")
  Future<AllProductVoucherRes> getAllProductVoucher(
    @Path("storeCode") String? storeCode,
    @Path("voucherId") int voucherId,
    @Query("page") int numberPage,
  );

  /// chat customer

  @GET("customer/{storeCode}/person_chat")
  Future<AllPersonChatRes> getAllPersonChat(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int numberPage,
  );

  @GET("customer/{storeCode}/person_chat/{customerId}/messages")
  Future<AllMesagePersonChatRes> getMesagePersonChat(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int? customerId,
    @Query("page") int numberPage,
  );

  @POST("customer/{storeCode}/person_chat/{customerId}/messages")
  Future<MessagePersonChatRes> sendMessagePersonChat(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int? customerId,
    @Body() Map<String, dynamic> body,
  );

  @GET("customer/{storeCode}/messages")
  Future<AllMessageCustomerResponse> getAllMessageCustomer(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
  );

  @POST("customer/{storeCode}/messages")
  Future<SendMessageCustomerResponse> sendMessageToUser(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// cart

  @POST("customer/{storeCode}/carts")
  Future<Cart> getItemCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/carts")
  Future<Cart> addVoucherCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("customer/{storeCode}/carts/items")
  Future<Cart> updateItemCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/carts/items")
  Future<Cart> addItemCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  ///search history
  @POST("customer/{storeCode}/search_histories")
  Future<AddSearchHistoryResponse> addHistorySearch(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/search_histories")
  Future<AllHistoryResponse> getAllHistorySearch(
      @Path("storeCode") String? storeCode,
      @Query("device_id") String? deviceId);

  @DELETE("customer/{storeCode}/search_histories")
  Future<DeleteAllSearchHistoryResponse> deleteAllHistorySearch(
      @Path("storeCode") String? storeCode,
      @Query("device_id") String? deviceId);

  /// address customer

  @GET("customer/{storeCode}/address")
  Future<AllIAddressCustomerResponse> getAllAddressCustomer(
      @Path("storeCode") String? storeCode);

  @POST("customer/{storeCode}/address")
  Future<CreateUpdateAddressCustomerResponse> createAddressCustomer(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("customer/{storeCode}/address/{idAddressCustomer}")
  Future<CreateUpdateAddressCustomerResponse> updateAddressCustomer(
      @Path("storeCode") String? storeCode,
      @Path() int? idAddressCustomer,
      @Body() Map<String, dynamic> body);

  @DELETE("customer/{storeCode}/address/{idAddressCustomer}")
  Future<DeleteAddressCustomerResponse> deleteAddressCustomer(
      @Path("storeCode") String? storeCode, @Path() int? idAddressCustomer);

  /// shipment

  @POST("customer/{storeCode}/carts/calculate_fee")
  Future<ShipmentCustomerResponse> chargeShipmentFee(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  
  @POST("customer/{storeCode}/shipment/list_shipper")
  Future<AllShippingCompanyRes> getAllShippingCompany(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  
  @POST("customer/{storeCode}/carts/calculate_fee/{idCompany}")
  Future<TypeShipRes> getTypeShip(
      @Path("storeCode") String? storeCode,@Path("idCompany") int idCompany, @Body() Map<String, dynamic> body);

  /// payment
  @GET("customer/{storeCode}/payment_methods")
  Future<PaymentMethodCustomerResponse> getPaymentMethod(
      @Path("storeCode") String? storeCode);

  /// order history

  @GET("customer/{storeCode}/carts/orders")
  Future<OrderHistoryResponse> getOrderHistory(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? filterByValue,
    @Query("sort_by") String? sortBy,
    @Query("descending") String? descending,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @GET("customer/{storeCode}/carts/orders/{orderCode}")
  Future<OrderResponse> getOneOrderHistory(
      @Path("storeCode") String? storeCode, @Path() String? orderCode);

  @GET("customer/{storeCode}/carts/orders/status_records/{idOrder}")
  Future<StateHistoryOrderCustomerResponse> getStateHistoryCustomerOrder(
    @Path("storeCode") String? storeCode,
    @Path() int? idOrder,
  );

  @POST("customer/{storeCode}/carts/orders/cancel")
  Future<CancelOrderResponse> cancelOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("customer/{storeCode}/carts/orders/change_payment_method/{orderCode}")
  Future<CancelOrderResponse> changePaymentMethod(
      @Path("storeCode") String? storeCode,
      @Body() Map<String, dynamic> body,
      @Path() String? orderCode);

  @GET("customer/{storeCode}/favorites")
  Future<AllProductFavorites> getAllFavorite(
      @Path("storeCode") String storeCode, @Path("page") int page);

  @GET("customer/{storeCode}/purchased_products")
  Future<AllProductFavorites> getPurchasedProducts(
      @Path("storeCode") String storeCode, @Path("page") int page);

  @POST("customer/{storeCode}/products/{productId}/favorites")
  Future<FavoriteResponse> favoriteProduct(@Path("storeCode") String storeCode,
      @Path("productId") int productId, @Body() Map<String, dynamic> body);

  /// review
  @POST("customer/{storeCode}/products/{idProduct}/reviews")
  Future<ReviewResponse> review(@Path("storeCode") String? storeCode,
      @Path() int? idProduct, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/products/{idProduct}/reviews")
  Future<ReviewOfProResponse> getReviewProduct(
    @Path("storeCode") String? storeCode,
    @Path() int? idProduct,
    @Query("filter_by") String? filterBy,
    @Query("filter_by_value") String? filterByValue,
    @Query("has_image") bool? hasImage,
  );

  /// report_ctv_agency
  @GET("customer/{storeCode}/agency/get_all_referral_agency")
  Future<AllReferralAgencyRes> getAllReferralAgency(
    @Path() String storeCode,
    @Query("page") int page,
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("customer/{storeCode}/collaborator/get_all_referral_ctv")
  Future<AllReferralAgencyRes> getAllCollaborator(
    @Path() String storeCode,
    @Query("page") int page,
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("customer/{storeCode}/collaborator/report")
  Future<ReportResponse> getReport(
    @Path() String storeCode,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
    @Query("date_from_compare") String dateFromCompare,
    @Query("date_to_compare") String dateToCompare,
  );

  @GET("customer/{storeCode}/agency/report")
  Future<ReportResponse> getReportAgency(
    @Path() String storeCode,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
    @Query("date_from_compare") String dateFromCompare,
    @Query("date_to_compare") String dateToCompare,
  );

  @GET("customer/{storeCode}/agency_ctv/report")
  Future<ReportResponse> getReportAgencyCvt(
    @Path() String storeCode,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
    @Query("date_from_compare") String dateFromCompare,
    @Query("date_to_compare") String dateToCompare,
  );

  /// Badge
  @GET("customer/{storeCode}/badges")
  Future<BadgeResponse> getBadge(
    @Path("storeCode") String? storeCode,
  );

  ///Point

  @GET("customer/{storeCode}/roll_calls")
  Future<RollCallsResponse> getRollCall(
    @Path("storeCode") String? storeCode,
  );

  @POST("customer/{storeCode}/roll_calls/checkin")
  Future<CheckInResponse> checkIn(@Path("storeCode") String? storeCode);

  @GET("customer/{storeCode}/point_history")
  Future<HistoryScoreResponse> getScoreHistory(
    @Query("page") int page,
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/profile/get_all_referral")
  Future<AllCustomerFriendRes> getAllReferral(
    @Query("page") int page,
    @Path("storeCode") String? storeCode,
  );

  @GET("customer/{storeCode}/reward_points")
  Future<RewardPointsCtmResponse> getRewardPointCtm(
    @Path("storeCode") String? storeCode,
  );

  ///Address
  @GET("place/vn/province")
  Future<AddressResponse> getProvince();

  @GET("place/vn/district/{idProvince}")
  Future<AddressResponse> getDistrict(@Path() int? idProvince);

  @GET("place/vn/wards/{idDistrict}")
  Future<AddressResponse> getWard(@Path() int? idDistrict);

  //image
  @POST("customer/{storeCode}/images")
  Future<UploadImageResponse> uploadImage(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/video")
  Future<UploadImageResponse> uploadVideo(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  //
  @POST("customer/{storeCode}/device_token_customer")
  Future<UpdateDeviceTokenResponse> updateDeviceTokenCustomer(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  /// Agency customer

  @POST("customer/{storeCode}/agency/reg")
  Future<SuccessResponse> registerAgency(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/agency/account")
  Future<InfoPaymentAgencyResponse> updateInfoAgency(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/agency/account")
  Future<InfoPaymentAgencyResponse> getInfoAgency(
      @Path("storeCode") String? storeCode);

  /// Agency order history CTV

  @GET("customer/{storeCode}/agency/orders")
  Future<OrderHistoryResponse> getOrderAgencyHistory(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? filterByValue,
    @Query("sort_by") String? sortBy,
    @Query("descending") String? descending,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @GET("customer/{storeCode}/agency_ctv/orders")
  Future<OrderHistoryResponse> getOrderAgencyCtvHistory(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? filterByValue,
    @Query("sort_by") String? sortBy,
    @Query("descending") String? descending,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  /// payment history agency_config

  @GET("customer/{storeCode}/agency/history_balace")
  Future<PaymentAgencyHistoryResponse> getPaymentAgencyHistory(
    @Path("storeCode") String? storeCode,
  );

  /// report_ctv_agency rose agency_config

  @GET("customer/{storeCode}/agency/bonus")
  Future<ReportRoseAgencyResponse> getReportAgencyRose(
    @Path("storeCode") String? storeCode,
    @Query("page") int? page,
  );

  @POST("customer/{storeCode}/agency/bonus/take")
  Future<SuccessResponse> receiveMoneyAgency(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/agency/info")
  Future<GeneralInfoPaymentAgencyResponse> getGeneralInfoPaymentAgency(
    @Path("storeCode") String? storeCode,
  );

  @POST("customer/{storeCode}/agency/request_payment")
  Future<SuccessResponse> requestPaymentAgency(
      @Path("storeCode") String? storeCode);

  @POST("customer/{storeCode}/agency/account")
  Future<AgencyRes> updateAgencyInfo(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  @GET("customer/{storeCode}/agency/account")
  Future<AgencyRes> getAgencyInfo(@Path("storeCode") String? storeCode);

  //////////////////////////////////////////////////////

  /// CTV customer

  @POST("customer/{storeCode}/collaborator/reg")
  Future<SuccessResponse> registerCTV(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/collaborator/account")
  Future<InfoPaymentResponse> updateInfoCTV(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/collaborator/account")
  Future<InfoPaymentResponse> getInfoCTV(@Path("storeCode") String? storeCode);

  @POST("customer/{storeCode}/collaborator/account")
  Future<CtvRes> updateCollaboratorInfo(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  @GET("customer/{storeCode}/collaborator/account")
  Future<CtvRes> getCollaboratorInfo(@Path("storeCode") String? storeCode);

  /// order history CTV

  @GET("customer/{storeCode}/collaborator/orders")
  Future<OrderHistoryResponse> getOrderCTVHistory(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? filterByValue,
    @Query("sort_by") String? sortBy,
    @Query("descending") String? descending,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  /// payment history ctv_config
  @GET("customer/{storeCode}/collaborator/history_balace")
  Future<PaymentCtvHistoryResponse> getPaymentCtvHistory(
    @Path("storeCode") String? storeCode,
  );

  /// report_ctv_agency rose ctv_config

  @GET("customer/{storeCode}/collaborator/bonus")
  Future<ReportRoseResponse> getReportRose(
    @Path("storeCode") String? storeCode,
    @Query("page") int? page,
  );

  @POST("customer/{storeCode}/collaborator/bonus/take")
  Future<SuccessResponse> receiveMoneyCtv(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("customer/{storeCode}/collaborator/info")
  Future<GeneralInfoPaymentResponse> getGeneralInfoPaymentCtv(
    @Path("storeCode") String? storeCode,
  );

  @POST("customer/{storeCode}/collaborator/request_payment")
  Future<SuccessResponse> requestPayment(@Path("storeCode") String? storeCode);

  /// Send otp

  @POST("send_otp")
  Future<SuccessResponse> sendOtp(@Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/send_email_otp")
  Future<SuccessResponse> sendEmailOtpCus(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("send_email_otp")
  Future<SuccessResponse> sendOtpEmail(@Body() Map<String, dynamic> body);

  /// Notification history

  @GET("customer/{storeCode}/notifications_history")
  Future<AllNotificationCusResponse> historyNotification(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
  );

  @GET("customer/{storeCode}/notifications_history/read_all")
  Future<SuccessResponse> readAllNotification(
    @Path("storeCode") String? storeCode,
  );

  /// Community

  @GET("customer/{storeCode}/community_posts/home")
  Future<AllCommunityPost> getAllCommunityPost(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
  );

  @GET("customer/{storeCode}/community_posts/{communityPostId}")
  Future<CommunityPostRes> getCommunityPost(
    @Path("storeCode") String? storeCode,
    @Path("communityPostId") int communityPostId,
  );

  @POST("customer/{store_code}/community_post_like")
  Future<CommunityLikePostRes> sendLike(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("customer/{store_code}/community_posts")
  Future<PostArticlesRes> addCommunityPost(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("customer/{store_code}/community_posts/{communityPostId}")
  Future<PostArticlesRes> updateComunityPost(
      @Path("store_code") String? storeCode,
      @Path("communityPostId") int? communityPostId,
      @Body() Map<String, dynamic> body);

  @DELETE("customer/{store_code}/community_posts/{idPost}")
  Future<SuccessResponse> deleteCommnunityPost(
    @Path("store_code") String? storeCode,
    @Path("idPost") int? idPost,
  );

  @GET("customer/{store_code}/community_comments")
  Future<AllCommentCommunityRes> getAllCommentCommunity(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
    @Query("community_post_id") int communityPostId,
  );

  @POST("customer/{store_code}/community_comments")
  Future<CommentCommunityPost> addCommentCommunityPost(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @DELETE("customer/{store_code}/community_comments/{commentId}")
  Future<CommentCommunityPost> deleteCommentCommunityPost(
      @Path("store_code") String? storeCode, @Path() int commentId);

  @PUT("customer/{store_code}/community_comments/{idComment}")
  Future<CommentCommunityPost> updateCommentCommunity(
      @Path("store_code") String? storeCode,
      @Path() int? idComment,
      @Body() Map<String, dynamic> body);

  @GET("customer/{store_code}/community_posts")
  Future<AllCommunityPost> getPersonalCommunityPost(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
  );

  @GET("customer/{store_code}/friends")
  Future<FriendsListRes> getAllFriends(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
    @Query("customer_id") int customerId,
    @Query("search") String? search,
  );

  @GET("customer/{store_code}/community_customer_profile/{idCustomer}")
  Future<CommunityCustomerProfileRes> generalInformation(
    @Path("store_code") String? storeCode,
    @Path("idCustomer") int? idCustomer,
  );

  @GET("customer/{store_code}/friend_requests")
  Future<FriendRequestRes> getAllFriendRequest(
    @Path("store_code") String? storeCode,
    @Query("page") int numberPage,
  );

  @DELETE("customer/{store_code}/friends/{to_customer_id}")
  Future<SuccessResponse> deleteFriend(
    @Path("store_code") String? storeCode,
    @Path("to_customer_id") int? toCustomerId,
  );

  @GET("customer/{store_code}/community_posts/customer/{to_customer_id}")
  Future<AllCommunityCustomerRes> getAllCommunityCustomerPost(
    @Path("store_code") String? storeCode,
    @Path("to_customer_id") int? toCustomerId,
    @Query("page") int currentPage,
  );

  @GET("customer/{store_code}/friends/all/{customer_id}")
  Future<AllCustomerFriendRes> getAllCustomerFriend(
    @Path("store_code") String? storeCode,
    @Path("customer_id") int customerId,
    @Query("page") int currentPage,
  );

  @POST("customer/{store_code}/friend_requests")
  Future<SuccessResponse> addFriend(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @DELETE("customer/{store_code}/friend_requests/{customerId}")
  Future<SuccessResponse> deleteFriendRequest(
    @Path("store_code") String? storeCode,
    @Path("customerId") int customerId,
  );

  @POST("customer/{store_code}/friend_requests/{requestId}/handle")
  Future<SuccessResponse> handleFriendRequest(
    @Path("store_code") String? storeCode,
    @Path("requestId") int requestId,
    @Body() Map<String, dynamic> body,
  );

  /// Eduction
  @GET("customer/{store_code}/train_courses")
  Future<CourseListRes> getAllCourseList(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
  );

  @GET("customer/{store_code}/train_chapter_lessons/{id_list_courses}")
  Future<ListChapterAndLessonRes> getChaptersAndLessons(
    @Path("store_code") String? storeCode,
    @Path("id_list_courses") int idListCourses,
  );

  @GET("customer/{store_code}/lessons/{id}")
  Future<ListLessonRes> getLesson(
    @Path("store_code") String? storeCode,
    @Path("id") int idLesson,
  );

  @GET("customer/{store_code}/train_courses/{courseId}/quiz")
  Future<AllQuizRes> getAllQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int courseId,
  );

  @GET("customer/{store_code}/train_courses/{courseId}/quiz/{quizId}")
  Future<QuizRes> getQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int courseId,
    @Path("quizId") int quizId,
  );

  @GET(
      "customer/{store_code}/train_courses/{courseId}/quiz/{quizId}/history_submit")
  Future<AllHistorySubmitRes> getAllHistorySubmit(
    @Path("store_code") String? storeCode,
    @Path("courseId") int courseId,
    @Path("quizId") int quizId,
    @Query("page") int currentPage,
  );

  @POST("customer/{store_code}/train_courses/{courseId}/quiz/{quizId}/submit")
  Future<HistorySubmitRes> submitQuiz(
      @Path("store_code") String? storeCode,
      @Path("courseId") int courseId,
      @Path("quizId") int quizId,
      @Body() Map<String, dynamic> body);

  ////Mini Game
  @GET("customer/{store_code}/spin_wheels/{gameId}")
  Future<MiniGameRes> getMiniGame(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
  );

  @POST("customer/{store_code}/spin_wheels/{gameId}/play")
  Future<GiftWinningRes> playSpinWheel(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
  );
  @POST("customer/{store_code}/spin_wheels/{gameId}/player")
  Future<JoinMiniGameRes> joinMiniGame(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
  );
  @POST("customer/{store_code}/spin_wheels/{gameId}/get_turn")
  Future<GetTurnRes> getTurn(@Path("store_code") String? storeCode,
      @Path("gameId") int gameId, @Body() Map<String, dynamic> body);
  @GET("customer/{store_code}/spin_wheels/{gameId}/history_gift")
  Future<AllHistoryGiftRes> getAllHistoryGift(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
    @Query("page") int currentPage,
  );
  //////Guess Number Game
  @GET("customer/{store_code}/guess_numbers/{gameId}")
  Future<GuessNumberGameRes> getGuessNumberGame(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
  );

  @POST("customer/{store_code}/guess_numbers/{gameId}/player")
  Future<JoinGuessNumberRes> joinGuessGame(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
  );

  @POST("customer/{store_code}/guess_numbers/{gameId}/play")
  Future<PlayGuessGameRes> playGuessGame(@Path("store_code") String? storeCode,
      @Path("gameId") int gameId, @Body() Map<String, dynamic> body);

  @GET("customer/{store_code}/guess_numbers/{gameId}/history_guess_number")
  Future<AllHistoryGuessNumberRes> getAllHistoryGuessNumber(
    @Path("store_code") String? storeCode,
    @Path("gameId") int gameId,
    @Query("page") int currentPage,
  );

  @POST("customer/{storeCode}/dynamic_links/{id}")
  Future<SuccessResponse> handleDynamicLink(
    @Path("storeCode") String? storeCode,
    @Path("id") int id,
  );

  @GET("customer/{store_code}/branches")
  Future<AllBranchesRes> getAllBranches(
    @Path("store_code") String? storeCode,
  );
}
