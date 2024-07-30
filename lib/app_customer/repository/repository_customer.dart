import '../repository/address_repository/address_repository.dart';
import '../repository/cart/cart_repository.dart';
import '../repository/category/category_repository.dart';
import '../repository/chat_customer/chat_repository.dart';
import '../repository/config_app/config_ui_respository.dart';
import '../repository/info_customer/info_customer_repository.dart';
import '../repository/login/login_repository.dart';
import '../repository/marketing_chanel/marketing_repository.dart';
import '../repository/orders/order_repository.dart';
import '../repository/payment/payment_repository.dart';
import '../repository/product/product_respository.dart';
import '../repository/register/register_repository.dart';
import '../repository/review/review_repository.dart';
import '../repository/shipment/shipment_repository.dart';
import '../repository/otp/otp_repository.dart';
import 'agency_customer/agency_customer_repository.dart';
import 'badge/badge_repository.dart';
import 'community_repository/community_repository.dart';
import 'ctv/ctv_repository.dart';
import 'device_token/device_token_repository.dart';
import 'education/education_repository.dart';
import 'favorite/favorite_repository.dart';
import 'history_search/history_search_repository.dart';
import 'home/home_repository.dart';
import 'image/image_repository.dart';
import 'mini_game_repository/mini_game_repository.dart';
import 'notification/notification_repository.dart';
import 'point/piont_repository.dart';
import 'post/post_repository.dart';
import 'report/report_repository.dart';
import 'score/score_repository.dart';

class CustomerRepositoryManager {
  static CategoryRepository get categoryRepository => CategoryRepository();
  static FavoriteRepository get favoriteRepository => FavoriteRepository();
  static ConfigUICustomerRepository get configUiRepository =>
      ConfigUICustomerRepository();
  static OtpRepository get otpRepository => OtpRepository();
  static ProductCustomerRepository get productCustomerRepository =>
      ProductCustomerRepository();
  static OrderCustomerRepository get orderCustomerRepository =>
      OrderCustomerRepository();
  static HomeDataRepository get homeDataCustomerRepository =>
      HomeDataRepository();
  static PostCustomerRepository get postCustomerRepository =>
      PostCustomerRepository();
  static DeviceTokenRepository get deviceTokenRepository =>
      DeviceTokenRepository();
  static RegisterCustomerRepository get registerCustomerRepository =>
      RegisterCustomerRepository();
  static LoginCustomerRepository get loginCustomerRepository =>
      LoginCustomerRepository();
  static InfoCustomerRepository get infoCustomerRepository =>
      InfoCustomerRepository();
  static ChatCustomerRepository get chatCustomerRepository =>
      ChatCustomerRepository();
  static MarketingRepository get marketingRepository => MarketingRepository();
  static CartRepository get cartRepository => CartRepository();
  static AddressRepository get addressRepository => AddressRepository();
  static ShipmentRepository get shipmentRepository => ShipmentRepository();
  static PaymentRepository get paymentRepository => PaymentRepository();
  static HistorySearchRepository get historySearchRepository =>
      HistorySearchRepository();
  static ReviewCustomerRepository get reviewCustomerRepository =>
      ReviewCustomerRepository();
  static BadgeRepository get badgeRepository => BadgeRepository();
  static ScoreRepository get scoreRepository => ScoreRepository();
  static ImageRepository get imageRepository => ImageRepository();
  static CtvCustomerRepository get ctvCustomerRepository =>
      CtvCustomerRepository();
  static PointRepository get pointRepository => PointRepository();
  static NotificationCusRepository get notificationCusRepository =>
      NotificationCusRepository();
  static AgencyCustomerRepository get agencyCustomerRepository =>
      AgencyCustomerRepository();
  static ReportRepository get reportRepository => ReportRepository();
  static CustomerCommunityRepository get customerCommunityRepository =>
      CustomerCommunityRepository();
  static EducationRepository get educationRepository => EducationRepository();
  static MiniGameRepository get miniGameRepository => MiniGameRepository();
}
