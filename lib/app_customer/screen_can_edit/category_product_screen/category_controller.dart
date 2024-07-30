import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/thread_data.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../remote/response-request/search_history/all_search_history_response.dart';
import 'category_product_style_4/category_product_screen_4.dart';
import 'input_model_products.dart';

class CategoryController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var isLoadingProductMore = false.obs;
  var categories = RxList<Category>();
  var categoriesChild = RxList<Category>();
  var products = RxList<Product>();
  bool isEnd = false;
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
  late AutoScrollController controller;

  CategoryController(
      {this.categoryId,
      this.categoryChildId,
      this.textSearchInput,
      this.categoryChildInput}) {
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
        axis: Axis.horizontal);

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
        isRefresh: true,
        search: textSearch.value,
        sortBy: sortByShow.value,
        descending: descendingShow.value,
      );
    } else {
      getSearchHistory();
      getAllCategory();
      searchProduct(
          isRefresh: true,
          search: textSearch.value,
          sortBy: sortByShow.value,
          descending: descendingShow.value,
          idCategory:
              categoryCurrent.value != -1 ? categoryCurrent.value : null);
    }
  }

  void scrollToIndex() {
    var index = categories.indexWhere((e) => e.id == categoryCurrent.value);
    controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    controller.highlight(index);
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

  Future<bool?> searchProduct({
    String? search,
    bool? descending,
    String? sortBy,
    int? idCategory,
    int? idCategoryChild,
    bool? isRefresh,
  }) async {
    sortByCurrent = sortBy;
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
      isLoadingProduct.value = true;
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
    // isLoadingProduct.value = true;
    try {
      if (isEnd == false) {
        
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
                descending: sortBy == "price" ? descendingShow.value : false,
                sortBy: sortByShow.value == "" ? null : sortByShow.value))!;

        if (isRefresh == true) {
          products(res.data!.data);
          products.refresh();
        } else {
          products.addAll(res.data!.data!);
        }

        if (res.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }

        if (isChooseDiscountSort.value == true) {
          sortDiscount();
        }
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

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();
      categories(res!);
      if (categoryCurrent.value != -1) {
        setCategoryCurrent(
            categories.where((e) => e.id == categoryCurrent.value).first);
      }
      if (FlowData().isOnline()) {
        categories.insert(0, Category(name: "Tất cả", id: -1));
      }

      var index = categories.indexWhere((e) =>
          e.id == dataAppCustomerController.inputModelProducts!.categoryId);

      if (index != -1 && categories[index].listCategoryChild != null &&
          categories[index].listCategoryChild!.isNotEmpty) {
        Navigator.push(
          Get.context!,
          MaterialPageRoute(
              builder: (context) => CategoryProductStyle4(
                    textSearch: "",
                    categoryChildInput: categories[index].listCategoryChild,
                    categoryId: categories[index].id,
                  )),
        );
      }
      categories.refresh();
      scrollToIndex();
   
    } catch (err) {
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
