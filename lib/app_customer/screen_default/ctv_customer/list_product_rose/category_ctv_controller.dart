import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/input_model_products.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/thread_data.dart';


class CategoryCtvController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var isLoadingProductMore = false.obs;
  var categories = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = (-1).obs;
  var textSearch = "".obs;
  var sortByShow = "views".obs;
  var descendingShow = true.obs;
  var currentPage = 1;
  var isChooseDiscountSort = false.obs;
  var canLoadMore = true;
  String? sortByCurrent;

  TextEditingController textEditingControllerSearch = TextEditingController();

  CategoryController() {
    final DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.inputModelProducts != null &&
        dataAppCustomerController.inputModelProducts!.categoryId != null) {
      categoryCurrent.value =
          dataAppCustomerController.inputModelProducts!.categoryId!;
      if (mapTypeActionSort[
              dataAppCustomerController.inputModelProducts!.filterProducts] ==
          "discount") {
        isChooseDiscountSort.value = true;
      } else if (mapTypeActionSort[
              dataAppCustomerController.inputModelProducts!.filterProducts] !=
          null) {
        sortByShow.value = mapTypeActionSort[
            dataAppCustomerController.inputModelProducts!.filterProducts];
      }
    }
  }

  void init() {
    super.onInit();
    getAllCategory();
    searchProduct(
        search: textSearch.value,
        sortBy: sortByShow.value,
        descending: descendingShow.value,
        idCategory: categoryCurrent.value != -1 ? categoryCurrent.value : null);
  }

  void sortDiscount() async {
    if (isChooseDiscountSort.value) {
      List<Product> listProductDiscount = [];
      products.forEach((element) {
        if (element.productDiscount != null) {
          listProductDiscount.add(element);
        }
      });
      products(listProductDiscount);
    }
  }

  Future<bool?> searchProduct(
      {String? search,
      bool? descending,
      String? sortBy,
      int? idCategory,
      bool isLoadMore = false}) async {
    sortByCurrent = sortBy;
    if (isLoadMore == false) {
      currentPage = 1;
      canLoadMore = true;
      isLoadingProduct.value = true;
    }

    if (isLoadMore == true) {
      if (canLoadMore == false) return true;
      isLoadingProductMore.value = true;
    }

    var categoryId = "";
    categories.forEach((element) {
      if (idCategory != null && idCategory == element.id) {
        categoryCurrent(element.id);
        categoryId = idCategory.toString();
      }
    });
    if (search != null) {
      textSearch(search);
    }

    if (descending != null) {
      descendingShow(descending);
    }

    if (sortBy != null) {
      sortByShow(sortBy);
    }

    try {
      var list = (await CustomerRepositoryManager.productCustomerRepository
          .searchProduct(
              page: currentPage,
              search: textSearch.value,
              idCategory: categoryCurrent.value == -1
                  ? ""
                  : categoryCurrent.value.toString(),
              descending: sortBy == "price" ? descendingShow.value : true,
              sortBy: sortByShow.value))!;

      var listPro = list.data!.data!.where((element) => element.percentCollaborator != null && element.percentCollaborator != 0).toList();

      if (isLoadMore == false) {
        products(listPro);
      } else {
        products.addAll(listPro);
        products.refresh();
      }

      if (list.data!.data!.length < 20) {
        canLoadMore = false;
      } else {
        currentPage++;
      }

      if (isChooseDiscountSort.value == true) {
        sortDiscount();
      }

      isLoadingProduct.value = false;
      isLoadingProductMore.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
    isLoadingProductMore.value = false;
    return null;
  }

  void setCategoryCurrent(Category category) {
    isLoadingProduct.value = true;
    categoryCurrent.value = category.id ?? -1;
  }

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();
      categories(res!);
      if (FlowData().isOnline()) {
        categories.insert(0, Category(name: "Tất cả", id: null));
      }
      categories.refresh();
    } catch (err) {
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
