import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/toast/saha_alert.dart';
import '../../../../model/attribute_search.dart';
import '../../../../model/category.dart';
import '../../../../model/product.dart';
import '../../../../remote/response-request/search_history/all_search_history_response.dart';
import '../../../../repository/handle_error.dart';
import '../../../../repository/repository_customer.dart';
import '../../../../screen_default/data_app_controller.dart';
import '../../../../utils/thread_data.dart';
import '../../input_model_products.dart';
import '../category_product_screen_4.dart';

class SearchDataController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var isLoadingProductMore = false.obs;
  var categories = RxList<Category>();
  var categoriesChild = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = (-1).obs;
  var categoryCurrentChild = (-1).obs;
  var textSearch = "".obs;
  var sortByShow = "".obs;
  var descendingShow = true.obs;
  var currentPage = 1;
  var isChooseDiscountSort = false.obs;
  var canLoadMore = true;
  var isDown = false.obs;
  String? sortByCurrent;
  var histories = RxList<HistorySearch>();
  var listAttributeSearch = RxList<AttributeSearch>();
  var listAttributeSearchChoose = RxList<AttributeSearch>([]);

  TextEditingController textEditingControllerSearch = TextEditingController();

  String? textSearchInput;
  int? categoryId;
  int? categoryChildId;
  List<Category>? categoryChildInput;
  final DataAppCustomerController dataAppCustomerController = Get.find();
  SearchDataController(
      {this.categoryId,
      this.categoryChildId,
      this.textSearchInput,
      this.categoryChildInput}) {
    getAttributeSearch();

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
    if (categoryChildInput != null) {
      categories(categoryChildInput);
      textSearch.value = textSearchInput ?? "";
      textEditingControllerSearch.text = textSearchInput ?? "";
      categoryCurrent.value = categoryId ?? -1;
      categoryCurrentChild.value = categoryChildId ?? -1;
      if (categoryChildInput!.length == 1) {
        categoryCurrentChild.value = categoryChildInput![0].id ?? 0;
      }
      searchProduct(
        search: textSearch.value,
        sortBy: sortByShow.value,
        descending: descendingShow.value,
      );
    } else {
      textSearch.value = textSearchInput ?? "";
      getSearchHistory();
      searchProduct(
          search: textSearch.value,
          sortBy: sortByShow.value,
          descending: descendingShow.value,
          idCategory:
              categoryCurrent.value != -1 ? categoryCurrent.value : null);
    }
  }

  void addSearchHistory(String? text) async {
    if (text != null && text.length > 0) {
      try {
        await CustomerRepositoryManager.historySearchRepository
            .addHistorySearch(text);
      } catch (err) {}
    }
  }

  void deleteSearchHistory() async {
    try {
      await CustomerRepositoryManager.historySearchRepository
          .deleteHistorySearch();
    } catch (err) {}
  }

  void getSearchHistory() async {
    try {
      var data = await CustomerRepositoryManager.historySearchRepository
          .get10HistorySearch();
      histories(data);
    } catch (err) {}
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

  Future<void> getAttributeSearch() async {
    try {
      var data = await CustomerRepositoryManager.productCustomerRepository
          .getAttributeSearch();
      listAttributeSearch(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> searchProduct(
      {String? search,
      bool? descending,
      String? sortBy,
      int? idCategory,
      int? idCategoryChild,
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
      var res = (await CustomerRepositoryManager.productCustomerRepository
          .searchProduct(
              page: currentPage,
              search: textSearch.value,
              hasDiscount: isChooseDiscountSort.value,
              listAttributeSearch: listAttributeSearchChoose.isNotEmpty
                  ? listAttributeSearchChoose
                      .map((e) => e.id)
                      .toList()
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll(" ", "")
                  : null,
              idCategory: categoryCurrent.value == -1
                  ? null
                  : categoryCurrent.value.toString(),
              idCategoryChild: categoryCurrentChild.value == -1
                  ? null
                  : categoryCurrentChild.value.toString(),
              descending: sortBy == "price" ? descendingShow.value : true,
              sortBy: sortByShow.value == "" ? null : sortByShow.value))!;

      if (isLoadMore == false) {
        products(res.data!.data);
      } else {
        products.addAll(res.data!.data!);
        products.refresh();
      }

      if (res.data!.data!.length < 20) {
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
    categoryCurrent.value = category.id ?? -1;
    categoryCurrentChild.value = -1;
    if (category.id == null) {
      categoriesChild([]);
    } else {
      categoriesChild(category.listCategoryChild);
    }
  }

  void setCategoryCurrentChild(Category category) {
    isLoadingProduct.value = true;
    categoryCurrentChild.value = category.id ?? -1;
    if (category.id == null) {
      categoriesChild([]);
    } else {
      categoriesChild(category.listCategoryChild);
    }
  }
}
