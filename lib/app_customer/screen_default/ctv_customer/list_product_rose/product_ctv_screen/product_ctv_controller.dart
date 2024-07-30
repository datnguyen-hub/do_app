import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_ios.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/data/example/product.dart';
import 'package:sahashop_customer/app_customer/model/combo.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/model/review.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/input_model.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/login_screen.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class ProductCtvController extends GetxController {
  var currentIndexListOrder = 0.obs;
  var currentImage = 0.obs;
  var isSeeMore = false.obs;
  var animateAddCart = false.obs;
  Product? productInput;
  InputModelProduct? inputModelProduct;
  var productShow = Product().obs;
  var listProductSimilar = RxList<Product>();
  var listProductWatched = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listProductCombo = RxList<ProductsCombo>();
  var hasInCombo = false.obs;
  var discountComboType = 0.obs;
  var valueComboType = 0.0.obs;
  var averagedStars = 0.0.obs;
  var totalReview = 0.obs;
  var listReview = RxList<Review>();
  var listImageReviewOfCustomer = RxList<List<dynamic>>([]);
  var listAllImageReview = RxList<String>();
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();

  ProductCtvController() {
    inputModelProduct = dataAppCustomerController.inputModelProduct;
    if (inputModelProduct == null ||
        (inputModelProduct!.product == null &&
            inputModelProduct!.productId == null)) {
      productShow.value = EXAMPLE_LIST_PRODUCT[0];
    } else {
      if (inputModelProduct!.product != null) {
        productInput = dataAppCustomerController.inputModelProduct!.product!;
      } else {
        productInput = Product(id: inputModelProduct!.productId);
      }

      getDetailProduct();
      getComboCustomer();
      getReviewProduct();
      getSimilarProduct();
      checkLogin();
    }
  }

  Future<void> urlToFile(List<String?>? listUrl) async {
    LoadingiOS().onLoading();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    imagePaths = [];
    if (listUrl != null) {
      for (int i = 0; i <= listUrl.length - 1; i++) {
        if (listUrl[i] != null) {
          print(listUrl[i]);
          File file = new File('$tempPath' + ('$i' + '.jpg'));
          http.Response response = await http.get(Uri.parse(listUrl[i]!));
          await file.writeAsBytes(response.bodyBytes);
          imagePaths.add(file.path);
          print(imagePaths);
          print(i);
          if (i == listUrl.length - 1) {
            Get.back();
            _onShare();
          }
        }
      }
    }
  }

  Future<void> _onShare() async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: productShow.value.contentForCollaborator ?? "",
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  Future<void> checkLogin() async {
    if (await CustomerInfo().hasLogged()) {
      getWatchedProduct();
    } else {
      return;
    }
  }

  Future<void> getWatchedProduct() async {
    try {
      var data = await CustomerRepositoryManager.productCustomerRepository
          .getWatchedProduct();
      listProductWatched(data!.data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getSimilarProduct() async {
    try {
      var data = await CustomerRepositoryManager.productCustomerRepository
          .getSimilarProduct(productInput!.id ?? 0);
      listProductSimilar(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getDetailProduct() async {
    isLoadingProduct.value = true;
    try {
      var res = await CustomerRepositoryManager.productCustomerRepository
          .getDetailProduct(productInput!.id ?? 0);
      productShow.value = res!.data ?? productInput!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
  }

  Future<void> favoriteProduct(bool isFavorite) async {
    try {
      var res = await CustomerRepositoryManager.favoriteRepository
          .favoriteProduct(productInput!.id ?? 0, isFavorite);
      if (isFavorite) {
        productShow.value.isFavorite = true;
        productShow.refresh();
        SahaAlert.showSuccess(message: "Đã thích");
      } else {
        productShow.value.isFavorite = false;
        productShow.refresh();
        SahaAlert.showSuccess(message: "Đã bỏ thích");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res!.data!.forEach((e) {
        int checkHasInCombo = e.productsCombo!.indexWhere(
                (element) => element.product!.id == productShow.value.id);
        if (checkHasInCombo != -1) {
          hasInCombo.value = true;

          /// 0 Co dinh, 1 theo %,
          discountComboType.value = e.discountType!;
          valueComboType.value = e.valueDiscount!.toDouble();
          listProductCombo(e.productsCombo!);
        }
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getReviewProduct() async {
    try {
      var data = await CustomerRepositoryManager.reviewCustomerRepository
          .getReviewProduct(
        productInput!.id ?? 0,
        "",
        "",
        null,
      );
      averagedStars.value = data!.data!.averagedStars!;
      totalReview.value = data.data!.totalReviews!;
      listReview(data.data!.data);
      listReview.forEach((review) {
        try {
          listImageReviewOfCustomer.add(jsonDecode(review.images!));
        } catch (err) {
          listImageReviewOfCustomer.add([]);
        }
      });
      listImageReviewOfCustomer.forEach((listImage) {
        listImage.forEach((imageLink) {
          listAllImageReview.add(imageLink);
        });
      });
      print("=============== ${listImageReviewOfCustomer}");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void animatedAddCard() {
    animateAddCart.value = true;
    print(animateAddCart.value);
    Future.delayed(Duration(milliseconds: 1000), () {
      animateAddCart.value = false;
      print(animateAddCart.value);
    });
  }

  void changeIndexImage(int value) {
    currentImage.value = value;
  }

  void onchangeSeeMore() {
    isSeeMore.value = !isSeeMore.value;
  }

  void addItemCart() {
    cartController.addItemCart(productShow.value.id, 1, []);
  }

  Future<void> addManyItemOrUpdate(
      {int? quantity,
        bool? buyNow,
        List<DistributesSelected>? distributesSelected,
        required int productId,
        int? lineItemId}) async {
    DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.isLogin.value == false) {
      await Get.to(() => LoginScreenCustomer());
    }
    await cartController.addItemCart(
        productId, quantity!, distributesSelected!.toList());
    Get.back();
    if (buyNow == true) {
      Get.to(() => CartScreen());
    }
  }
}
