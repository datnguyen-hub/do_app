import 'dart:convert';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/data/example/product.dart';
import 'package:sahashop_customer/app_customer/model/combo.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/model/review.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/login/login_screen.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';
import '../../model/bonus_product.dart';
import '../../screen_default/confirm_screen/confirm_screen.dart';
import 'input_model.dart';

class ProductController extends GetxController {
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
  var bonusProduct = BonusProduct().obs;
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();

  ProductController() {
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
      getReviewProduct();
      getSimilarProduct();
      checkLogin();
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
      getComboCustomer();
      getBonusCustomer();
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
        var checkHasInCombo = e.productsCombo!.indexWhere(
            (element) => element.product!.id == productShow.value.id);
        if (checkHasInCombo != -1) {
          print('===============?');
          hasInCombo.value = true;
          isLoadingProduct.refresh();

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

  Future<void> getBonusCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getBonusCustomer(productId: productInput?.id);

      res!.data!.forEach((e) {
        if (e.ladderReward == false) {
          var checkHasInCombo = e.selectProducts!.indexWhere(
              (element) => element.product!.id == productShow.value.id);
          if (checkHasInCombo != -1) {
            bonusProduct(e);
          }
        } else {
          var checkHasInCombo = e.bonusProductsLadder!.indexWhere(
              (element) => element.product!.id == productShow.value.id);
          if (checkHasInCombo != -1) {
            bonusProduct(e);
          }
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
    Get.back();
    DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.isLogin.value == false) {
      await Get.to(() => LoginScreenCustomer());
    } else {
      await cartController.addItemCart(
          productId, quantity!, distributesSelected!.toList());
      if (buyNow == true) {
        Get.to(() => CartScreen());
        Get.to(() => ConfirmScreen());
      }
    }
  }
}
