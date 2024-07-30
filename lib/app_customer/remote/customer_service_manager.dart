import 'package:dio/dio.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../remote/customer_service.dart';
import '../remote/inteceptors/auth_interceptor.dart';

/// Class holds reference to Dio clients
class CustomerServiceManager {
  /// Singleton
  static final CustomerServiceManager _instance =
      CustomerServiceManager._internal();

  factory CustomerServiceManager() {
    return _instance;
  }

  CustomerServiceManager._internal();

  /// Service getter
  CustomerService? get service => _service;

  /// Dio client uses to perform normal requests
  Dio? dioClient;

  /// Dio client uses to perform upload requests
  Dio? uploadClient;
  CustomerService? _service;

  /// Initialzation function
  static void initialize() {
    _instance.getNewInstance();
  }

  /// Return the one and the only instance
  void getNewInstance() {
    var isRelease = StoreInfo().getIsRelease();
    final options = BaseOptions(receiveTimeout: Duration(seconds: 15));
    dioClient = Dio(options)
      ..interceptors.add(AuthInterceptor())
      ..interceptors;

    uploadClient = Dio(options);

    _service = CustomerService(
      dioClient!,
      baseUrl: isRelease == null
          ? "https://main.doapp.vn/api/"
          : "https://dev.doapp.vn/api/",
    );
  }
}
