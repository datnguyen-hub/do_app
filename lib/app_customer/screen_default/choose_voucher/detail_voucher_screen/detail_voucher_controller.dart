import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class DetailVoucherController extends GetxController {
  final int? voucherId;
   var loadInit = false.obs;
  var listProductVoucher = RxList<Product>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  DetailVoucherController({this.voucherId}) {
   
  }
 
}
